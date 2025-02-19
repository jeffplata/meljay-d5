unit CustomerDM;

interface

uses
  SysUtils, Classes, ActnList, Controls, DBClient,
  Provider, DB, SqlExpr, Dialogs, Forms, frxClass, frxDBSet,
  ReportVariablesU, QueryConditionU, MainDM, StdCtrls, FMTBcd, dmi_Generic;

type

  TdmCustomer = class(TdmiGeneric)
    ActionList1: TActionList;
    actShowCustomerMgr: TAction;
    actShowCustomerEditCds: TAction;
    actShowCustomerGroupMgr: TAction;
    actShowSalesRepMgr: TAction;
    actShowSalesRepEditor: TAction;
    cdsCust: TClientDataSet;
    sdsCust: TSQLDataSet;
    dspCust: TDataSetProvider;
    actShowAddressMgr: TAction;
    frxReport1: TfrxReport;
    frxDBCustomer: TfrxDBDataset;
    sqlCustRpt: TSQLDataSet;
    dspCustRpt: TDataSetProvider;
    cdsCustRpt: TClientDataSet;
    cdsClientTypeLkup: TClientDataSet;
    cdsClientTypeLkupNAME: TStringField;
    cdsClientTypeLkupVALUE: TStringField;
    dsClientType: TDataSource;
    cdsSRLkup: TClientDataSet;
    sqlSRLkup: TSQLDataSet;
    dspSRLkup: TDataSetProvider;
    cdsSRLkupCLIENT_ID: TIntegerField;
    cdsSRLkupCLIENT_NAME: TStringField;
    dsSRLkup: TDataSource;
    sqlTownLkup: TSQLDataSet;
    dspTownLkup: TDataSetProvider;
    cdsTownLkup: TClientDataSet;
    cdsTownLkupTOWN_ID: TIntegerField;
    cdsTownLkupTOWN: TStringField;
    cdsTownLkupPROVINCE: TStringField;
    cdsSRLkupTOWN_ID: TIntegerField;
    cdsSRLkupPHONE: TStringField;
    cdsSRLkupAGENT_ID: TIntegerField;
    cdsSRLkupCLIENT_TYPE: TStringField;
    cdsSRLkupADDRESS: TStringField;
    sqlProvinces: TSQLDataSet;
    dspProvinces: TDataSetProvider;
    cdsProvinces: TClientDataSet;
    cdsTownLkupTOWNPROVINCE: TStringField;
    cdsSRLkupTOWNPROVINCE: TStringField;
    cdsSRLkupCOMPLETEADDRESS: TStringField;
    sqldCollectorLkup: TSQLDataSet;
    dspCollectorLkup: TDataSetProvider;
    cdsCollectorLkup: TClientDataSet;
    cdsCollectorLkupCLIENT_ID: TIntegerField;
    cdsCollectorLkupCLIENT_NAME: TStringField;
    cdsCollectorLkupSTREET_ADDRESS: TStringField;
    cdsCollectorLkupADDRESS: TStringField;
    cdsCollectorLkupTOWN_ID: TIntegerField;
    cdsCollectorLkupPHONE: TStringField;
    cdsCollectorLkupAGENT_ID: TIntegerField;
    cdsCollectorLkupCLIENT_TYPE: TStringField;
    cdsCollectorLkupCOMPLETEADDRESS: TStringField;
    cdsCollectorLkupTOWNPROVINCE: TStringField;
    cdsCollectorLkupCLIENTTYPEDESC: TStringField;
    cdsCollectorLkupAGENTNAME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure actShowCustomerEditCdsExecute(Sender: TObject);
    procedure actShowSalesRepMgrExecute(Sender: TObject);
    procedure actShowSalesRepEditorExecute(Sender: TObject);
    procedure cdsCust_EditNewRecord(DataSet: TDataSet);
    procedure dspCustBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure actShowCustomerMgrExecute(Sender: TObject);
    procedure dspCustGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure cdsCustBeforeOpen(DataSet: TDataSet);
    procedure dspTownLkupBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure cdsTownLkupNewRecord(DataSet: TDataSet);
//    procedure actShowTownMgrExecute(Sender: TObject);
    procedure dspTownLkupUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsSRLkupNewRecord(DataSet: TDataSet);
    procedure cdsCust_EditBeforePost(DataSet: TDataSet);
    procedure dspSRLkupBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure dspCustUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsCustBeforeClose(DataSet: TDataSet);
    procedure cdsTownLkupBeforeClose(DataSet: TDataSet);
    procedure dspCollectorLkupBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure dspCollectorLkupGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: String);
    procedure dspCollectorLkupUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsSRLkupBeforeClose(DataSet: TDataSet);
    procedure cdsCollectorLkupBeforeClose(DataSet: TDataSet);
    procedure cdsTownLkupBeforePost(DataSet: TDataSet);
  private
    FCustGroupVersion: Integer;
    ActiveUsers: TDMUsers;
    CustomerID: Integer;
    TownID: Integer;
    FReportVars: TReportVariables;
    InsertingCustomer: Boolean;
    InsertingSalesRep: Boolean;
    ClientLocalFN: string;
    TownLocalFN: string;
    SalesRepLocalFN: string;
    CollectorLocalFN: string;
    CustBaseSQL: string;
    FResultCountCust: Integer;
    function Open(AUser: TDMUser):Boolean;
    procedure OpenCustomers; overload;
    procedure OpenTowns; overload;
    procedure OpenSalesReps; overload;
    procedure OpenCollectors; overload;
    function SelectCustomer1(const akeybuffer: string): Variant;
    function SelectSalesRep1(const akeybuffer: string): Variant;
    procedure SetResultCountCust(const Value: Integer);
  public
    CopyBuffer_Customer: Variant;
    SelectedGroup: Variant;
    SelectedSalesRep: Variant;
    SelectedCustomer: Variant;
    SelectedAddress: Variant;
    SelectedTown: Variant;
    SelectedCollector: Variant;
    LastCustEditOk: Boolean;
    CustomerKeybuffer: string;
    SalesRepKeybuffer: string;
    TownMgrKeyBuffer: string;
    FilterStrName: string;
    FilterStrAddress: string;
    property CustGroupVersion: integer read FCustGroupVersion;
    property ResultCountCust: Integer read FResultCountCust write
        SetResultCountCust;
    class procedure Close(AUser: TDMUser);
    class function OpenCustomers(AUser: TDMUser; ForceOpen: Boolean = False): Boolean; overload;
    class function OpenTowns(AUser: TDMUser): boolean; overload;
    class function OpenSalesReps(AUser: TDMUser): Boolean; overload;
    class function OpenCollectors(AUser: TDMUser): Boolean; overload;
    procedure PrintReport( ReportSectionName: string; DataSet: TDataSet );
    procedure CopyFromBuffer;
    function SelectSalesRep( const keybuffer: string = ''): Variant;
    function SelectCustomer( const keybuffer: string = ''): Variant;
    function SelectTown( const akeybuffer: string = ''): Variant;
    function SelectTownEx( Acds: TCustomClientDataSet; const aKeybuffer: string = ''): Variant; overload;
    function SelectTownEx( AEdit: TCustomEdit; const aKeyBuffer: string = ''): Variant; overload;
    function SelectCollector( const Akeybuffer: string = ''): Variant;
    procedure EditSalesRep( newRecord: Boolean = False; SRName: string = '' );
    procedure EditCollector;
    procedure FilterCustomer(const Condition: string);
    procedure OpenCustomer;
    function SelectCustomerEx( Acds: TCustomClientDataSet; const aKeybuffer: string = ''): Variant; overload;
    function SelectCustomerEx( AEdit: TCustomEdit; const aKeyBuffer: string = ''): Variant; overload;
    function SelectSalesRepEx( Acds: TCustomClientDataSet; const aKeybuffer: string = ''): Variant; overload;
    function SelectSalesRepEx( AEdit: TCustomEdit; const aKeyBuffer: string = ''): Variant; overload;

//    function LookupCustomer( ACustomerID: Integer ): string;
  end;

var
  dmCustomer: TdmCustomer;

const
  CUST_BUFFER_FIELDS = 'STREET_ADDRESS;ADDRESS;TOWN_ID;TownProvince;CLIENT_TYPE;AGENT_ID;AGENTNAME';

  SQL_CUST = 'select FIRST %d c.*, coalesce(c.street_address||'' '','''')||coalesce(c.address||'' '','''')||t.town_province completeaddress, '
            +' ag.client_name agent_name from client c'
            +' join town t on t.town_id=c.town_id'
            +' join client ag on ag.client_id = c.agent_id';
  SQL_CUST_FIRST_100 = 'select FIRST 100 c.*, coalesce(c.street_address||'' '','''')||coalesce(c.address||'' '','''')||t.town_province completeaddress, '
            +' ag.client_name agent_name from client c'
            +' join town t on t.town_id=c.town_id'
            +' join client ag on ag.client_id = c.agent_id';

implementation

uses Misc, CustomerEditCdsU,
  SalesRepMgr, 
  CustomerMgrCdsU, AddressMgrU, Variants, BigIni, uAppSettings,
  ReportsDM, TownMgrU, vfi_itemmanagerCDS, SalesRepEdit, CollectorMgr,
  CollectorEdit, FilterCDS;

{$R *.dfm}

procedure TdmCustomer.DataModuleCreate(Sender: TObject);
var
  fnPref: string;
begin
  ResultCountCust := 500;
  //CustBaseSQL := Format(SQL_CUST,[ResultCountCust]);

  fnPref := ExtractFilePath(ParamStr(0));
  ClientLocalFN    := fnPref + 'client.dat';
  TownLocalFN      := fnPref + 'town.dat';
  SalesRepLocalFN  := fnPref + 'salesrep.dat';
  CollectorLocalFN := fnPref + 'collector.dat';

  cdsClientTypeLkup.Close;
  cdsClientTypeLkup.CreateDataSet;
  cdsClientTypeLkup.AppendRecord(['SR','Sales Rep']);
  cdsClientTypeLkup.AppendRecord(['CU','Customer']);
  cdsClientTypeLkup.AppendRecord(['DI','Distributor']);
  cdsClientTypeLkup.AppendRecord(['CO','Collector']);

  cdsCust.OnReconcileError      := dmMain.cdsGenReconcileError;
  cdsSRLkup.OnReconcileError    := dmMain.cdsGenReconcileError;
  cdsTownLkup.OnReconcileError  := dmMain.cdsGenReconcileError;
  cdsCollectorLkup.OnReconcileError := dmMain.cdsGenReconcileError;

  cdsTownLkup.FieldByName('TOWN_ID').OnGetText := dmMain.IDGetText;
  cdsSRLkup.FieldByName('CLIENT_ID').OnGetText := dmMain.IDGetText;

  FReportVars := TReportVariables.Create(Self);
  frxReport1.EngineOptions.UseGlobalDataSetList := False;

end;

function TdmCustomer.Open(AUser: TDMUser): Boolean;
begin
  Result := True;
  try
    if not Assigned(dmCustomer) then
      dmCustomer := TdmCustomer.Create(Application);
    if not (AUser in dmCustomer.ActiveUsers) then
      dmCustomer.ActiveUsers := dmCustomer.ActiveUsers + [AUser];
  except
    Result := False;
  end;
end;

class procedure TdmCustomer.Close(AUser: TDMUser);
begin
  if Assigned(dmCustomer) then
  begin
    if AUser in dmCustomer.ActiveUsers then
      dmCustomer.ActiveUsers := dmCustomer.ActiveUsers - [AUser];
    if dmCustomer.ActiveUsers = [] then
    begin
      with dmCustomer do begin
        if cdsCust.Active then cdsCust.Close;
        if cdsSRLkup.Active then cdsSRLkup.Close;
        if cdsCollectorLkup.Active then cdsCollectorLkup.Close;
        if cdsTownLkup.Active then cdsTownLkup.Close;
      end;
      FreeAndNil(fmCustomerEditCDS);
      FreeAndNil(fmCustomerMgrCds);
      FreeAndNil(fmAddressMgr);
      FreeAndNil(fmTownMgr);
      FreeAndNil(fmSalesRepMgr);

      if Assigned(dmReports) then TdmReports.Close(dmuCustomers);

      FreeAndNil(dmCustomer);
    end;
  end;
end;

procedure TdmCustomer.actShowCustomerEditCdsExecute(Sender: TObject);
begin
  if not Assigned(fmCustomerEditCDS) then
    fmCustomerEditCDS := TfmCustomerEditCDS.Create(nil);
  LastCustEditOk := (fmCustomerEditCDS.ShowModal = mrOk);
  with cdsCust{_Edit} do begin
    if LastCustEditOk then
    begin
      if InsertingCustomer then
        CopyBuffer_Customer := cdsCust{_Edit}[CUST_BUFFER_FIELDS];
      if ChangeCount > 0 then
        cdsCust{_Edit}.ApplyUpdates(0);
    end
    else
      CancelUpdates;
  end;
  InsertingCustomer := False;
end;

procedure TdmCustomer.actShowSalesRepMgrExecute(Sender: TObject);
begin
  if not Assigned(fmSalesRepMgr) then
    fmSalesRepMgr := TfmSalesRepMgr.Create(nil,'CLIENT_NAME','CLIENT_ID;CLIENT_NAME');
  fmSalesRepMgr.KeyBuffer := SalesRepKeybuffer;
  fmSalesRepMgr.ShowModal;
    SelectedSalesRep := fmSalesRepMgr.SelectedFieldValues;
  SalesRepKeybuffer := '';
end;

procedure TdmCustomer.actShowSalesRepEditorExecute(Sender: TObject);
begin
  with TfmSalesRepEdit.Create(nil) do
  try
    if ShowModal = mrOk then begin
      try
        cdsSRLkup.ApplyUpdates(0);
      finally
        cdsSRLkup.cancelupdates;
      end
    end else
      cdsSRLkup.CancelUpdates;
  finally
    Free;
  end;
end;

procedure TdmCustomer.EditSalesRep( newRecord: Boolean = False; SRName: string = '' );
begin
  if newRecord then begin
    cdsSRLkup.Append;
    cdsSRLkup.FieldByName('CLIENT_NAME').AsString := SRName;
  end;
  actShowSalesRepEditor.Execute;
end;

procedure TdmCustomer.cdsCust_EditNewRecord(DataSet: TDataSet);
begin
  Dec(CustomerID);
  with DataSet do begin
    FieldByName('CLIENT_ID').AsInteger := CustomerID;
    FieldByName('CLIENT_TYPE').AsString := 'CU';
  end;
  InsertingCustomer := True;
end;

procedure TdmCustomer.dspCustBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('CLIENT_ID').NewValue < 0) then
     begin
       DeltaDS.FieldByName('CLIENT_ID').NewValue :=  dmMain.GetNextPK;
     end
end;

procedure TdmCustomer.actShowCustomerMgrExecute(Sender: TObject);
begin
  if not Assigned(fmCustomerMgrCds) then
    fmCustomerMgrCds := tfmCustomerMgrCds.Create(nil,'CLIENT_NAME',
      'CLIENT_ID;CLIENT_NAME;AGENT_ID;AgentName;TOWN_ID;TownProvince');
  fmCustomerMgrCds.KeyBuffer := CustomerKeybuffer;
  fmCustomerMgrCds.ShowModal;
  CustomerKeybuffer := '';
  SelectedCustomer := fmCustomerMgrCds.SelectedFieldValues;
end;


class function TdmCustomer.OpenCustomers(AUser: TDMUser; ForceOpen: Boolean = False): Boolean;
begin
  Result := True;
  dmCustomer.Open(AUser);
  try
    if not dmCustomer.cdsCust.Active or ForceOpen then
      dmCustomer.OpenCustomers;
  except
    Result := False;
    TdmCustomer.Close(AUser);
  end;
end;

procedure TdmCustomer.OpenCustomers;
var
  oldIndexName: string;
  openRemote: Boolean;
  octResult: ToctType;
begin
  oldIndexName := cdsCust.IndexName;
  cdsCust.IndexName := '';

  openRemote := True;
  if AppSettings.VersionClient = dmMain.ClientNewVersion then begin
    octResult := dmMain.OpenCachedTable(cdsCust, ClientLocalFN);
    if octResult = octOk then openRemote := False;
    if octResult = octInvalidFile then begin
      AppSettings.VersionClient := -1;
      MessageDlg('Invalid local Client file.',  mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

  if openRemote then begin
     cdsCust.Close;
     cdsCust.Open;
     cdsCust.SaveToFile(ClientLocalFN);
     AppSettings.VersionClient := dmMain.ClientNewVersion;
   end;

  if oldIndexName <> '' then
  begin
    SortCDS( cdsCust,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;

  cdsCust.FieldByName('CLIENT_ID').OnGetText := dmMain.IDGetText;

end;

procedure TdmCustomer.dspCustGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'CLIENT';
end;

procedure TdmCustomer.cdsCustBeforeOpen(DataSet: TDataSet);
begin
  cdsTownLkup.FieldByName('TOWN_ID').OnGetText := dmMain.IDGetText;
  cdsSRLkup.FieldByName('CLIENT_ID').OnGetText := dmMain.IDGetText;
end;

procedure TdmCustomer.PrintReport(ReportSectionName: string; DataSet: TDataSet);
var
  sl: TStringList;
  s: string;
  ConditionList: TConditionList;
  sCond: string;
begin
  // todo: place meljay.sql in appsettings
  with TBiggerIniFile.Create('reports\meljay.sql') do
  try
    sl := TStringList.Create;
    with sl do
    try
      ReadSectionValues(ReportSectionName,sl);
      s := sl.Text;
    finally
      Free;
    end;
  finally
    Free;
  end;

  FReportVars.Variables['CLIENT_ID'] := cdsCust.FieldByName('CLIENT_ID').AsString;
  FReportVars.Variables['ASOFDATE']  := QuotedStr( DateToStr(Date) );

  s := FReportVars.ExpandVariables(s);

  if ReportSectionName = 'cus_Balances_where' then
  begin
    ConditionList := TConditionList.Create(Self);
    ConditionList['C_ADDRESS'].Condition := 'ADDRESS||'' ''||TOWN_PROVINCE containing ''{CL_ADDRESS}''';
    ConditionList['C_ADDRESS'].Active    := (FilterstrAddress <> '');
    ConditionList.Variables['CL_ADDRESS'] := FilterStrAddress;
    Conditionlist['C_NAME'].Condition    := 'CLIENT_NAME containing ''{CL_NAME}''';
    ConditionList['C_NAME'].Active       := (FilterstrName <> '');
    ConditionList.Variables['CL_NAME']   := FilterStrName;
    sCond := ConditionList.ExpandCondition;
    ConditionList.Free;
    
    TdmReports.Open(dmuCustomers);
    if sCond <> '' then s := s + ' WHERE '+ sCond;
    dmReports.SQLDataSet1.CommandText := s;
    ReportSectionName :=  'cus_Balances';
    with dmReports.frxReport1 do
    begin
      LoadFromFile('reports\'+ReportSectionName+'.fr3');
      Script.Variables['COMPANY_NAME']  := AppSettings.CompanyName;
      Script.Variables['CUSTOMER_NAME'] := cdsCust.fieldbyname('CLIENT_NAME').AsString;
      Script.Variables['ASOFDATE']      := Date;
      ShowReport(True);
    end;
  end else
  begin
    sqlCustRpt.CommandText := s;
    with frxreport1 do
    begin
      LoadFromFile('reports\'+ReportSectionName+'.fr3');
      Script.Variables['COMPANY_NAME']  := AppSettings.CompanyName;
      Script.Variables['CUSTOMER_NAME'] := cdsCust.fieldbyname('CLIENT_NAME').AsString;
      Script.Variables['ASOFDATE']      := Date;
      ShowReport(True);
    end;
  end;
end;

procedure TdmCustomer.CopyFromBuffer;
begin
  //quick copy data from last inserted customer buffer
  cdsCust.Edit;
  cdsCust[CUST_BUFFER_FIELDS] := CopyBuffer_Customer;
end;

procedure TdmCustomer.dspTownLkupBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('TOWN_ID').NewValue < 0) then
     begin
       DeltaDS.FieldByName('TOWN_ID').NewValue := dmMain.GetNextPK;
     end
end;

procedure TdmCustomer.cdsTownLkupNewRecord(DataSet: TDataSet);
begin
  Dec(TownID);
  with cdsTownLkup do
    FieldByName('TOWN_ID').AsInteger := TownID;
end;

//procedure TdmCustomer.actShowTownMgrExecute(Sender: TObject);
//begin
//  if not Assigned(fmTownMgr) then
//    fmTownMgr := TfmTownMgr.Create(nil,'TownProvince ','TOWN_ID;TownProvince');
//  fmTownMgr.KeyBuffer := TownMgrKeyBuffer;
//  if fmTownMgr.ShowModal = mrOk then
//    SelectedTown := fmTownMgr.SelectedFieldValues;
//end;

procedure TdmCustomer.dspTownLkupUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('TOWNPROVINCE').ProviderFlags := [];
end;


procedure TdmCustomer.cdsSRLkupNewRecord(DataSet: TDataSet);
begin
  Dec(CustomerID);
  with DataSet do begin
    FieldByName('CLIENT_ID').AsInteger := CustomerID;
    FieldByName('CLIENT_TYPE').AsString := 'SR';
  end;
  InsertingSalesRep := True;
end;

procedure TdmCustomer.cdsCust_EditBeforePost(DataSet: TDataSet);
begin
  if DataSet = cdsCust{_Edit} then
    with cdsCust{_Edit} do begin
      if (FieldByName('CLIENT_TYPE').AsString = 'CU') and
         (FieldByName('AGENT_ID').AsString = '') then
        raise Exception.Create('''Sales Rep'' required.');
      FieldByName('COMPLETEADDRESS').Value :=  Trim(
        fieldbyname('STREET_ADDRESS').AsString + ' ' +
        fieldbyname('ADDRESS').AsString + ' ' +
        fieldbyname('TOWNPROVINCE').AsString
        );
    end;
end;


procedure TdmCustomer.dspSRLkupBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('CLIENT_ID').NewValue < 0) then
     begin
       DeltaDS.FieldByName('CLIENT_ID').NewValue :=  dmMain.GetNextPK;
     end
end;

function TdmCustomer.SelectSalesRep(const keybuffer: string): Variant;
begin
  Result := Unassigned;
  SalesRepKeybuffer := keybuffer;
  actShowSalesRepMgr.Execute;
  SalesRepKeybuffer := '';
  Result := SelectedSalesRep;
end;

function TdmCustomer.SelectCustomer(const keybuffer: string): Variant;
begin
  Result := Unassigned;
  CustomerKeybuffer := keybuffer;
  actShowCustomerMgr.Execute;
  CustomerKeybuffer := '';
  Result := SelectedCustomer;
end;

function TdmCustomer.SelectTown(const akeybuffer: string): Variant;
begin
  Result := Unassigned;
  if TdmCustomer.OpenTowns(dmuTowns) then
  begin
    with TfmTownMgr.Create(nil,'TownProvince ','TOWN_ID;TownProvince') do
    try
      DataSource1.DataSet := dmCustomer.cdsTownLkup;
      KeyBuffer := akeybuffer;
      ShowModal;
    finally
      Result := SelectedFieldValues;
      Free;
    end;
  end;
end;

function TdmCustomer.SelectTownEx(Acds: TCustomClientDataSet; const akeybuffer: string = ''): Variant;
var
  town: Variant;
begin
  Result := Unassigned;
  town := dmCustomer.SelectTown(aKeybuffer);
  if not VarIsEmpty(town) then begin
    if not (acds.State in [dsInsert,dsEdit]) then Acds.Edit;
    acds.FieldByName('TOWN_ID').AsString := town[0];
    acds.FieldByName('TOWNPROVINCE').AsString := town[1];
  end;
  Result := town;
end;

function TdmCustomer.SelectTownEx( AEdit: TCustomEdit; const aKeyBuffer: string = ''): Variant;
var
  town: Variant;
begin
  Result := Unassigned;
  town := dmCustomer.SelectTown(aKeybuffer);
  if not VarIsEmpty(town) then begin
    TCustomEdit(AEdit).Text := town[1];
  end;
  Result := town;
end;

//function TdmCustomer.LookupCustomer(ACustomerID: Integer): string;
//begin
//  Result := cdsCust.Lookup('CLIENT_ID', ACustomerID, 'CLIENT_NAME');
//  if VarIsEmpty(Result) then
//    Result := '';
//end;

class function TdmCustomer.OpenTowns(AUser: TDMUser): Boolean;
begin
  Result := True;
  dmCustomer.Open(AUser);
  try
    if not dmCustomer.cdsTownLkup.Active then
      dmCustomer.OpenTowns;
  except
    Result := False;
    TdmCustomer.Close(AUser);
  end;
end;

procedure TdmCustomer.OpenTowns;
var
  openRemote : Boolean;
  octResult: ToctType;
begin
  openRemote := True;
  if AppSettings.VersionTown = dmMain.TownNewVersion then begin
    octResult := dmMain.OpenCachedTable(cdsTownLkup, TownLocalFN);
    if octResult = octOk then openRemote := False;
    if octResult = octInvalidFile then begin
      AppSettings.VersionTown := -1;
      MessageDlg('Invalid local Municipalities file.',  mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

  if openRemote then begin
     cdsTownLkup.Close;
     cdsTownLkup.Open;
     cdsTownLkup.SaveToFile(TownLocalFN);
     AppSettings.VersionTown := dmMain.TownNewVersion;
   end;
end;

procedure TdmCustomer.dspCustUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('COMPLETEADDRESS').ProviderFlags := [];
  DataSet.FieldByName('TOWNPROVINCE').ProviderFlags := [];
  DataSet.FieldByName('CLIENTTYPEDESC').ProviderFlags := [];
  DataSet.FieldByName('AGENTNAME').ProviderFlags := [];
  DataSet.FieldByName('CLIENTTYPEDESC').ProviderFlags := [];
end;

procedure TdmCustomer.cdsCustBeforeClose(DataSet: TDataSet);
begin
  cdsCust.SaveToFile(ClientLocalFN);
end;

procedure TdmCustomer.cdsTownLkupBeforeClose(DataSet: TDataSet);
begin
  cdsTownLkup.SaveToFile(TownLocalFN);
end;

procedure TdmCustomer.OpenSalesReps;
var
  openRemote : Boolean;
  octResult: ToctType;
begin
  openRemote := True;
  if AppSettings.VersionSalesRep = dmMain.SalesRepNewVersion then begin
    octResult := dmMain.OpenCachedTable(cdsSRLkup, SalesRepLocalFN);
    if octResult = octOk then openRemote := False;
    if octResult = octInvalidFile then begin
      AppSettings.VersionSalesRep := -1;
      MessageDlg('Invalid local Sales Rep file.',  mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

  if openRemote then begin
     cdsSRLkup.Close;
     cdsSRLkup.Open;
     cdsSRLkup.SaveToFile(SalesRepLocalFN);
     AppSettings.VersionSalesRep := dmMain.SalesRepNewVersion;
   end;
end;

class function TdmCustomer.OpenSalesReps(AUser: TDMUser): Boolean;
begin
  Result := True;
  dmCustomer.Open(AUser);
  try
    if not dmCustomer.cdsSRLkup.Active then
      dmCustomer.OpenSalesReps;
  except
    Result := False;
    TdmCustomer.Close(AUser);
  end;
end;

class function TdmCustomer.OpenCollectors(AUser: TDMUser): Boolean;
begin
  Result := True;
  dmCustomer.Open(AUser);
  try
    if not dmCustomer.cdsCollectorLkup.Active then
      dmCustomer.OpenCollectors;
  except
    Result := False;
    TdmCustomer.Close(AUser);
  end;
end;

procedure TdmCustomer.OpenCollectors;
var
  openRemote : Boolean;
  octResult: ToctType;
begin
  openRemote := True;
  if AppSettings.VersionCollector = dmMain.CollectorNewVersion then begin
    octResult := dmMain.OpenCachedTable(cdsCollectorLkup, CollectorLocalFN);
    if octResult = octOk then openRemote := False;
    if octResult = octInvalidFile then begin
      AppSettings.VersionCollector := -1;
      MessageDlg('Invalid local Collectors file.',  mtWarning, [mbOK], 0);
      Abort;
    end;
  end;

  if openRemote then begin
     cdsCollectorLkup.Close;
     cdsCollectorLkup.Open;
     cdsCollectorLkup.SaveToFile(CollectorLocalFN);
     AppSettings.VersionCollector := dmMain.CollectorNewVersion;
   end;
end;

function TdmCustomer.SelectCollector(const aKeybuffer: string): Variant;
begin
  Result := Unassigned;

  if TdmCustomer.OpenCollectors(dmuCollectors) then begin
    with TfmCollectorMgr.Create(nil,'CLIENT_NAME','CLIENT_ID;CLIENT_NAME') do
    try
      DataSource1.DataSet := dmCustomer.cdsCollectorLkup;
      KeyBuffer := Akeybuffer;
      ShowModal;
    finally
      Result := SelectedFieldValues;
      Free;
    end;
  end;

  dmcustomer.SelectedCollector := Result;
end;

procedure TdmCustomer.dspCollectorLkupBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('CLIENT_ID').NewValue < 0) then
     begin
       DeltaDS.FieldByName('CLIENT_ID').NewValue := dmMain.GetNextPK;
     end
end;

procedure TdmCustomer.dspCollectorLkupGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'CLIENT';
end;

procedure TdmCustomer.dspCollectorLkupUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('COMPLETEADDRESS').ProviderFlags := [];
  DataSet.FieldByName('TOWNPROVINCE').ProviderFlags := [];
  DataSet.FieldByName('CLIENTTYPEDESC').ProviderFlags := [];
  DataSet.FieldByName('AGENTNAME').ProviderFlags := [];
  DataSet.FieldByName('CLIENTTYPEDESC').ProviderFlags := [];
end;

procedure TdmCustomer.EditCollector;
begin
  with TfmCollectorEdit.Create(nil) do
  try
    if ShowModal = mrOk then begin
      if cdsCollectorLkup.ApplyUpdates(0) = 0 then
      else
        cdsCollectorLkup.CancelUpdates;
    end else
      cdsCollectorLkup.CancelUpdates;
  finally
    Free;
  end;
end;

procedure TdmCustomer.cdsSRLkupBeforeClose(DataSet: TDataSet);
begin
  TClientDataSet(DataSet).SaveToFile(SalesRepLocalFN);
end;

procedure TdmCustomer.cdsCollectorLkupBeforeClose(DataSet: TDataSet);
begin
  TClientDataSet(DataSet).SaveToFile(CollectorLocalFN);
end;

procedure TdmCustomer.cdsTownLkupBeforePost(DataSet: TDataSet);
begin
  with cdsTownLkup do
    FieldByName('TOWNPROVINCE').AsString :=
      fieldbyname('TOWN').AsString +' '+ fieldbyname('PROVINCE').AsString;
end;

procedure TdmCustomer.FilterCustomer(const Condition: string);
begin
  FilterCDSDBX(cdsCust,CustBaseSQL,Condition);
end;

procedure TdmCustomer.OpenCustomer;
begin
  FilterCDSDBX(cdsCust,CustBaseSQL,'');
end;


function TdmCustomer.SelectCustomer1(const akeybuffer: string): Variant;
begin
  Result := Unassigned;
  if TdmCustomer.OpenCustomers(dmuCustomers) then
  begin
    with TfmCustomerMgrCds.Create(nil,'CLIENT_NAME ',
      'CLIENT_ID;CLIENT_NAME;AGENT_ID;AgentName;TOWN_ID;TownProvince') do
    try
      DataSource1.DataSet := dmCustomer.cdsCust;
      KeyBuffer := akeybuffer;
      if ShowModal = mrOk then
        Result := SelectedFieldValues;
    finally
      Free;
    end;
  end;
end;


function TdmCustomer.SelectCustomerEx( Acds: TCustomClientDataSet; const aKeybuffer: string = ''): Variant;
var
  customer: Variant;
begin
  Result := Unassigned;
  customer := dmCustomer.SelectCustomer1(aKeybuffer);
  if not VarIsEmpty(customer) then begin
    if not (acds.State in [dsInsert,dsEdit]) then Acds.Edit;
    acds.FieldByName('CLIENT_ID').AsString := customer[0];
    acds.FieldByName('CLIENT_NAME').AsString := customer[1];
  end;
  Result := customer;
end;

function TdmCustomer.SelectCustomerEx( AEdit: TCustomEdit; const aKeyBuffer: string = ''): Variant;
var
  customer: Variant;
begin
  Result := Unassigned;
  customer := dmCustomer.SelectCustomer1(aKeybuffer);
  if not VarIsEmpty(customer) then begin
    TCustomEdit(AEdit).Text := customer[1];
  end;
  Result := customer;
end;

function TdmCustomer.SelectSalesRep1(const akeybuffer: string): Variant;
begin
  Result := Unassigned;
  if TdmCustomer.OpenCustomers(dmuCustomers) then
  begin
    with TfmSalesRepMgr.Create(nil,'CLIENT_NAME','CLIENT_ID;CLIENT_NAME') do
    try
      DataSource1.DataSet := dmCustomer.cdsSRLkup;
      KeyBuffer := akeybuffer;
      if ShowModal = mrOk then
        Result := SelectedFieldValues;
    finally
      Free;
    end;
  end;
end;

function TdmCustomer.SelectSalesRepEx(Acds: TCustomClientDataSet;
  const aKeybuffer: string): Variant;
var
  resultvar: Variant;
begin
  Result := Unassigned;
  resultvar := dmCustomer.SelectSalesRep1(aKeybuffer);
  if not VarIsEmpty(resultvar) then begin
    if not (acds.State in [dsInsert,dsEdit]) then Acds.Edit;
    acds.FieldByName('CLIENT_ID').AsString   := resultvar[0];
    acds.FieldByName('CLIENT_NAME').AsString := resultvar[1];
  end;
  Result := resultvar;
end;

function TdmCustomer.SelectSalesRepEx(AEdit: TCustomEdit;
  const aKeyBuffer: string): Variant;
var
  resultVar: Variant;
begin
  Result := Unassigned;
  resultVar := dmCustomer.SelectSalesRep1(aKeybuffer);
  if not VarIsEmpty(resultVar) then begin
    TCustomEdit(AEdit).Text := resultVar[1];
  end;
  Result := resultVar;
end;

procedure TdmCustomer.SetResultCountCust(const Value: Integer);
var
  oldvalue: integer;
begin
  oldvalue := FResultCountCust;
  FResultCountCust := Value;
  if oldvalue <> FResultCountCust then
  begin
    cdsCust.Close;
    CustBaseSQL := Format(SQL_CUST,[FResultCountCust]);
  end;
end;

end.

