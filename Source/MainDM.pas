unit MainDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, FMTBcd, DBClient, MidasLib,
  Windows, ImgList, Controls, PngImageList, ActnList, RzCommon,
  DBXpress, Provider;

type
  ToctType = (octOK, octMissingFile, octInvalidFile);
  TDMUser = (dmuProducts, dmuCustomers, dmuInvoices, dmuCollections,
             dmuReports, dmuPurchases, dmuTowns, dmuSalesCredit, dmuSalesReps,
             dmuCollectors);
  TDMUsers = set of TDMUser;

  //----------
  TRecordEditData = record
    cds, cdsEd: TClientDataSet;
    fid, fidvalue: string;
    act: TAction;
    pFormOked: Pointer;
  end;

  //----------
  TdmMain = class(TDataModule)
    SQLConnection1: TSQLConnection;
    SQLQrNextID: TSQLQuery;
    SQLMonitor1: TSQLMonitor;
    PngImageList1: TPngImageList;
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    PngImageList2: TPngImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLConnection1AfterConnect(Sender: TObject);
  private
    FLastReportName: string;
    RzRegIni: TRzRegIniFile;
    RzPropertyStore: TRzPropertyStore;
    FVersionsChecked: Boolean;
    FOnline: Boolean;
    procedure SetPKProperty;
    procedure LoadSavePKProperty(OptionSave: Integer = 1);
  public
    ClientNewVersion, SalesRepNewVersion, TownNewVersion, CollectorNewVersion: integer;
    property LastReportName: string read FLastReportName write FLastReportName;
    property Online: Boolean read FOnline write FOnline;
    procedure cdsApplyUpdates(ASqlConnection: TSQLConnection; cds:
        TCustomClientDataSet);
    procedure IDGetText(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure DBErrorHandler( Sender : TObject; E: Exception );
    function GetNextPK(SaveAfterFetch: Boolean = True): Integer;
    procedure cdsGenReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    function ShowRecordEdit(RecordEditData: TRecordEditData; const pMode: Integer = -1): Boolean;
    procedure PKSave;
    function GoodConnection: Boolean;
    procedure Connect(AServer, ADBName: string; Reset: Boolean = False);
    function Connected: Boolean;
    procedure cdsDetailOpen(CDS: TClientDataSet; AMasterSource: TDataSource;
        AMasterID, AIndexFldN: string);
    function OpenCachedTable(cds: TClientDataSet; localfn: string): ToctType;
    procedure cdsApplyMDUpdates(ASqlConnection: TSQLConnection; cds1, cds2:
        TCustomClientDataSet);
    procedure cdsDeleteRecord(connection: tsqlconnection; cds: tclientdataset; isConfirm: Boolean = true; const delMessage: string = '');
  end;

var
  dmMain: TdmMain;

implementation

uses
  uAppSettings, Forms, Dialogs, ChangeDBU, AppSettingsU;

const
  _DeleteThisRecord = 'Delete this record?';

{$R *.dfm}

procedure TdmMain.cdsApplyUpdates(ASqlConnection: TSQLConnection; cds:
    TCustomClientDataSet);
var
  bError: Boolean;
  TD: TTransactionDesc;
begin
  with ASqlConnection do begin
    TD.TransactionID := 1;
    td.IsolationLevel := xilREADCOMMITTED;
    if not InTransaction then StartTransaction(TD);
    try
      bError := cds.ApplyUpdates(0) > 0;
      if not bError then Commit(TD);
    finally
      if InTransaction then Rollback(TD);
    end;
  end
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var
  hiid_, loid_ : integer;
begin

  SQLConnection1.Connected := false;

  AppSettings.PngImageList := PngImageList2;
  hiid_ := AppSettings.IDHigh;
  loid_ := AppSettings.IDLow;
  LoadSavePKProperty(0);  //load id values
  if AppSettings.IDHigh < hiid_ then begin
    AppSettings.IDHigh := hiid_; AppSettings.IDLow := loid_ end;

  FOnline := True;
end;

procedure TdmMain.DBErrorHandler(Sender: TObject; E: Exception);
begin   {
  if E is EDBClient then
  begin

    if Pos('Key violation',e.Message) > 0 then
      MessageDlg('Duplicate record.',  mtWarning, [mbOK], 0)
    else if Pos('violation of FOREIGN KEY',e.Message) > 0 then
      MessageDlg('Delete not allowed. Record is in use.',  mtWarning, [mbOK], 0)
  end
  else   }
    ApplicationShowException(e);
end;


function TdmMain.GetNextPK(SaveAfterFetch: Boolean): Integer;
var
  LowID: integer;
  HighID: Integer;
const
  MAXLOWID : Integer = 99999;
  MAXHIGHID : Integer = 21473;

  function GetNextHighFromDB: Integer;
  {
    Notes on Firebird 1.5:
    2147483647    Integer type max value
    21474/83647
    21473  99999  21,473 high values starting from 1 (server generator)
                  99,999 max low id (maintain locally)
  }
  var
    SQLQueryHighID : TSQLQuery;
    HighIDGen: string;
  begin
    Result := -1;
    HighIDGen := AppSettings.IDHighGeneratorname;
    SQLQueryHighID := TSQLQuery.Create(Self);
    with SQLQueryHighID do
    try
      SQLConnection := SQLConnection1;
      SQL.Add('select GEN_ID( ' +HighIDGen+ ',1) from RDB$DATABASE');
      try
        Open;
        Result := Fields[0].AsInteger;
      except
      end;
    finally
      Free;
    end;
  end;

begin
  HighID := AppSettings.IDHigh;
  LowID := AppSettings.IDLow + 1;
  if ((LowID = 0) OR (LowID > MAXLOWID) OR (HighID = 0)) then begin
    HighID := GetNextHighFromDB;
    if HighID = -1 then
      raise Exception.Create('[HighID] Unable to obtain key from database.');
    if HighID > MAXHIGHID then
      raise Exception.Create('[HighID] System overrun.');
    LowID := 1;
    AppSettings.IDHigh := HighID;
  end;
  AppSettings.IDLow := LowID;
  Result := HighID * (MAXLOWID +1) + LowID;
  if SaveAfterFetch then LoadSavePKProperty; // disable when fetching PKs in succession
end;

procedure TdmMain.IDGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if (((Sender As TField).IsNull)
  or  ((Sender As TField).Value < 0)) then
    Text := '<New>' else
    Text := (Sender as TField).AsString;
end;


procedure TdmMain.cdsGenReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
var
  _message: string;
begin    {
  if Pos('violation of FOREIGN KEY', e.Message) > 0 then
    _message := 'Delete not allowed. Record is in use.'
  else if Pos('system data', e.Message) > 0 then
    _message := 'System data. Edit or delete not allowed.'
  else if Pos('NO_DELETE_DATA_IN_USE', e.Message) > 0 then
    _message := 'Delete not allowed. Record is in use.'
  else if Pos('UNIQUE KEY', E.Message) > 0 then
    _message := 'Can''t save; duplicate record found.'
  else    }
    _message := e.Message;
  MessageDlg(_message, mtWarning, [mbOK], 0);
  if UpdateKind = ukDelete  then
    Action := raCancel
  else
    Action := raSkip;
end;


function TdmMain.GoodConnection: Boolean;
begin
  Result := False;
  try
    //SQLConnection1.Open;
    if not Connected then
      Connect(AppSettings.Server, AppSettings.Database);
    Result := True;
  except
    on e:exception do begin
      if (Pos('OPEN',UpperCase(e.message)) > 0) or (Pos('HOST',UpperCase(e.message))>0)
         or (Pos('DATABASE',UpperCase(e.message))>0) then
      begin
        MessageDlg( 'Failed to connect to database '#13#10+ AppSettings.Server + ':' + AppSettings.Database,
          mtInformation, [mbOK], 0);
        with TfmChangeDB.Create(nil) do
        try
          if ShowModal = mrOk then Result := True;
        finally
          Free;
        end;
      end else
        raise e;
    end;
  end;
end;

//----------------------
function TdmMain.ShowRecordEdit(RecordEditData: TRecordEditData; const pMode: Integer = -1): Boolean;
//general purpose cds record editor
var
  editAllowed: Boolean;
  cds, cdsEd: TClientDataSet;
  fid, fidvalue: string;
  act: TAction;
  pFormOked: ^Boolean;
begin
  //---- change these vars
  cds       := RecordEditData.cds;
  cdsEd     := RecordEditData.cdsEd;
  fid       := RecordEditData.fid;
  fidvalue  := RecordEditData.fidvalue;
  act       := RecordEditData.act;
  pFormOked := RecordEditData.pFormOked;
  //----------------------------

  editAllowed := True;
  if pMode = -1 then
    raise Exception.Create('Indicate the following mode:'#13#10'1 = Insert; 2 = Edit');
  {
  if pMode = 1 then
    cdsEd.Append
  else
  }
  if pMode = 2 then
    begin
      if (cds.Bof and cds.Eof) then
        editAllowed := False else
        cdsEd.Locate(fid,fidvalue,[]);
    end;
  if editAllowed then
  begin
    cdsEd.Edit;
    act.Execute;
  end;
  Result := editAllowed and pFormOked^;
  if Result and (pMode = 1) and (cds<>cdsEd) then
    cds.Locate(fid,cdsEd[fid],[]);
end;
                           

procedure TdmMain.Connect(AServer, ADBName: string; Reset: Boolean = False);
begin

  if Reset then begin
    SQLConnection1.Connected := False;
  end;

  SQLConnection1.Params.Values['database'] := AServer +':'+ ADBName;

  SQLConnection1.Connected := True;
end;

function TdmMain.Connected: Boolean;
begin
  Result := SQLConnection1.Connected {and UniConnection1.Connected};
end;

procedure TdmMain.SetPKProperty;
begin
  RzPropertyStore.Section := 'HILOPK';
  RzPropertyStore.AddProperty(AppSettings,'idhigh');
  RzPropertyStore.AddProperty(AppSettings,'idlow');
end;

procedure TdmMain.LoadSavePKProperty(OptionSave: Integer);
begin
  RzRegIni := TRzRegIniFile.Create(Self);
  RzPropertyStore := TRzPropertyStore.Create(Self);
  RzPropertyStore.RegIniFile := RzRegIni;
  SetPKProperty;
  try
    if OptionSave = 1 then
      RzPropertyStore.Save else
      RzPropertyStore.Load;
  finally
    RzPropertyStore.Free;
    RzRegIni.Free;
  end;
end;

procedure TdmMain.PKSave;
begin
  LoadSavePKProperty();
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  PKSave;
end;

procedure TdmMain.cdsDetailOpen(CDS: TClientDataSet; AMasterSource:
    TDataSource; AMasterID, AIndexFldN: string);
begin
  with CDS do begin
    if AIndexFldN <> '' then
      IndexFieldNames := '';
    MasterSource := nil;
    MasterFields := '';
    Open;
    if AIndexFldN <> '' then
      IndexFieldNames := AIndexFldN;
    MasterSource := AMasterSource;
    MasterFields := AMasterID;
  end;
end;

procedure TdmMain.SQLConnection1AfterConnect(Sender: TObject);
begin
  // check local file versions
  if (not FVersionsChecked) then
  begin
    with ClientDataSet1 do
    begin
      Open;
      if Locate('NAME','VER_CLIENT',[]) then begin
        ClientNewVersion := FieldByName('VERSION').Value;
      end;
      if Locate('NAME','VER_SALESREP',[]) then begin
        SalesRepNewVersion := FieldByName('VERSION').Value;
      end;
      if Locate('NAME','VER_TOWN',[]) then begin
        TownNewVersion := FieldByName('VERSION').Value;
      end;
      if Locate('NAME','VER_COLLECTOR',[]) then begin
        CollectorNewVersion := FieldByName('VERSION').Value;
      end;
    end;

    FVersionsChecked := True;
  end;
end;



function TdmMain.OpenCachedTable(cds: TClientDataSet; localfn: string): ToctType;
begin
  Result := octMissingFile;
  if FileExists(localfn) then
    begin
      try
        if cds.Active then
          cds.Close;
        cds.LoadFromFile(localfn);
        Result := octOK;
      except
        Result := octInvalidFile;
      end;
    end
end;

procedure TdmMain.cdsApplyMDUpdates(ASqlConnection: TSQLConnection; cds1, cds2:
    TCustomClientDataSet);
var
  bError: Boolean;
  TD: TTransactionDesc;
begin
  with ASqlConnection do begin
    TD.TransactionID := 1;
    td.IsolationLevel := xilREADCOMMITTED;
    if not InTransaction then StartTransaction(TD);
    try
      bError := cds1.ApplyUpdates(0) > 0;
      bError := bError or (cds2.ApplyUpdates(0) > 0);
      if not bError then Commit(TD);
    finally
      if InTransaction then Rollback(TD);
    end;
  end
end;

procedure TdmMain.cdsDeleteRecord(connection: tsqlconnection; cds: tclientdataset; isConfirm: Boolean = true; const delMessage: string = '');
begin
  if (not isConfirm) or (isConfirm and (MessageDlg(_DeleteThisRecord,  mtConfirmation, [mbYes, mbNo], 0) =
    mrYes)) then
    begin
      cds.Delete;
      dmMain.cdsApplyUpdates(connection,cds);
    end;
end;

end.
