unit CollectionsUni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_ObjectListCDS, DB, ImgList, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid, ExtCtrls,
  StdCtrls, TB2Item, TB2Dock, TB2Toolbar, DSFilterU, ComCtrls, DBClient,
  SqlExpr, NxColumns, NxDBColumns, SpTBXItem, RzCmboBx, FilterItems, Mask,
  RzEdit, RzBtnEdt;

type
  TFilterIndex = (fiNone, fiPeriod, fiApplied, fiNumber, fiCustomer, fiType);

  TfmCollectionsUni = class(TvfiObjectListCDS)
    tbiClearCustomer: TTBItem;
    tbiCustomerOpen: TTBItem;
    TBSeparatorItem5: TTBSeparatorItem;
    tbiClearAll: TTBItem;
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn5: TNxDBTextColumn;
    NxDBTextColumn6: TNxDBTextColumn;
    NxDBTextColumn7: TNxDBTextColumn;
    actGoFilter: TAction;
    TBSubmenuItem1: TTBSubmenuItem;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    SearchEditCustomer: TEdit;
    tbiToday: TTBItem;
    TBItem5: TTBItem;
    TBItem6: TTBItem;
    TBItem7: TTBItem;
    TBItem8: TTBItem;
    TBItem9: TTBItem;
    TBItem10: TTBItem;
    TBItem11: TTBItem;
    TBItem12: TTBItem;
    TBItem13: TTBItem;
    TBItem14: TTBItem;
    TBControlItem4: TTBControlItem;
    TBControlItem5: TTBControlItem;
    SpTBXLabelItem1: TSpTBXLabelItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBSeparatorItem6: TTBSeparatorItem;
    TBSeparatorItem1: TTBSeparatorItem;
    SpTBXLabelItem2: TSpTBXLabelItem;
    CustomerEditBtn: TRzButtonEdit;
    TBControlItem3: TTBControlItem;
    tbiClearDate: TTBItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbiClearCustomerClick(Sender: TObject);
    procedure tbiCustomerOpenClick(Sender: TObject);
    procedure tbiClearAllClick(Sender: TObject);
    procedure tbiTodayClick(Sender: TObject);
    procedure SearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure SearchEditCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure NextDBGridSortColumn(Sender: TObject; ACol: Integer;
      Ascending: Boolean);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure ActClearSearchExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actGoFilterExecute(Sender: TObject);
    procedure CustomerEditBtnKeyPress(Sender: TObject; var Key: Char);
    procedure CustomerEditBtnButtonClick(Sender: TObject);
  private
    FFilterItems : TFilterItems;
    FFilter : array[fiNone..fiType] of TFilter;
    KeyBuff: Char;
    procedure ApplyFilter( ADataset: TClientDataSet; ASourceDS: TSQLDataSet);
  public
    class procedure ShowForm;
  end;

var
  fmCollectionsUni: TfmCollectionsUni;

implementation

uses
  InvoiceDM, Misc, Clipper, CustomerDM, SearchEditU, UnpaidInvSelectionU,
  MainDM, CollectionsU;

{$R *.dfm}

{ TfmCollections }

class procedure TfmCollectionsUni.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmCollectionsUni) then
    begin
      TdmInvoice.Open(dmuCollections);
      fmCollectionsUni := TfmCollectionsUni.Create(nil);
    end;
    fmCollectionsUni.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmCollectionsUni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmInvoice.CloseCollections;
end;

procedure TfmCollectionsUni.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fmUnpaidInvSelection);
  fmCollectionsUni := nil;
end;

procedure TfmCollectionsUni.FormCreate(Sender: TObject);
begin

  FFilter[fiNone    ].Condition := '1=2';
  FFilter[fiperiod  ].condition := 'COL_DATE between :FROMDATE and :TODATE';
  FFilter[fiapplied ].Condition := 'COL_AMOUNTAPPLIED < COL_AMOUNT';
  FFilter[finumber  ].Condition := 'COL_NUMBER containing :COL_NUMBER';
  FFilter[ficustomer].Condition := 'CLIENT_ID = :CLIENT_ID';
  FFilter[fiType    ].Condition := 'COL_TYPE = :COL_TYPE';

  FFilterItems := TFilterItems.Create(Self);
  FFilterItems['PERIOD'  ] := 'COL_DATE between :FROMDATE and :TODATE';
  FFilterItems['APPLIED' ] := 'COL_AMOUNTAPPLIED < COL_AMOUNT';
  FFilterItems['NUMBER'  ] := 'COL_NUMBER containing :COL_NUMBER';
  FFilterItems['CUSTOMER'] := 'CLIENT_ID = :CLIENT_ID';
  FFilterItems['COL_TYPE'] := 'COL_TYPE = :COL_TYPE';
  FFilterItems.Active['PERIOD'  ] := False;
  FFilterItems.active['APPLIED' ] := False;
  FFilterItems.active['NUMBER'  ] := False;
  FFilterItems.active['CUSTOMER'] := False;
  //ShowMessage(FFilterItems.Condition['APPLIED']);

  RzDateTimeEdit1.Date := Clipper.BoM(Now);
  RzDateTimeEdit2.Date := Clipper.EoM(Now);

  //dmInvoice.OpenCollectionsUni;

  datasource1.DataSet := dmInvoice.cdsCollection;
  ApplyFilter(nil,nil);
  
  inherited;  //inherited loads grid layout, hence, data first

end;

procedure TfmCollectionsUni.ApplyFilter(ADataset: TClientDataSet;
  ASourceDS: TSQLDataSet);
var
  FilterStr: string;
  i: TFilterIndex;
  startDateParam, endDateParam, client_id, col_type, col_number: Variant;
begin
  //FFilter[fiperiod  ].Active := DateTimePicker1.Checked;
  FFilter[fiperiod  ].Active := (RzDateTimeEdit1.Date <> 0);
  //FFilter[fiApplied ].Active := ComboBox1.ItemIndex > 0;
  FFilter[finumber  ].Active := SearchEdit.Text <> '';
  FFilter[ficustomer].Active := SearchEditCustomer.Text <> '';
  //FFilter[fiType    ].Active := TypeRzCombo.ItemIndex > 0;
  

  FFilter[finone].Active     := True;

  for i := Succ(Low(ffilter)) to High(ffilter) do     //fiperiod to ficustomer do
    if FFilter[i].Active then
    begin
      FFilter[finone].Active := False;
      Break;
    end;

  if RzDateTimeEdit2.Text = '' then RzDateTimeEdit2.Text := RzDateTimeEdit1.Text;
  if RzDateTimeEdit1.Text <> '' then
    begin
      startDateParam := RzDateTimeEdit1.Text;
      endDateParam   := RzDateTimeEdit2.Text;
    end else
    begin
      startDateParam := null;
      endDateParam   := null;
    end;

  client_id  := IIFVariant(CustomerEditBtn.Text <> '', dmInvoice.SelectedCustomer[0], null);
  //col_type   := IIFVariant(TypeRzCombo.Value <> '<Any>', TypeRzCombo.Value,null);
  col_number := IIFVariant(SearchEdit.Text <> '', SearchEdit.Text, null);

  dmInvoice.FilterCollections([startDateParam,endDateParam,col_type,col_number]);
end;

procedure TfmCollectionsUni.tbiClearCustomerClick(Sender: TObject);
begin
  //SearchEditCustomer.Text := '';
  CustomerEditBtn.Text := '';
  ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
end;

procedure TfmCollectionsUni.tbiCustomerOpenClick(Sender: TObject);
var
  SelectedCustomer: Variant;
begin
//todo: attach searchcuustedit to to applyfilter 
  SelectedCustomer := dmInvoice.SelectCustomer(dmuCollections, KeyBuff);
  if not VarIsEmpty(SelectedCustomer) then begin
    SearchEditCustomer.Text := SelectedCustomer[1];
    ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
  end;
  KeyBuff := #0;
end;

procedure TfmCollectionsUni.tbiClearAllClick(Sender: TObject);
begin
  SearchEdit.Text := '';
  //ComboBox1.ItemIndex := 0;
  //TypeRzCombo.ItemIndex := 0;
  SearchEditCustomer.Text := '';
  //DateTimePicker1.Checked := False;
  //DateTimePicker2.Checked := False;
  RzDateTimeEdit1.Clear;
  RzDateTimeEdit2.Clear;
  //ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
  dmInvoice.FilterCollections([null,null,null,'__DUMMY__']);
  tbiClearAll.Enabled := False;
end;

procedure TfmCollectionsUni.tbiTodayClick(Sender: TObject);
var
  d1, d2: TDateTime;
begin
  //d1 := DateTimePicker1;
  //d2 := DateTimePicker2;
  d1 := RzDateTimeEdit1.Date;
  d2 := RzDateTimeEdit2.Date;
  case TComponent(Sender).Tag of
  1:  begin d1 := Date;             d2 := Date; end;
  11: begin d1 := Date-1;           d2 := Date-1; end;
  2:  begin d1 := BoW(Date+1);      d2 := EoW(Date+1)-1 end;
  21: begin d1 := BoW(Date+1)-7;    d2 := EoW(d1+1)-1 end;
  3:  begin d1 := BoM(Date);        d2 := EoM(Date) end;
  31: begin d1 := BoM(BoM(Date)-1); d2 := EoM(d1) end;
  4:  begin d1 := BoQ(Date);        d2 := EoQ(Date) end;
  41: begin d1 := BoQ(BoQ(Date)-1); d2 := EoQ(d1) end;
  5:  begin d1 := BoY(Date);        d2 := EoY(Date) end;
  51: begin d1 := BoY(BoY(Date)-1); d2 := EoY(d1) end;
  end;

  RzDateTimeEdit1.Date := d1;
  RzDateTimeEdit2.Date := d2;
  ApplyFilter(dminvoice.cdsCol, dmInvoice.SQLCol);
end;

procedure TfmCollectionsUni.SearchEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and (SearchEdit.Text<>'') then begin
    ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
    key := #0;
  end;
end;

procedure TfmCollectionsUni.SearchEditCustomerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    KeyBuff := Key;
    tbiCustomerOpen.Click;
    key := #0;
  end;
end;

procedure TfmCollectionsUni.NextDBGridSortColumn(Sender: TObject;
  ACol: Integer; Ascending: Boolean);
begin
  NDBGSortColumn(Sender,ACol,Ascending);
end;

procedure TfmCollectionsUni.actAppendExecute(Sender: TObject);
begin
  dmInvoice.cdsCol_Edit.Append;
  //dmInvoice.actShowCollectionEdit.Execute;
  dmInvoice.EditCollection;
end;

procedure TfmCollectionsUni.actEditExecute(Sender: TObject);
begin
  dmInvoice.EditCollection;
end;

procedure TfmCollectionsUni.ActClearSearchExecute(Sender: TObject);
begin
  inherited;
  ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
end;

procedure TfmCollectionsUni.actDeleteExecute(Sender: TObject);
begin
  inherited;
  dmInvoice.DeleteCollection;
end;

procedure TfmCollectionsUni.actGoFilterExecute(Sender: TObject);
begin
  ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
end;

procedure TfmCollectionsUni.CustomerEditBtnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    KeyBuff := Key;
    //tbiCustomerOpen.Click;
    CustomerEditBtn.Button.Click;
    key := #0;
  end;
end;

procedure TfmCollectionsUni.CustomerEditBtnButtonClick(Sender: TObject);
var
  SelectedCustomer: Variant;
begin
//todo: attach searchcuustedit to to applyfilter 
  SelectedCustomer := dmInvoice.SelectCustomer(dmuCollections, KeyBuff);
  if not VarIsEmpty(SelectedCustomer) then begin
    //SearchEditCustomer.Text := SelectedCustomer[1];
    CustomerEditBtn.Text := SelectedCustomer[1];
    ApplyFilter(dmInvoice.cdsCol,dmInvoice.SQLCol);
  end;
  KeyBuff := #0;
end;

end.
