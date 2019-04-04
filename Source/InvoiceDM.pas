unit InvoiceDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, FMTBcd,
  Provider, DBClient, Windows, Forms, ActnList, CustomerDM, ImgList,
  Controls, PngImageList, MainDM, DBXpress;

type


  TdmInvoice = class(TDataModule)
    cdsInv: TClientDataSet;
    cdsCol: TClientDataSet;
    cdsUnpaid: TClientDataSet;
    cdsCol2: TClientDataSet;
    SQLCol: TSQLDataSet;

    dspInv: TDataSetProvider;
    dsInvoice: TDataSource;
    ActionList1: TActionList;
    actShowInvoiceEdit: TAction;
    actShowProductMgr: TAction;
    actShowCustomerMgr: TAction;
    dspCol: TDataSetProvider;
    cdsColCOL_ID: TIntegerField;
    cdsColCOL_NUMBER: TStringField;
    cdsColCOL_DATE: TDateField;
    cdsColCOL_AMOUNT: TFMTBCDField;
    cdsColCLIENT_ID: TIntegerField;
    actShowCollectionEdit: TAction;
    cdsColCOL_AMOUNTAPPLIED: TFMTBCDField;
    cdsColCOL_UNAPPLIEDAMT: TFloatField;
    cdsColCOL_DESCRIPTION: TStringField;
    cdsColPMT_REF: TStringField;
    cdsColPMT_TYPE: TStringField;
    PngImageList1: TPngImageList;
    SQLUnpaid: TSQLDataSet;
    dspUnpaid: TDataSetProvider;
    cdsUnpaidTXN_NUMBER: TStringField;
    cdsUnpaidTXN_DATE: TDateField;
    cdsUnpaidTXN_AMOUNT: TFMTBCDField;
    cdsUnpaidTXN_AMOUNTPAID: TFMTBCDField;
    cdsUnpaidCLIENT_ID: TIntegerField;
    cdsUnpaidTXN_TYPE_CID: TStringField;
    cdsUnpaidAGENT_ID: TIntegerField;
    cdsUnpaidUnpaidAmount: TFloatField;
    cdsUnpaidAmountApplied: TFloatField;
    SQLCol2: TSQLDataSet;
    cdsColAGENT_ID: TIntegerField;
    cdsColClientName: TStringField;
    cdsColCOL_TYPE: TStringField;
    dspCol2: TDataSetProvider;
    cdsCol2COL_DETAIL_ID: TIntegerField;
    cdsCol2COL_ID: TIntegerField;
    cdsCol2TXN_NUMBER: TStringField;
    cdsCol2TXN_DATE: TDateField;
    cdsCol2COL_DETAIL_AMTPAID: TFMTBCDField;
    cdsCol2AFFIDAVIT_AMT: TFMTBCDField;
    cdsCol2DISCOUNT: TFMTBCDField;
    dsCol: TDataSource;
    cdsColUNAPPLIEDAMOUNT: TFMTBCDField;
    SQLColCLIENTNAME: TStringField;
    SQLColUNAPPLIEDAMOUNT: TFMTBCDField;
    SQLColCOL_ID: TIntegerField;
    SQLColCOL_NUMBER: TStringField;
    SQLColCOL_DATE: TDateField;
    SQLColCOL_TYPE: TStringField;
    SQLColCOL_REF: TStringField;
    SQLColCOL_AMOUNT: TFMTBCDField;
    SQLColCOL_AMOUNTAPPLIED: TFMTBCDField;
    SQLColCOL_DESCRIPTION: TStringField;
    SQLColCLIENT_ID: TIntegerField;
    SQLColAGENT_ID: TIntegerField;
    SQLColPMT_REF: TStringField;
    SQLColPMT_TYPE: TStringField;
    cdsCol2SumAmtPaid: TAggregateField;
    SQLColCOLLECTOR_ID: TIntegerField;
    cdsColCOLLECTOR_ID: TIntegerField;
    SQLColCOLLECTORNAME: TStringField;
    cdsColCOLLECTORNAME: TStringField;
    cdsColSumAmount: TAggregateField;
    cdsColSumUnApplied: TAggregateField;
    sqlInvoice: TSQLDataSet;
    sqlInvoiceLine: TSQLDataSet;
    dspInvoiceLine: TDataSetProvider;
    cdsInv2: TClientDataSet;
    sqlInvoiceTXN_ID: TIntegerField;
    sqlInvoiceTXN_NUMBER: TStringField;
    sqlInvoiceTXN_DATE: TDateField;
    sqlInvoiceTXN_PERIOD: TStringField;
    sqlInvoiceTXN_DAYSDUE: TSmallintField;
    sqlInvoiceTXN_DUEDATE: TDateField;
    sqlInvoiceTXN_AMOUNT: TFMTBCDField;
    sqlInvoiceTXN_DOWNPAYMENT: TFMTBCDField;
    sqlInvoiceTXN_AMOUNTPAID: TFMTBCDField;
    sqlInvoiceSALESCREDIT: TFMTBCDField;
    sqlInvoiceTXN_PARTICULARS: TStringField;
    sqlInvoiceTXN_TYPE_CID: TStringField;
    sqlInvoiceCLIENT_ID: TIntegerField;
    sqlInvoiceAGENT_ID: TIntegerField;
    sqlInvoiceTOWN_ID: TIntegerField;
    sqlInvoiceCLIENTNAME: TStringField;
    sqlInvoiceAGENTNAME: TStringField;
    sqlInvoiceTOWNPROVINCE: TStringField;
    sqlInvoiceLineTXN_DETAIL_ID: TIntegerField;
    sqlInvoiceLineTXN_ID: TIntegerField;
    sqlInvoiceLinePRODUCT_ID: TIntegerField;
    sqlInvoiceLinePRODUCTNAME: TStringField;
    sqlInvoiceLineQTYIN: TFMTBCDField;
    sqlInvoiceLineQTYOUT: TFMTBCDField;
    sqlInvoiceLineCOST_UNIT: TFMTBCDField;
    sqlInvoiceLineCOST_TOTAL: TFMTBCDField;
    sqlInvoiceLinePRICE_UNIT: TFMTBCDField;
    sqlInvoiceLinePRICETOTAL: TFMTBCDField;
    cdsInvTXN_ID: TIntegerField;
    cdsInvTXN_NUMBER: TStringField;
    cdsInvTXN_DATE: TDateField;
    cdsInvTXN_PERIOD: TStringField;
    cdsInvTXN_DAYSDUE: TSmallintField;
    cdsInvTXN_DUEDATE: TDateField;
    cdsInvTXN_AMOUNT: TFMTBCDField;
    cdsInvTXN_DOWNPAYMENT: TFMTBCDField;
    cdsInvTXN_AMOUNTPAID: TFMTBCDField;
    cdsInvSALESCREDIT: TFMTBCDField;
    cdsInvTXN_PARTICULARS: TStringField;
    cdsInvTXN_TYPE_CID: TStringField;
    cdsInvCLIENT_ID: TIntegerField;
    cdsInvAGENT_ID: TIntegerField;
    cdsInvTOWN_ID: TIntegerField;
    cdsInvCLIENTNAME: TStringField;
    cdsInvAGENTNAME: TStringField;
    cdsInvTOWNPROVINCE: TStringField;
    cdsInvSumInvoiceAmount: TAggregateField;
    cdsInvSumDownPayment: TAggregateField;
    cdsInv2TXN_DETAIL_ID: TIntegerField;
    cdsInv2TXN_ID: TIntegerField;
    cdsInv2PRODUCT_ID: TIntegerField;
    cdsInv2PRODUCTNAME: TStringField;
    cdsInv2QTYIN: TFMTBCDField;
    cdsInv2QTYOUT: TFMTBCDField;
    cdsInv2COST_UNIT: TFMTBCDField;
    cdsInv2COST_TOTAL: TFMTBCDField;
    cdsInv2PRICE_UNIT: TFMTBCDField;
    cdsInv2PRICETOTAL: TFMTBCDField;
    cdsInv2SumPriceTotal: TAggregateField;
    sqlInvoiceBALANCE: TFMTBCDField;
    cdsInvBALANCE: TFMTBCDField;
    cdsCol2CLIENTNAME: TStringField;
    procedure dspInvGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: String);
    procedure dspInvBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure cdsInv_EditNewRecord(DataSet: TDataSet);
    procedure cdsInv2_EditNewRecord(DataSet: TDataSet);
    procedure actShowInvoiceEditExecute(Sender: TObject);
    procedure cdsInv_EditBeforePost(DataSet: TDataSet);
    procedure dspColBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure dspColGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure cdsCol_EditNewRecord(DataSet: TDataSet);
    procedure actShowCollectionEditExecute(Sender: TObject);
    procedure cdsColCalcFields(DataSet: TDataSet);
    procedure cdsUnpaidBeforeInsert(DataSet: TDataSet);
    procedure cdsUnpaidAfterPost(DataSet: TDataSet);
    procedure cdsUnpaidCalcFields(DataSet: TDataSet);
    procedure dspUnpaidUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsCol2_EditAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsInv_EditPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure cdsCol_EditBeforePost(DataSet: TDataSet);
    procedure cdsCol2_EditNewRecord(DataSet: TDataSet);
    procedure cdsCol2_EditPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure cdsInv2_EditAfterDelete(DataSet: TDataSet);
    procedure cdsInv2_EditAfterPost(DataSet: TDataSet);
    procedure dspColUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure dspInvUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure cdsInv2BeforePost(DataSet: TDataSet);
    procedure dspCol2UpdateData(Sender: TObject; DataSet: TCustomClientDataSet);
    procedure dspInvoiceLineUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
  private
    InvoiceID: Integer;
    InvoiceDetailID : integer;
    CollectionID: Integer;
    CollectionDetailID: integer;
    InsertingInvoice: Boolean;
    InsertingCollection: Boolean;
    LastCollectionMasterPK: Integer;
    LastInvoiceMasterPK: Integer;
    DMUsers: TDMUsers;
    LineTempID: integer;
    LastEditOked: Boolean;
    RecordEditData: TRecordEditData;
    
  public
    FOldCollectionAmount: Double;
    BaseSQLInvoice: string;
    BaseSQLCollection: string;
//    OldInvoiceAmount: Currency;
//    OldInvoiceLineAmount: Currency;
    SelectedProduct: Variant;
    SelectedCustomer: Variant;
    SelectedAgent: Variant;  
    Copy_Detail_Buffer: Variant;
    class procedure Open(DMUser: TDMUser);
    class procedure Close(DMUser: TDMUser);
    procedure OpenInvoices;
    procedure CloseInvoices;
    procedure OpenCollections;
    procedure CloseCollections;
//    function SelectCustomer(AUser: TDMUser; KeyBuffer: string = ''): Variant;
    procedure ReceivePayment;
    procedure EditInvoice;
    procedure DeleteInvoice;
    procedure EditCollection;
    procedure DeleteCollection;
    procedure CopyFromDetailBuffer;
    procedure FilterCollections(parameters: array of Variant); overload;
    procedure FilterCollections(const Conflict: Boolean = true); overload;
    procedure FilterInvoices( parameters: array of Variant );
  end;

const
  COPYDETAILFIELDS_BUFFER = 'PRODUCT_ID;ProductName;QTYOUT;PRICE_UNIT';
  _CUSTOMER_PLS = 'Please select a customer for this collection.';

  COL_CONFLICT_SQL =  'select * from sel_collection_conflict';
  COL_SQL = 'select * from '+
      'sel_collection(:start_date,:end_date,:client_id,:collector_id' +
      ',:col_type,:col_number,:unappliedonly)';

var
  dmInvoice: TdmInvoice;

implementation

uses Dialogs, uAppSettings, InvoiceEditCdsU, 
  Variants, Misc, CollectionEditU, ProductsDM, Clipper;

{$R *.dfm}

procedure TdmInvoice.OpenInvoices;
var
  oldIndexName: string;
begin

  TdmCustomer.OpenCustomers(dmuInvoices);
  TdmProducts.Open(dmuInvoices);

  oldIndexName := cdsInv.IndexName;
  cdsInv.IndexName := '';

  with cdsInv do
    if Active then Refresh else Open;
  with cdsInv2 do
    if Active then Refresh else
      dmMain.CDSDetailOpen(cdsInv2,dsInvoice,'TXN_ID','');

  if oldIndexName <> '' then
  begin
    SortCDS( cdsInv,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;

  cdsInv.FieldByName('TXN_ID').OnGetText := dmMain.IDGetText;

end;

procedure TdmInvoice.dspInvGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  if DataSet = sqlInvoice then
    TableName := 'TXN' else
    TableName := 'TXN_DETAIL';
end;

procedure TdmInvoice.dspInvBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) then begin
    if (SourceDS = sqlInvoice) and
       (DeltaDS.FieldByName('TXN_ID').NewValue < 0) then
       begin
         LastInvoiceMasterPK := dmMain.GetNextPK;
         DeltaDS.FieldByName('TXN_ID').NewValue := LastInvoiceMasterPK;
       end
    else if (SourceDS = sqlInvoiceLIne) and
            (DeltaDS.FieldByName('TXN_DETAIL_ID').NewValue < 0) then
       begin
         DeltaDS.FieldByName('TXN_DETAIL_ID').NewValue := dmMain.GetNextPK;
         if DeltaDS.FieldByName('TXN_ID').NewValue < 0 then
           DeltaDS.FieldByName('TXN_ID').NewValue := LastInvoiceMasterPK;
       end
  end;
end;

procedure TdmInvoice.cdsInv_EditNewRecord(DataSet: TDataSet);
var
  DefaultDueDays: SmallInt;
begin
  Dec(InvoiceID);
  DefaultDueDays := 120; //todo: make default inv due days
  with Dataset do
  begin
    FieldByName('TXN_ID').AsInteger := InvoiceID;
    FieldByName('TXN_ID').Alignment := taLeftJustify;
    FieldByName('TXN_TYPE_CID').AsString := 'INV';
    FieldByName('TXN_DATE').AsDateTime := AppSettings.LastInvDateUsed;
    FieldByName('TXN_NUMBER').AsString := IncrementString(AppSettings.LastNoInvoice);
    FieldByName('TXN_DAYSDUE').AsInteger := DefaultDueDays;
    FieldByName('TXN_DUEDATE').AsDateTime := Date + DefaultDueDays;
    FieldByName('TXN_AMOUNT').Value := 0;
    FieldByName('TXN_AMOUNTPAID').Value := 0;
    FieldByName('TXN_PERIOD').AsString := AppSettings.LastInvBatchNo;
  end;
  InsertingInvoice := True;
end;

procedure TdmInvoice.cdsInv2_EditNewRecord(DataSet: TDataSet);
begin
  with DataSet do
  begin
    Dec(InvoiceDetailID);
    FieldByName('TXN_DETAIL_ID').AsInteger := InvoiceDetailID;
    FieldByName('QTYOUT').AsFloat := 1;
  end;
end;

class procedure TdmInvoice.Open(DMUser: TDMUser);
begin
  if not Assigned(dmInvoice) then begin
    dmInvoice := TdmInvoice.Create(nil);
    dmInvoice.BaseSQLInvoice    := dmInvoice.sqlInvoice.CommandText;
    dmInvoice.BaseSQLCollection := dmInvoice.SQLCol.CommandText;
  end;

  if not (DMUser in dmInvoice.DMUsers) then
    dmInvoice.DMUsers := dmInvoice.DMUsers + [DMUser];
end;

class procedure TdmInvoice.Close(DMUser: TDMUser);
begin
  if Assigned(dmInvoice) then
  begin
    if dmUser in dmInvoice.DMUsers then
      dmInvoice.DMUsers := dmInvoice.DMUsers - [dmUser];
    if dmInvoice.DMUsers = [] then begin
      FreeAndNil(fmInvoiceEditCDS);
      FreeAndNil(fmCollectionsEdit);  
      FreeAndNil(dmInvoice);
    end;
  end;
end;


procedure TdmInvoice.actShowInvoiceEditExecute(Sender: TObject);
var
  bError: Boolean;
  TD: TTransactionDesc;
  i: Integer;
begin
  cdsInv2.AggregatesActive := True;
  if not Assigned(fmInvoiceEditCDS) then
    fmInvoiceEditCDS := TfmInvoiceEditCDS.Create(Self);
  try
    if fmInvoiceEditCDS.ShowModal = mrOk then begin
      if InsertingInvoice then begin
        AppSettings.LastNoInvoice := cdsInv.fieldbyname('TXN_NUMBER').AsString;
        AppSettings.LastInvBatchNo := cdsInv.fieldbyname('TXN_PERIOD').AsString;
        AppSettings.LastInvDateUsed := cdsInv.fieldbyname('TXN_DATE').AsDateTime;
      end;
      with sqlInvoice.SQLConnection do begin
        TD.TransactionID := 1;
        td.IsolationLevel := xilREADCOMMITTED;
        if not InTransaction then
          StartTransaction(TD);
          try
            bError := cdsInv.ApplyUpdates(0) > 0;
            bError := bError or (cdsInv2.ApplyUpdates(0) > 0);
            if not bError then Commit(TD);
          finally
            if InTransaction then Rollback(TD);
          end;
      end
    end else begin
      cdsInv.CancelUpdates;
      for i := 0 to cdsInv2.ChangeCount -1 do
        cdsInv2.UndoLastChange(False);
    end;
    InsertingInvoice := False;
  finally
    FreeAndNil(fmInvoiceEditCDS);
  end;
  cdsInv2.AggregatesActive := False;
end;


procedure TdmInvoice.cdsInv_EditBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('CLIENT_ID').AsInteger = 0 then begin
    ShowMessage('Please select a customer for this invoice.');
    DataSet.FieldByName('ClientName').FocusControl;
    Abort;
  end;
  if DataSet.FieldByName('TXN_PERIOD').AsString = '' then begin
    ShowMessage('Please indicate Period for this invoice.');
    DataSet.FieldByName('TXN_PERIOD').FocusControl;
    Abort;
  end;
  if VarIsNull(DataSet.FieldByName('TXN_DOWNPAYMENT').value) then
    DataSet.FieldByName('TXN_DOWNPAYMENT').AsFloat := 0;
  with cdsInv do
    FieldByName('Balance').AsCurrency :=
      Fieldbyname('TXN_AMOUNT').AsCurrency - Fieldbyname('TXN_DOWNPAYMENT').AsCurrency -
      Fieldbyname('SALESCREDIT').AsCurrency;
end;



procedure TdmInvoice.OpenCollections;
var
  oldIndexName: string;
begin
  oldIndexName := cdsCol.IndexName;
  cdsCol.IndexName := '';

  //cdsCol.Close;
  //cdsCol.Open;
  with cdsCol do
    if Active then Refresh else Open;
  with cdsCol2 do
    if Active then Refresh else
      dmMain.CDSDetailOpen(cdsCol2,dsCol,'COL_ID','');

  if oldIndexName <> '' then
  begin
    SortCDS( cdsCol,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;

  //cdsCol.First;

  //cdsCol_Edit.Close;
  //cdsCol_Edit.CloneCursor(cdsCol, False, True);

  cdsCol.FieldByName('COL_ID').OnGetText := dmMain.IDGetText;
  //todo: create a 'sel_unpaid' stored procedure to test load speed
  cdsUnpaid.Open;

end;

procedure TdmInvoice.CloseCollections;
begin
  FreeAndNil(fmCollectionsEdit);
  dmInvoice.cdsCol.Close;
  dmInvoice.cdsUnpaid.Close;
  dmInvoice.cdsCol.Close;
  //dmInvoice.Close;
end;

procedure TdmInvoice.dspColBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) then begin
    if (SourceDS = SQLCol) and
       (DeltaDS.FieldByName('COL_ID').NewValue < 0) then
       begin
         LastCollectionMasterPK := dmMain.GetNextPK;
         DeltaDS.FieldByName('COL_ID').NewValue := LastCollectionMasterPK;
       end

    else if (SourceDS = SQLCol2) and
            (DeltaDS.FieldByName('COL_DETAIL_ID').NewValue < 0) then
       begin
         DeltaDS.FieldByName('COL_DETAIL_ID').NewValue := dmMain.GetNextPK;
         if DeltaDS.FieldByName('COL_ID').NewValue < 0 then
           DeltaDS.FieldByName('COL_ID').NewValue := LastCollectionMasterPK;
       end
  end;
end;

procedure TdmInvoice.dspColGetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: String);
begin
  if DataSet = SQLCol then
    TableName := 'COLLECTION' else
    TableName := 'COLLECTION_DETAIL';
end;

procedure TdmInvoice.cdsCol_EditNewRecord(DataSet: TDataSet);
begin
  FOldCollectionAmount := 0;
  Dec(CollectionID);
  with DataSet do
  begin
    FieldByName('COL_ID').AsInteger := CollectionID;
    FieldByName('COL_ID').Alignment := taLeftJustify;
    FieldByName('COL_DATE').AsDateTime := Date;
    FieldByName('COL_NUMBER').AsString := IncrementString(AppSettings.LastNoCollection);
    FieldByName('COL_AMOUNT').Value := 0;
    FieldByName('COL_AMOUNTAPPLIED').Value := 0;
    FieldByName('COL_DESCRIPTION').AsString := 'Payment for invoice ';
    FieldByName('PMT_TYPE').AsString := 'Cash';
    FieldByName('COL_TYPE').AsString := 'CAS';
  end;
  InsertingCollection := True;
end;

procedure TdmInvoice.actShowCollectionEditExecute(Sender: TObject);
var
  bError: Boolean;
  TD: TTransactionDesc;
  i: Integer;
begin
  cdsCol2.AggregatesActive := True;
  if not Assigned(fmCollectionsEdit) then
    fmCollectionsEdit := TfmCollectionsEdit.Create(Self);
  try
    if fmCollectionsEdit.ShowModal = mrOk then begin
      if InsertingCollection then begin
        AppSettings.LastNoCollection := cdsCol.fieldbyname('COL_NUMBER').AsString;
      end;
      with SQLCol.SQLConnection do begin
        TD.TransactionID := 1;
        td.IsolationLevel := xilREADCOMMITTED;
        if not InTransaction then
          StartTransaction(TD);
          try
            bError := cdsCol.ApplyUpdates(0) > 0;
            bError := bError or (cdsCol2.ApplyUpdates(0) > 0);
            if not bError then Commit(TD);
          finally
            if InTransaction then Rollback(TD);
          end;
      end
    end else begin
      cdsCol.CancelUpdates;
      for i := 0 to cdsCol2.ChangeCount -1 do
        cdsCol2.UndoLastChange(False);
    end;
    InsertingCollection := False;
  finally
    FreeAndNil(fmCollectionsEdit);
  end;
  cdsCol2.AggregatesActive := False;
end;

procedure TdmInvoice.cdsColCalcFields(DataSet: TDataSet);
var
  ClientID: Integer;
  CustVarData: Variant;
begin
  with DataSet do
  begin
    if State = dsInternalCalc then
    begin
      ClientID := FieldByName('CLIENT_ID').asinteger;
      CustVarData :=
        dmCustomer.cdsCust.Lookup('CLIENT_ID',ClientID,'CLIENT_NAME');
      if not VarIsEmpty(CustVarData) then
      begin
        FieldByName('ClientName').AsString := CustVarData;
      end;
    end;
  end;

  with DataSet do
    FieldByName('UnappliedAmount').AsFloat :=
      Fieldbyname('COL_AMOUNT').AsFloat -
      FieldByName('COL_AMOUNTAPPLIED').AsFloat;
end;

procedure TdmInvoice.CloseInvoices;
begin
  dmInvoice.cdsInv.Close;
  //dmInvoice.cdsInv_Edit.Close;
  TdmCustomer.Close(dmuInvoices);
  TdmProducts.Close(dmuInvoices);
  //dmInvoice.Close;  //try to close the dm
end;

procedure TdmInvoice.cdsUnpaidBeforeInsert(DataSet: TDataSet);
begin
  cdsUnpaid.LogChanges := false;
end;

procedure TdmInvoice.cdsUnpaidAfterPost(DataSet: TDataSet);
begin
  cdsUnpaid.LogChanges := True;
end;

procedure TdmInvoice.cdsUnpaidCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('UnpaidAmount').AsFloat :=
    DataSet.fieldbyname('TXN_AMOUNT').AsFloat -
    DataSet.fieldbyname('TXN_AMOUNTPAID').AsFloat;
end;

procedure TdmInvoice.dspUnpaidUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('TXN_NUMBER').ProviderFlags :=
    DataSet.FieldByName('TXN_NUMBER').ProviderFlags + [pfInKey];
end;

procedure TdmInvoice.ReceivePayment;
begin
  if not cdsCol.Active then begin
    SQLCol.CommandText := BaseSQLCollection + #13#10 + 'where 1=2';
    OpenCollections;
  end;
  with cdsCol do
  begin
    Append;
    FieldByName('CLIENT_ID').AsInteger := cdsInv.fieldbyname('CLIENT_ID').AsInteger;
    FieldByName('ClientName').AsString := cdsInv.fieldbyname('ClientName').AsString;
    FieldByName('COL_AMOUNT').AsFloat := cdsInv.fieldbyname('TxnBalance').AsFloat;
    FieldByName('AGENT_ID').AsInteger := cdsInv.fieldbyname('AGENT_ID').AsInteger;
  end;
  with cdsCol2 do
  begin
    Dec(LineTempID);
    AggregatesActive := True;
    Append;
    FieldByName('COL_DETAIL_ID').AsInteger    := LineTempID;
    FieldByName('TXN_NUMBER').AsString        := cdsInv.fieldbyname('TXN_NUMBER').AsString;
    FieldByName('COL_DETAIL_AMTPAID').AsFloat := cdsInv.fieldbyname('TxnBalance').AsFloat;
    FieldByName('TXN_DATE').AsDateTime        := cdsInv.fieldbyname('TXN_DATE').AsDateTime;
    Post;
  end;
  actShowCollectionEdit.Execute;
end;



procedure TdmInvoice.EditInvoice;
begin
  RecordEditData.cds       := cdsInv;
  RecordEditData.cdsed     := cdsInv;
  RecordEditData.fid       := 'TXN_ID';
  RecordEditData.act       := actShowInvoiceEdit;
  RecordEditData.pFormOked := @LastEditOked;

  RecordEditData.fidvalue  := RecordEditData.cds.fieldbyname(RecordEditData.fid).AsString;

  if RecordEditData.cdsed.State = dsInsert then
    dmMain.ShowRecordEdit(RecordEditData,1)
  else
    dmMain.ShowRecordEdit(RecordEditData,2);
end;

procedure TdmInvoice.EditCollection;
begin
  RecordEditData.cds       := cdsCol;
  RecordEditData.cdsed     := cdsCol;
  RecordEditData.fid       := 'COL_ID';
  RecordEditData.act       := actShowCollectionEdit;
  RecordEditData.pFormOked := @LastEditOked;

  RecordEditData.fidvalue  := RecordEditData.cds.fieldbyname(RecordEditData.fid).AsString;

  if RecordEditData.cdsed.State = dsInsert then
    dmMain.ShowRecordEdit(RecordEditData, 1)
  else
    dmMain.ShowRecordEdit(RecordEditData, 2);
end;

procedure TdmInvoice.DeleteInvoice;
begin
  if (cdsInv.Bof and cdsInv.Eof) then Exit;

  with cdsInv do
    if FieldByName('TXN_AMOUNTPAID').AsFloat = 0 then
    begin
      if MessageDlg('Delete this invoice?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Delete;
        if ChangeCount > 0 then
          ApplyUpdates(0);
      end
    end else
      MessageDlg('This invoice cannot be deleted.' + #13#10 + 
        'Payments or Returns has been made.',  mtInformation, [mbOK], 0);
        
end;

procedure TdmInvoice.DeleteCollection;
begin
  if (cdsCol.Bof and cdsCol.Eof) then Exit;

  with cdsCol do
    begin
      if MessageDlg('Delete this collection?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Delete;
        if ChangeCount > 0 then
          ApplyUpdates(0);
      end
    end ;
end;

procedure TdmInvoice.cdsCol2_EditAfterPost(DataSet: TDataSet);
var
  DetailTotal: Double;
begin
  if not cdsCol2.IsEmpty then
    DetailTotal := cdsCol2.fieldbyname('SumAmtPaid').Value
  else
    DetailTotal := 0;
  cdsCol.FieldByName('COL_AMOUNTAPPLIED').AsCurrency := DetailTotal;
  cdsCol.FieldByName('UNAPPLIEDAMOUNT').AsCurrency :=
    cdsCol.FieldByName('COL_AMOUNT').AsCurrency -
    cdsCol.FieldByName('COL_AMOUNTAPPLIED').AsCurrency;
end;

procedure TdmInvoice.DataModuleCreate(Sender: TObject);
begin
  cdsInv.OnReconcileError      := dmMain.cdsGenReconcileError;
  cdsCol.OnReconcileError      := dmMain.cdsGenReconcileError;
  SQLCol.CommandText := COL_SQL;
  with sqlInvoice do
    CommandText := 'select * from '+
      'sel_invoice(:START_DATE,:end_date,:txn_period,:client_id,:agent_id,'+
      ':town_id,:txn_number)';
end;

procedure TdmInvoice.cdsInv_EditPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
var
  _message : string;
begin
  if Pos('KEY VIOLATION', Upper(e.Message)) > 0 then
    _message := 'Duplicate Invoice record found.'
  else
    _message := e.Message;
  MessageDlg(_message, mtWarning, [mbOK], 0);
  Action := daAbort;
end;

procedure TdmInvoice.CopyFromDetailBuffer;
begin
  //quick copy data from last inserted detail
  cdsInv2.Append;
  cdsInv2[COPYDETAILFIELDS_BUFFER] := Copy_Detail_Buffer;
end;

procedure TdmInvoice.cdsCol_EditBeforePost(DataSet: TDataSet);
var
  DetailTotal: Currency;
begin
  if DataSet.FieldByName('CLIENT_ID').AsInteger = 0 then begin
    ShowMessage(_CUSTOMER_PLS);
    DataSet.FieldByName('ClientName').FocusControl;
    Abort;
  end;

  if not cdsCol2.IsEmpty then
    DetailTotal := cdsCol2.fieldbyname('SumAmtPaid').Value
  else
    DetailTotal := 0;
  cdsCol.FieldByName('COL_AMOUNTAPPLIED').AsCurrency := DetailTotal;
  cdsCol.FieldByName('UNAPPLIEDAMOUNT').AsCurrency :=
    cdsCol.FieldByName('COL_AMOUNT').AsCurrency -
    cdsCol.FieldByName('COL_AMOUNTAPPLIED').AsCurrency;

end;

procedure TdmInvoice.cdsCol2_EditNewRecord(DataSet: TDataSet);
begin
  Dec(CollectionDetailID);
  DataSet.FieldByName('col_detail_id').AsInteger := CollectionDetailID;
  DataSet.FieldByName('COL_DETAIL_AMTPAID').AsFloat := 0;
  DataSet.FieldByName('AFFIDAVIT_AMT').AsFloat := 0;
  DataSet.FieldByName('DISCOUNT').AsFloat := 0;  
end;

procedure TdmInvoice.cdsCol2_EditPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
var
  _message : string;
begin
  if Pos('KEY VIOLATION', Uppercase(e.Message)) > 0 then
    _message := 'Duplicate. Each invoice can only be used once.'
  else
    _message := e.Message;
  MessageDlg(_message, mtWarning, [mbOK], 0);
  Action := daAbort;
end;

procedure TdmInvoice.dspInvoiceLineUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('PRODUCTNAME').ProviderFlags := [];
  DataSet.FieldByName('PRICETOTAL').ProviderFlags := [];
end;

procedure TdmInvoice.cdsInv2_EditAfterDelete(DataSet: TDataSet);
var
  NewInvAmount: Double;
begin
  if not (cdsInv2.Bof and cdsInv2.Eof) then
    NewInvAmount := cdsInv2.fieldbyname('SumPriceTotal').Value else
    NewInvAmount := 0;
  cdsInv.FieldByName('TXN_AMOUNT').AsCurrency := NewInvAmount;
  with cdsInv do
    FieldByName('Balance').AsCurrency :=
      Fieldbyname('TXN_AMOUNT').AsCurrency - Fieldbyname('TXN_DOWNPAYMENT').AsCurrency -
      Fieldbyname('SALESCREDIT').AsCurrency;
end;

procedure TdmInvoice.cdsInv2_EditAfterPost(DataSet: TDataSet);
begin
  cdsInv.FieldByName('TXN_AMOUNT').AsCurrency :=
    cdsInv2.fieldbyname('SumPriceTotal').Value;
  with cdsInv do
    FieldByName('Balance').AsCurrency :=
      Fieldbyname('TXN_AMOUNT').AsCurrency - Fieldbyname('TXN_DOWNPAYMENT').AsCurrency -
      Fieldbyname('SALESCREDIT').AsCurrency;

  Copy_Detail_Buffer := cdsInv2[COPYDETAILFIELDS_BUFFER];
end;


procedure TdmInvoice.FilterCollections(parameters: array of Variant);
begin
  with SQLCol do begin
    CommandText := COL_SQL;
    ParamByName('START_DATE').DataType   := ftDate;
    ParamByName('END_DATE').DataType     := ftDate;
    ParamByName('CLIENT_ID').DataType    := ftInteger;
    ParamByName('COLLECTOR_ID').DataType := ftInteger;
    ParamByName('COL_TYPE').DataType     := ftString;
    ParamByName('COL_NUMBER').DataType   := ftString;
    ParamByName('UNAPPLIEDONLY').DataType := ftBoolean;

    ParamByName('START_DATE').Value   := parameters[0];
    ParamByName('END_DATE').Value     := parameters[1];
    ParamByName('CLIENT_ID').Value    := parameters[2];
    ParamByName('COLLECTOR_ID').Value := parameters[3];
    ParamByName('COL_TYPE').Value     := parameters[4];
    ParamByName('COL_NUMBER').Value   := parameters[5];
    ParamByName('UNAPPLIEDONLY').Value := parameters[6];
  end;
  OpenCollections;
end;

procedure TdmInvoice.dspColUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('COLLECTORNAME').ProviderFlags := [];
end;

procedure TdmInvoice.dspInvUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
  DataSet.FieldByName('SALESCREDIT').ProviderFlags := [];
  DataSet.FieldByName('CLIENTNAME').ProviderFlags := [];
  DataSet.FieldByName('AGENTNAME').ProviderFlags := [];
  DataSet.FieldByName('TOWNPROVINCE').ProviderFlags := [];
  DataSet.FieldByName('BALANCE').ProviderFlags := [];
end;

procedure TdmInvoice.FilterInvoices(parameters: array of Variant);
begin
  with sqlInvoice do begin
    ParamByName('START_DATE').DataType   := ftDate;
    ParamByName('END_DATE').DataType     := ftDate;
    ParamByName('TXN_PERIOD').DataType   := ftString;
    ParamByName('CLIENT_ID').DataType    := ftInteger;
    ParamByName('AGENT_ID').DataType     := ftInteger;
    ParamByName('TOWN_ID').DataType      := ftInteger;
    ParamByName('TXN_NUMBER').DataType   := ftString;

    ParamByName('START_DATE').Value   := parameters[0];
    ParamByName('END_DATE').Value     := parameters[1];
    ParamByName('TXN_PERIOD').Value   := parameters[2];
    ParamByName('CLIENT_ID').Value    := parameters[3];
    ParamByName('AGENT_ID').Value     := parameters[4];
    ParamByName('TOWN_ID').Value      := parameters[5];
    ParamByName('TXN_NUMBER').Value   := parameters[6];
  end;
  OpenInvoices;
end;

procedure TdmInvoice.cdsInv2BeforePost(DataSet: TDataSet);
begin
  with DataSet do 
    FieldByName('PriceTotal').AsFloat :=
      Fieldbyname('QTYOUT').AsFloat * fieldbyname('PRICE_UNIT').AsFloat;
end;

procedure TdmInvoice.dspCol2UpdateData(Sender: TObject; DataSet:
    TCustomClientDataSet);
begin
  dataset.FieldByName('clientname').ProviderFlags := [];
end;

procedure TdmInvoice.FilterCollections(const Conflict: Boolean = true);
begin
  with SQLCol do
    CommandText := COL_CONFLICT_SQL;
  OpenCollections;
end;

end.
