unit CustomersCdsU;

interface

uses
  Windows, SysUtils, Variants, Classes, Controls, Forms,
  vfi_ObjectListCDS, DB, ImgList, PngImageList, 
  ActnList, ExtCtrls, StdCtrls, TB2Item, TB2Dock,
  TB2Toolbar, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid,
  NxColumns, NxDBColumns, SpTBXItem, DSFilterU, MainDM, Menus, Mask,
  RzEdit, RzBtnEdt;

type
  TFilterIndex =  (fiAll, fiName, fiAddress, fiSR);

  TfmCustomersCDS = class(TvfiObjectListCDS)
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn5: TNxDBTextColumn;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSubmenuItem1: TTBSubmenuItem;
    TBItem6: TTBItem;
    TBItem7: TTBItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBItem8: TTBItem;
    TBSeparatorItem4: TTBSeparatorItem;
    SearchAddr: TEdit;
    TBControlItem3: TTBControlItem;
    tbiSearchAdr: TTBItem;
    tbiClearSearchAdr: TTBItem;
    SpTBXLabelItem1: TSpTBXLabelItem;
    actNewInvoice: TAction;
    actPrintStatement: TAction;
    TBPopupMenu1: TTBPopupMenu;
    actNewReceipt: TAction;
    actPrintBalances: TAction;
    TBItem5: TTBItem;
    TBSeparatorItem5: TTBSeparatorItem;
    tbiClearSearchSR: TTBItem;
    SpTBXLabelItem2: TSpTBXLabelItem;
    SearchSRbte: TRzButtonEdit;
    TBControlItem5: TTBControlItem;
    actClearSRSearch: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actDeleteExecute(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure NextDBGridSortColumn(Sender: TObject; ACol: Integer;
      Ascending: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tbiClearSearchAdrClick(Sender: TObject);
    procedure actNewInvoiceExecute(Sender: TObject);
    procedure actPrintStatementExecute(Sender: TObject);
    procedure actPrintBalancesExecute(Sender: TObject);
    procedure tbiClearSearchSRClick(Sender: TObject);
    procedure SearchSRbteKeyPress(Sender: TObject; var Key: Char);
    procedure SearchSRbteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchSRbteButtonClick(Sender: TObject);
    procedure actClearSRSearchExecute(Sender: TObject);
    procedure SearchSRbteChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    BaseSQL: string;
    FFilter: array[TFilterIndex] of TFilter;
    Keybuff: string;
    privFilteredState: Boolean;
    privFilter: string;
    privBookMark: string;
    procedure ApplyFilter( ADataset: TDataSet);
  public
    class procedure ShowForm;
    procedure EnterKeyPressed( sender : TObject );
  end;

var
  fmCustomersCDS: TfmCustomersCDS;

implementation

uses
  Misc, CustomerDM, uAppSettings, DBClient, SearchEditU, InvoiceDM;

{$R *.dfm}

{ TfmCustomersCDS }

class procedure TfmCustomersCDS.ShowForm;
begin
  LockWindowUpdate;
  try
    if TdmCustomer.OpenCustomers(dmuCustomers) then begin
      if not Assigned(fmCustomersCDS) then begin
        fmCustomersCDS := TfmCustomersCDS.Create(nil);
        fmCustomersCDS.BaseSQL := dmCustomer.sdsCust.CommandText;
        fmCustomersCDS.Show;
        fmCustomersCDS.NextDBGrid.SelectFirstRow();
      end else
        fmCustomersCDS.Show;
    end;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmCustomersCDS.FormDestroy(Sender: TObject);
begin
  inherited;
  fmCustomersCDS := nil;
  TdmCustomer.Close(dmuCustomers);
end;

procedure TfmCustomersCDS.actAppendExecute(Sender: TObject);
begin
  with dmCustomer do begin
    cdsCust.Append;
    actShowCustomerEditCds.Execute;
  end;
end;

procedure TfmCustomersCDS.actEditExecute(Sender: TObject);
begin
  inherited;
  dmCustomer.actShowCustomerEditCds.Execute;
end;

procedure TfmCustomersCDS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TdmInvoice.Close(dmuCustomers);   //close the invoice table, if possible
  dmCustomer.cdsCust.Filtered := false;
  TdmCustomer.Close(dmuCustomers);
  fmCustomersCDS := nil;
end;

procedure TfmCustomersCDS.actDeleteExecute(Sender: TObject);
var
  bm: string;
begin
  if MessageBox(Handle, PChar('Delete this customer?'), 'Warning', MB_YESNO +
     MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES then
    Exit;

  with TClientDataSet(DataSource1.DataSet) do
  begin
    DisableControls;
    bm := Bookmark;
    Delete;
    if ApplyUpdates(0) > 0 then
    begin
      UndoLastChange(True);
      Bookmark := bm;
    end;
    EnableControls;
  end;
end;

procedure TfmCustomersCDS.SearchEditChange(Sender: TObject);
begin
  inherited;
  ApplyFilter(dmCustomer.cdsCust);
end;

procedure TfmCustomersCDS.NextDBGridSortColumn(Sender: TObject;
  ACol: Integer; Ascending: Boolean);
begin
  NDBGSortColumn(Sender, ACol, Ascending);
end;

procedure TfmCustomersCDS.FormCreate(Sender: TObject);
var
  se: TSearchEdit;
begin
  DataSource1.DataSet := dmCustomer.cdsCust;
  inherited;
  se := InsertSearchEdit(SearchAddr,tbiSearchAdr,tbiClearSearchAdr,AppSettings.PngImageList,False);
  se.OnEnterKeyPressed := EnterKeyPressed;

  FFilter[fiName].FormatStr := 'CLIENT_NAME like ''%%%s%%''';
  FFilter[fiAddress].FormatStr := 'CompleteAddress like ''%%%s%%''';
  FFilter[fiSR].FormatStr := 'AgentName = ''%s''';

//  FFilter[fiName].Condition := 'CLIENT_NAME like ''%'+SearchEdit.Text+'%''';
//  FFilter[fiAddress].Condition := 'ADDRESS like ''%'+SearchAddr.Text+'%''';
  FFilter[fiAll].Condition := '1=1';

end;

procedure TfmCustomersCDS.EnterKeyPressed(sender: TObject);
begin
  ApplyFilter(DataSource1.DataSet);
end;

procedure TfmCustomersCDS.ApplyFilter(ADataset: TDataSet);
var
  i: TFilterIndex;
begin
  FFilter[fiAll ].Active       := True;
  FFilter[fiName].Active       := SearchEdit.Text <> '';
  FFilter[fiName].Condition    := Format(FFilter[fiName].FormatStr,[SearchEdit.Text]);
  FFilter[fiAddress].Active    := SearchAddr.Text <> '';
  FFilter[fiAddress].Condition := Format(FFilter[fiAddress].FormatStr,[SearchAddr.Text]);
  FFilter[fiSR].Active         := SearchSRbte.Text <> '';
  FFilter[fiSR].Condition      := Format(FFilter[fiSR].FormatStr, [SearchSRbte.Text]);
  for i := Succ(Low(ffilter)) to High(FFilter) do
    if FFilter[i].Active then
    begin
      FFilter[fiAll].Active := False;
      Break;
    end;

  with DataSource1.DataSet do begin
    Filter := GetFilterString(FFilter);
    Filtered := Filter <> '';
  end;
end;

procedure TfmCustomersCDS.tbiClearSearchAdrClick(Sender: TObject);
begin
  inherited;
  ApplyFilter(dmCustomer.cdsCust);
end;

procedure TfmCustomersCDS.actNewInvoiceExecute(Sender: TObject);
begin
  //todo: rewrite 'New Invoice' from Customers
  if not Assigned(dmInvoice) then begin
    TdmInvoice.Open(dmuCustomers);
//    dmInvoice.SQLDataSet1.CommandText := dmInvoice.BaseSQLInvoice +#13#10+
//      'where 1=2';
    dmInvoice.OpenInvoices;
  end;
  dmInvoice.cdsInv.Append;
  dmInvoice.cdsInv.FieldByName('CLIENT_ID').AsInteger :=
    dmCustomer.cdsCust.fieldbyname('CLIENT_ID').AsInteger;
  dmInvoice.cdsInv.FieldByName('ClientName').AsString :=
    dmCustomer.cdsCust.fieldbyname('CLIENT_NAME').AsString;
  dmInvoice.cdsInv.FieldByName('AGENT_ID').AsInteger :=
    dmCustomer.cdsCust.fieldbyname('AGENT_ID').AsInteger;
  dmInvoice.cdsInv.FieldByName('AgentName').AsString :=
    dmCustomer.cdsCust.fieldbyname('AgentName').AsString;
  dmInvoice.EditInvoice;
end;

procedure TfmCustomersCDS.actPrintStatementExecute(Sender: TObject);
begin
  dmCustomer.PrintReport('cus_Statement',dmCustomer.cdsCustRpt);
end;

procedure TfmCustomersCDS.actPrintBalancesExecute(Sender: TObject);
begin
  dmCustomer.FilterStrName := SearchEdit.text;
  dmCustomer.FilterStrAddress := SearchAddr.text;
  dmCustomer.PrintReport('cus_Balances_where',dmCustomer.cdsCustRpt);
end;

procedure TfmCustomersCDS.tbiClearSearchSRClick(Sender: TObject);
begin
  inherited;
  ApplyFilter(dmCustomer.cdsCust);
end;

procedure TfmCustomersCDS.SearchSRbteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key >#31) and (Key <#127) then
    dmCustomer.SelectSalesRep(SearchSRbte.Text);
end;

procedure TfmCustomersCDS.SearchSRbteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F2 then dmcustomer.selectsalesrep(SearchSRbte.Text);
end;

procedure TfmCustomersCDS.SearchSRbteButtonClick(Sender: TObject);
var
  selectedsr : Variant;
begin
  SelectedSR := dmCustomer.SelectSalesRep(Keybuff);
  Keybuff := '';
  if not VarIsEmpty(SelectedSR) then begin
    SearchSRbte.Text := SelectedSR[1];
    ApplyFilter(dmCustomer.cdsCust);
  end;
end;

procedure TfmCustomersCDS.actClearSRSearchExecute(Sender: TObject);
begin
  SearchSRbte.Text := '';
  actClearSRSearch.Enabled := false;
  ApplyFilter(dmCustomer.cdsCust);
end;

procedure TfmCustomersCDS.SearchSRbteChange(Sender: TObject);
begin
  actClearSRSearch.Enabled := SearchSRbte.Text <> '';
end;

procedure TfmCustomersCDS.FormDeactivate(Sender: TObject);
begin
  privFilteredState := DataSource1.DataSet.Filtered;
  privFilter := DataSource1.DataSet.Filter;
  privBookMark := DataSource1.DataSet.Bookmark;
end;

procedure TfmCustomersCDS.FormActivate(Sender: TObject);
begin
  DataSource1.DataSet.Filter := privFilter;
  DataSource1.DataSet.Filtered := privFilteredState;
  try
    DataSource1.DataSet.Bookmark := privBookMark;
  except
  end;
end;

end.

