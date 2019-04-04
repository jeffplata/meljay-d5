unit SalesCreditDM;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr, MainDM, Forms,
  ActnList, Controls;

type

  TdmSalesCredit = class(TDataModule)
    sqlSalesCr: TSQLDataSet;
    dspSalesCr: TDataSetProvider;
    cdsSalesCr: TClientDataSet;
    dsSalesCr: TDataSource;
    cdsSalesCrLines: TClientDataSet;
    sqlSalesCrLines: TSQLDataSet;
    ActionList1: TActionList;
    actShowSalesCreditEdit: TAction;
    cdsSalesCrLinesSALES_CR_LINES_ID: TIntegerField;
    cdsSalesCrLinesSALES_CR_ID: TIntegerField;
    cdsSalesCrLinesPRODUCT_ID: TIntegerField;
    cdsSalesCrLinesQTY: TFMTBCDField;
    cdsSalesCrLinesSALES_DOC_NO: TStringField;
    cdsSalesCrLinesPRICE_UNIT: TFMTBCDField;
    sqlCollectibles: TSQLDataSet;
    dspCollectibles: TDataSetProvider;
    cdsCollectibles: TClientDataSet;
    cdsCollectiblesTXN_NUMBER: TStringField;
    cdsCollectiblesTXN_DATE: TDateField;
    cdsCollectiblesPRODUCT_ID: TIntegerField;
    cdsCollectiblesQTYOUT: TFMTBCDField;
    cdsCollectiblesPRICE_UNIT: TFMTBCDField;
    cdsCollectiblesCLIENT_ID: TIntegerField;
    cdsCollectiblesProductDesc: TStringField;
    cdsCollectiblesPRICE_TOTAL: TFMTBCDField;
    cdsSalesCrLinesSumPriceTotal: TAggregateField;
    dspSalesCrLines: TDataSetProvider;
    cdsSalesCrSALES_CR_ID: TIntegerField;
    cdsSalesCrSALES_CR_NUMBER: TStringField;
    cdsSalesCrSALES_CR_DATE: TDateField;
    cdsSalesCrSALES_CR_AMOUNT: TFMTBCDField;
    cdsSalesCrCLIENT_ID: TIntegerField;
    cdsSalesCrCLIENTNAME: TStringField;
    cdsSalesCrLinesPRODUCTNAME: TStringField;
    cdsSalesCrLinesPRICETOTAL: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure actShowSalesCreditEditExecute(Sender: TObject);
    procedure cdsSalesCr_EditNewRecord(DataSet: TDataSet);
//    procedure cdsSalesCrCalcFields(DataSet: TDataSet);
    procedure dspSalesCrBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure cdsSalesCrLinesNewRecord(DataSet: TDataSet);
    procedure cdsSalesCrLinesAfterDelete(DataSet: TDataSet);
    procedure cdsSalesCrLinesPostError(DataSet: TDataSet;
      E: EDatabaseError; var Action: TDataAction);
    procedure cdsSalesCrLinesBeforePost(DataSet: TDataSet);
    procedure dspSalesCrGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure dspSalesCrLinesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: String);
    procedure dspSalesCrUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure dspSalesCrLinesUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsSalesCrLinesAfterPost(DataSet: TDataSet);
  private
    DMUsers: TDMUsers;
    RecordEditData: TRecordEditData;
    InsertingSalesCr: Boolean;
    LastEditOked: Boolean;
    SalesCreditID: Integer;
    SalesCreditLinesID: Integer;
    LastSalesCreditMasterPK: Integer;
  public
    class procedure Open( DMUser: TDMUser );
    class procedure Close( DMUser: TDMUser );
    procedure OpenSalesCr;
    procedure CloseSalesCr;
    procedure DeleteSalesCredit;
    procedure EditSalesCredit;
    procedure FilterSalesCredits( parameters: array of variant );
  end;

var
  dmSalesCredit: TdmSalesCredit;

implementation

uses
  Misc, SalesCreditEdit, CustomerDM, ProductsDM, Dialogs, DBXpress,
  uAppSettings;

const
  SALESCR_DELETE_LINE_SQL = 'delete from SALES_CREDIT_LINES where SALES_CR_ID = %d';

{$R *.dfm}

class procedure TdmSalesCredit.Close(DMUser: TDMUser);
begin
  if Assigned(dmSalesCredit) then
  begin
    with dmSalesCredit do begin
      if DMUser in DMUsers then DMUsers := DMUsers - [DMUser];
      if DMUsers = [] then
      begin
        //freeandnil forms
        FreeAndNil(fmSalesCreditEdit);
        TdmCustomer.Close(dmuSalesCredit);
        TdmProducts.Close(dmuSalesCredit);
        //cdsCollectibles.Close;
        FreeAndNil(dmSalesCredit);
      end;
    end;
  end;
end;

procedure TdmSalesCredit.CloseSalesCr;
begin
  TdmProducts.Close(dmuSalesCredit);
  cdsSalesCr.Close;
end;

procedure TdmSalesCredit.DataModuleCreate(Sender: TObject);
begin
  cdsSalesCr.OnReconcileError := dmMain.cdsGenReconcileError;
  cdsSalesCrLines.OnReconcileError := dmMain.cdsGenReconcileError;
  sqlSalesCr.CommandText := 'select * from '+
    'SEL_SALES_CREDIT(:start_date,:end_date,:client_id,:number)';
end;

procedure TdmSalesCredit.EditSalesCredit;
begin
  RecordEditData.cds       := cdsSalesCr;
  RecordEditData.cdsed     := cdsSalesCr;
  RecordEditData.fid       := 'SALES_CR_ID';
  RecordEditData.act       := actShowSalesCreditEdit;
  RecordEditData.pFormOked := @LastEditOked;

  RecordEditData.fidvalue  := RecordEditData.cds.fieldbyname(RecordEditData.fid).AsString;

  if RecordEditData.cdsed.State = dsInsert then
    dmMain.ShowRecordEdit(RecordEditData,1)
  else
    dmMain.ShowRecordEdit(RecordEditData,2);
end;

class procedure TdmSalesCredit.Open(DMUser: TDMUser);
begin
  if not Assigned(dmSalesCredit) then begin
    dmSalesCredit := TdmSalesCredit.Create(Application);
  end;
  //TdmCustomer.Open(dmuSalesCredit);
  TdmCustomer.OpenCustomers(dmuSalesCredit);

  if not (DMUser in dmSalesCredit.DMUsers) then
    dmSalesCredit.DMUsers := dmSalesCredit.DMUsers + [DMUser];
end;

procedure TdmSalesCredit.OpenSalesCr;
var
  oldIndexName: string;
begin

  TdmProducts.Open(dmuSalesCredit);

  oldIndexName := cdsSalesCr.IndexName;
  cdsSalesCr.IndexName := '';

  //cdsCollectibles.Close;
  with cdsSalesCr do
    if Active then Refresh else Open;
  with cdsSalesCrLines do
    if Active then Refresh else
      dmMain.CDSDetailOpen(cdsSalesCrLines,dsSalesCr,'SALES_CR_ID','');

  if oldIndexName <> '' then
  begin
    SortCDS( cdsSalesCr,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;

  //cdsSalesCr.First;

  if not cdsCollectibles.Active then
    cdsCollectibles.Open;

  cdsSalesCr.FieldByName('SALES_CR_ID').OnGetText := dmMain.IDGetText;

end;

procedure TdmSalesCredit.actShowSalesCreditEditExecute(Sender: TObject);
var
  bError: Boolean;
  TD: TTransactionDesc;
  i: integer;
begin
  cdsSalesCrLines.AggregatesActive := True;
  cdsSalesCr.Edit;
  if not Assigned(fmSalesCreditEdit) then
    fmSalesCreditEdit := tfmSalesCreditEdit.Create(Self);

  try
    if fmSalesCreditEdit.ShowModal = mrOk then begin
      if InsertingSalesCr then begin
        AppSettings.LastNoSalesCredit := cdsSalesCr.fieldbyname('SALES_CR_NUMBER').AsString;
      end;
      with SQLSalesCr.SQLConnection do begin
        TD.TransactionID := 1;
        td.IsolationLevel := xilREADCOMMITTED;
        if not InTransaction then
          StartTransaction(TD);
          try
            bError := cdsSalesCr.ApplyUpdates(0) > 0;
            bError := bError or (cdsSalesCrLines.ApplyUpdates(0) > 0);
            if not bError then Commit(TD);
          finally
            if InTransaction then Rollback(TD);
          end;
      end
    end else begin
      cdsSalesCr.CancelUpdates;
      for i := 0 to cdsSalesCrLines.ChangeCount -1 do
        cdsSalesCrLines.UndoLastChange(False);
    end;
    InsertingSalesCr := False;
  finally
    FreeAndNil(fmSalesCreditEdit);
  end;

  cdsSalesCrLines.AggregatesActive := False;
end;

procedure TdmSalesCredit.cdsSalesCr_EditNewRecord(DataSet: TDataSet);
begin
  Dec(SalesCreditID);
  with cdsSalesCr do begin
    FieldByName('SALES_CR_ID').AsInteger := SalesCreditID;
    FieldByName('SALES_CR_DATE').AsDateTime := Date;
  end;
  InsertingSalesCr := True;
end;

procedure TdmSalesCredit.dspSalesCrBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  newDetailID: Integer;
  newMasterID: Integer;
  connection: TSQLConnection;
  sql: string;
  id: Integer;
begin
  if (UpdateKind = ukInsert) then begin
    if (SourceDS = sqlSalesCr) and
       (DeltaDS.FieldByName('SALES_CR_ID').NewValue < 0) then
       begin
         newMasterID := dmMain.GetNextPK;
         DeltaDS.FieldByName('SALES_CR_ID').NewValue := newMasterID;
         LastSalesCreditMasterPK := newMasterID;
       end
    else if (SourceDS = sqlSalesCrLines) and
            (DeltaDS.FieldByName('SALES_CR_LINES_ID').NewValue < 0) then
       begin
         newDetailID := dmMain.GetNextPK;
         newMasterID := LastSalesCreditMasterPK;
         DeltaDS.FieldByName('SALES_CR_LINES_ID').NewValue := newDetailID;
         if DeltaDS.FieldByName('SALES_CR_ID').NewValue < 0 then
           DeltaDS.FieldByName('SALES_CR_ID').NewValue := newMasterID;
       end
  end
  else if (UpdateKind = ukDelete) then
    if (SourceDS = sqlSalesCr) then
    begin
      connection := sqlSalesCr.SQLConnection;
      //Format won't work directly with id as variant
      id := DeltaDS.fieldbyname('SALES_CR_ID').OldValue;
      sql := Format(SALESCR_DELETE_LINE_SQL, [id]);
      connection.Execute(sql,nil,nil)
    end;
end;

procedure TdmSalesCredit.cdsSalesCrLinesNewRecord(DataSet: TDataSet);
begin
  Dec(SalesCreditLinesID);
  with cdsSalesCrLines do
  begin
    FieldByName('SALES_CR_LINES_ID').AsInteger := SalesCreditLinesID;
    FieldByName('QTY').AsFloat := 1;
  end;
end;

procedure TdmSalesCredit.cdsSalesCrLinesAfterDelete(DataSet: TDataSet);
var
  NewTxnAmount: Double;
begin
  if not (cdsSalesCrLines.Bof and cdsSalesCrLines.Eof) then
    NewTxnAmount := cdsSalesCrLines.fieldbyname('SumPriceTotal').Value else
    NewTxnAmount := 0;
  cdsSalesCr.FieldByName('SALES_CR_AMOUNT').AsCurrency := NewTxnAmount;
end;

procedure TdmSalesCredit.cdsSalesCrLinesPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
var
  _message : string;
begin
  if Pos('KEY VIOLATION', UpperCase(e.Message)) > 0 then
    _message := 'Duplicate. Each invoice can only be used once.'
  else
    _message := e.Message;
  MessageDlg(_message, mtWarning, [mbOK], 0);
  Action := daAbort;
end;

procedure TdmSalesCredit.cdsSalesCrLinesBeforePost(DataSet: TDataSet);
begin
  with cdsSalesCrLines do begin
    FieldByName('PRICETOTAL').AsCurrency :=
      Fieldbyname('QTY').AsCurrency * FieldByName('PRICE_UNIT').AsCurrency;
  end;
end;

procedure TdmSalesCredit.dspSalesCrGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'SALES_CREDIT';
end;

procedure TdmSalesCredit.dspSalesCrLinesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'SALES_CREDIT_LINES';
end;

procedure TdmSalesCredit.dspSalesCrUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  Dataset.FieldByName('CLIENTNAME').ProviderFlags := [];
end;

procedure TdmSalesCredit.dspSalesCrLinesUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  Dataset.FieldByName('PRODUCTNAME').ProviderFlags := [];
  Dataset.FieldByName('PRICETOTAL').ProviderFlags := [];
end;

procedure TdmSalesCredit.cdsSalesCrLinesAfterPost(DataSet: TDataSet);
begin
    cdsSalesCr.FieldByName('SALES_CR_AMOUNT').AsCurrency :=
      cdsSalesCrLines.fieldbyname('SumPriceTotal').Value;
end;

procedure TdmSalesCredit.DeleteSalesCredit;
begin
  dmMain.cdsDeleteRecord(sqlSalesCr.SQLConnection,cdsSalesCr);
end;

procedure TdmSalesCredit.FilterSalesCredits( parameters: array of variant );
begin
  with sqlSalesCr do begin
    ParamByName('START_DATE').DataType   := ftDate;
    ParamByName('END_DATE').DataType     := ftDate;
    ParamByName('CLIENT_ID').DataType    := ftInteger;
    ParamByName('NUMBER').DataType       := ftString;

    ParamByName('START_DATE').Value   := parameters[0];
    ParamByName('END_DATE').Value     := parameters[1];
    ParamByName('CLIENT_ID').Value    := parameters[2];
    ParamByName('NUMBER').Value       := parameters[3];
  end;
  OpenSalesCr;
end;

end.
