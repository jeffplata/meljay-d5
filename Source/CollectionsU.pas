unit CollectionsU;

interface

uses
  Windows, SysUtils, Variants, Classes, Controls, Forms,
  vfi_ObjectListCDS, DB, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid, ExtCtrls,
  StdCtrls, TB2Item, TB2Dock, TB2Toolbar, DSFilterU, ComCtrls, 
  NxColumns, NxDBColumns, RzCmboBx, FilterItems,
  RzEdit, Buttons, PngSpeedButton, RzBtnEdt, ImgList, Menus, Mask;

type
  TFilterIndex = (fiNone, fiPeriod, fiApplied, fiNumber, fiCustomer, fiType);

  TfmCollections = class(TvfiObjectListCDS)
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn5: TNxDBTextColumn;
    NxDBTextColumn6: TNxDBTextColumn;
    NxDBTextColumn7: TNxDBTextColumn;
    actGoFilter: TAction;
    TBToolbar1: TTBToolbar;
    PageControl1: TPageControl;
    TBControlItem4: TTBControlItem;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    PngSpeedButton1: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    Label4: TLabel;
    TypeRzCombo: TRzComboBox;
    Label5: TLabel;
    PngSpeedButton3: TPngSpeedButton;
    PngSpeedButton4: TPngSpeedButton;
    NumberEdit: TEdit;
    Label6: TLabel;
    PngSpeedButton5: TPngSpeedButton;
    PngSpeedButton6: TPngSpeedButton;
    TBPopupMenu1: TTBPopupMenu;
    TBItem15: TTBItem;
    TBItem16: TTBItem;
    tbiThisMonth: TTBItem;
    TBItem17: TTBItem;
    TBItem18: TTBItem;
    ComboBox1: TComboBox;
    Label3: TLabel;
    PngSpeedButton7: TPngSpeedButton;
    PngSpeedButton8: TPngSpeedButton;
    SearchEditCustomer: TRzButtonEdit;
    PhantomMenu: TTBItem;
    TBPopupMenu2: TTBPopupMenu;
    TBItem5: TTBItem;
    NxDBTextColumn8: TNxDBTextColumn;
    SearchEditCollector: TRzButtonEdit;
    Label7: TLabel;
    PngSpeedButton9: TPngSpeedButton;
    PngSpeedButton10: TPngSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbiTodayClick(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure SearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure NextDBGridSortColumn(Sender: TObject; ACol: Integer;
      Ascending: Boolean);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure TypeRzComboDropDown(Sender: TObject);
    procedure TypeRzComboCloseUp(Sender: TObject);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure PngSpeedButton2Click(Sender: TObject);
    procedure PngSpeedButton3Click(Sender: TObject);
    procedure PngSpeedButton4Click(Sender: TObject);
    procedure PngSpeedButton5Click(Sender: TObject);
    procedure PngSpeedButton6Click(Sender: TObject);
    procedure PngSpeedButton7Click(Sender: TObject);
    procedure PngSpeedButton8Click(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure PngSpeedButton10Click(Sender: TObject);
    procedure SearchEditCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure SearchEditCustomerButtonClick(Sender: TObject);
    procedure SearchEditCollectorKeyPress(Sender: TObject; var Key: Char);
    procedure PngSpeedButton9Click(Sender: TObject);
    procedure SearchEditCollectorButtonClick(Sender: TObject);
    procedure SearchEditCollectorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FFilterItems : TFilterItems;
    FFilter : array[fiNone..fiType] of TFilter;
    KeyBuff: Char;
    SelectedCustomer, SelectedCollector: Variant;
    procedure SelectCustomer;
    procedure SelectCollector( const AKeybuffer: string );
    procedure Filter;
    procedure UpdateFooters;
  public
    class procedure ShowForm;
  end;

var
  fmCollections: TfmCollections;

implementation

uses
  InvoiceDM, Misc, Clipper, CustomerDM, UnpaidInvSelectionU,
  MainDM;

{$R *.dfm}

{ TfmCollections }

class procedure TfmCollections.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmCollections) then
    begin
      TdmInvoice.Open(dmuCollections);
      fmCollections := TfmCollections.Create(nil);
    end;
    fmCollections.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmCollections.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmInvoice.CloseCollections;
end;

procedure TfmCollections.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fmUnpaidInvSelection);
  fmCollections := nil;
end;

procedure TfmCollections.FormCreate(Sender: TObject);
begin
  PngSpeedButton1.Flat := True;
  PngSpeedButton2.Flat := True;
  PngSpeedButton3.Flat := True;
  PngSpeedButton4.Flat := True;
  PngSpeedButton5.Flat := True;
  PngSpeedButton6.Flat := True;
  PngSpeedButton7.Flat := True;
  PngSpeedButton8.Flat := True;
  PngSpeedButton9.Flat := True;
  PngSpeedButton1.PngImage := PngImageList1.PngImages[9].PngImage;
  PngSpeedButton2.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton3.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton4.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton5.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton6.PngImage := PngImageList1.PngImages[10].PngImage;
  PngSpeedButton7.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton8.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton9.PngImage := PngImageList1.PngImages[3].PngImage;
  PngSpeedButton10.Flat := True;
  PngSpeedButton10.PngImage := PngImageList1.PngImages[11].PngImage;
  ActiveControl := NextDBGrid;

  {
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
  }


  TypeRzCombo.Items.Add('Cash');
  TypeRzCombo.Items.Add('Affidavit');
  TypeRzCombo.Items.Add('Discount');

  TypeRzCombo.Values.Add('CAS');
  TypeRzCombo.Values.Add('AFF');
  TypeRzCombo.Values.Add('DIS');


  tbiThisMonth.Click;


  DataSource1.DataSet := dmInvoice.cdsCol;
  inherited;  //inherited loads grid layout, hence, data first

end;
{
procedure TfmCollections.ApplyFilter(ADataset: TClientDataSet;
  ASourceDS: TSQLDataSet);
var
  FilterStr: string;
  i: TFilterIndex;
begin
  //FFilter[fiperiod  ].Active := DateTimePicker1.Checked;
  FFilter[fiperiod  ].Active := (RzDateTimeEdit1.Date <> 0);
  FFilter[fiApplied ].Active := ComboBox1.ItemIndex > 0;
  FFilter[finumber  ].Active := SearchEdit.Text <> '';
  FFilter[ficustomer].Active := SearchEditCustomer.Text <> '';
  FFilter[fiType    ].Active := TypeRzCombo.ItemIndex > 0;
  

  FFilter[finone].Active     := True;
  //ShowMessage(IntToStr(Low(ffilter)));
  for i := Succ(Low(ffilter)) to High(ffilter) do     //fiperiod to ficustomer do
    if FFilter[i].Active then
    begin
      FFilter[finone].Active := False;
      Break;
    end;

  FilterStr := GetFilterString(FFilter);
  ASourceDS.CommandText := dmInvoice.BaseSQLCollection;
  if FilterStr <> '' then
    ASourceDS.CommandText := dmInvoice.BaseSQLCollection + #13#10' WHERE ' + FilterStr;

  with dmInvoice do
  begin
    if FFilter[finumber].Active then
      SQLCol.ParamByName('COL_NUMBER').Value := SearchEdit.Text;
    if FFilter[fiperiod].Active then begin
      //SQLCol.ParamByName('FROMDATE').Value := DateToStr(DateTimePicker1.Date);
      //SQLCol.ParamByName('TODATE').Value := DateToStr(DateTimePicker2.Date);
      SQLCol.ParamByName('FROMDATE').Value := DateToStr(RzDateTimeEdit1.Date);
      SQLCol.ParamByName('TODATE').Value := DateToStr(RzDateTimeEdit2.Date);
    end;
    if FFilter[ficustomer].Active then
      SQLCol.ParamByName('CLIENT_ID').Value := dmInvoice.SelectedCustomer[0];
    if FFilter[fitype].Active then
      SQLCol.ParamByName('COL_TYPE').Value := TypeRzCombo.Values[TypeRzCombo.ItemIndex];

    OpenCollections;

    tbiClearSearch.Enabled := FFilter[fiNumber].Active;
    tbiClearCustomer.Enabled := FFilter[fiCustomer].Active;
    tbiClearAll.Enabled := FilterStr <> ''; //not FFilter[fiNone].Active;
    //tbiClearAll.Enabled := not FFilter[fiNone].Active;

  end;
end;
}
procedure TfmCollections.tbiTodayClick(Sender: TObject);
var
  d1, d2: TDateTime;
begin

  d1 := RzDateTimeEdit1.Date;
  d2 := RzDateTimeEdit2.Date;
  case TComponent(Sender).Tag of
  0: {today} begin d1 := Date;         d2 := Date end;
  1: {week}  begin d1 := BoW(Date+1);  d2 := EoW(Date+1)-1 end;
  2: {month} begin d1 := BoM(Date);    d2 := EoM(Date) end;
  3: {last90}begin d1 := Date-90;      d2 := Date end;
  4: {year}  begin d1 := BoY(Date);    d2 := EoY(Date) end;
  end;

  RzDateTimeEdit1.Date := d1;
  RzDateTimeEdit2.Date := d2;
  Filter;
end;

procedure TfmCollections.ComboBox1DropDown(Sender: TObject);
begin
  ComboBox1.Tag := ComboBox1.ItemIndex;
end;

procedure TfmCollections.ComboBox1CloseUp(Sender: TObject);
begin
  if ComboBox1.ItemIndex <> ComboBox1.Tag then
    Filter;
end;

procedure TfmCollections.SearchEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) and (SearchEdit.Text<>'') then begin
    key := #0;
  end;
end;

procedure TfmCollections.NextDBGridSortColumn(Sender: TObject;
  ACol: Integer; Ascending: Boolean);
begin
  NDBGSortColumn(Sender,ACol,Ascending);
end;

procedure TfmCollections.actAppendExecute(Sender: TObject);
begin
  dmInvoice.cdsCol.Append;
  dmInvoice.EditCollection;
end;

procedure TfmCollections.actEditExecute(Sender: TObject);
begin
  dmInvoice.EditCollection;
end;

procedure TfmCollections.actDeleteExecute(Sender: TObject);
begin
  inherited;
  dmInvoice.DeleteCollection;
end;

procedure TfmCollections.TypeRzComboDropDown(Sender: TObject);
begin
  TypeRzCombo.Tag := TypeRzCombo.ItemIndex;
end;

procedure TfmCollections.TypeRzComboCloseUp(Sender: TObject);
begin
  if TypeRzCombo.ItemIndex <> TypeRzCombo.Tag then
    Filter;
end;

procedure TfmCollections.Filter;
var
  params : array[0..6] of Variant;
  cust, collector: Variant;
begin
  cust := null;
  if not VarIsEmpty(SelectedCustomer) then
    cust := SelectedCustomer[0];
  collector := null;
  if not VarIsEmpty(SelectedCollector) then
    collector := SelectedCollector[0];

  params[0] := IIFVariant(RzDateTimeEdit1.Text = '',     null, RzDateTimeEdit1.Text);
  params[1] := IIFVariant(RzDateTimeEdit2.Text = '',     null, RzDateTimeEdit2.Text);
  params[2] := IIFVariant(SearchEditCustomer.Text = '',  null, cust);
  params[3] := IIFVariant(SearchEditCollector.Text = '', null, collector);
  params[4] := IIFVariant(TypeRzCombo.ItemIndex < 0,     null, TypeRzCombo.Value);
  params[5] := IIFVariant(NumberEdit.Text = '',          null, NumberEdit.Text);
  params[6] := IIFVariant(ComboBox1.ItemIndex < 1,       null, 1);

  dmInvoice.FilterCollections(params);
  UpdateFooters;
end;

procedure TfmCollections.PngSpeedButton1Click(Sender: TObject);
var
  p: TPoint;
begin
  with PngSpeedButton1 do
    p := ClientToScreen(Point(0,Height));
  TBPopupMenu1.Popup(p.X,p.y);
end;

procedure TfmCollections.PngSpeedButton2Click(Sender: TObject);
begin
  RzDateTimeEdit1.Clear;
  RzDateTimeEdit2.Clear;
  PhantomMenu.Checked := True;
end;

procedure TfmCollections.PngSpeedButton3Click(Sender: TObject);
begin
  TypeRzCombo.ItemIndex := -1;
end;

procedure TfmCollections.PngSpeedButton4Click(Sender: TObject);
begin
  SearchEditCustomer.Text := '';
end;

procedure TfmCollections.PngSpeedButton5Click(Sender: TObject);
begin
  NumberEdit.Text := '';
end;

procedure TfmCollections.PngSpeedButton6Click(Sender: TObject);
begin
  Filter;
end;

procedure TfmCollections.PngSpeedButton7Click(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
end;

procedure TfmCollections.PngSpeedButton8Click(Sender: TObject);
begin
  RzDateTimeEdit1.Clear;
  RzDateTimeEdit2.Clear;
  TypeRzCombo.ItemIndex := -1;
  SearchEditCustomer.Clear;
  SearchEditCollector.Clear;
  NumberEdit.Clear;
  ComboBox1.ItemIndex := 0;
end;

procedure TfmCollections.NumberEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13 ) and (NumberEdit.Text <> '') then
    Filter;
end;

procedure TfmCollections.PngSpeedButton10Click(Sender: TObject);
begin
  dmInvoice.FilterCollections;
end;

procedure TfmCollections.SearchEditCustomerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    KeyBuff := Key;
    SelectCustomer;
    key := #0;
  end;
end;

procedure TfmCollections.SelectCustomer;
begin
  //SelectedCustomer := dmInvoice.SelectCustomer(dmuCollections, KeyBuff);
  SelectedCustomer := dmCustomer.SelectCustomerEx(SearchEditCustomer, KeyBuff );
  if not VarIsEmpty(SelectedCustomer) then begin
    //SearchEditCustomer.Text := SelectedCustomer[1];
    Filter;
  end;
  KeyBuff := #0;
end;

procedure TfmCollections.SearchEditCustomerButtonClick(Sender: TObject);
begin
  SelectCustomer;
end;

procedure TfmCollections.UpdateFooters;
var
  ColAmount, UnAppliedAmt: Double;
begin
  if dmInvoice.cdsCol.fieldbyname('SumAmount').value <> null then
    ColAmount := dmInvoice.cdsCol.fieldbyname('SumAmount').value else
    ColAmount := 0;
  if dmInvoice.cdsCol.fieldbyname('SumUnApplied').value <> null then
    UnAppliedAmt := dmInvoice.cdsCol.fieldbyname('SumUnApplied').value else
    UnAppliedAmt := 0;
  NextDBGrid.Columns[3].Footer.Caption := FormatFloat('#,#00.00',ColAmount);
  NextDBGrid.Columns[4].Footer.Caption := FormatFloat('#,#00.00',UnAppliedAmt);
end;

procedure TfmCollections.SearchEditCollectorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    SelectCollector(Key);
    key := #0;
  end;
end;

procedure TfmCollections.PngSpeedButton9Click(Sender: TObject);
begin
  SearchEditCollector.Text := '';
end;

procedure TfmCollections.SelectCollector(const AKeybuffer: string);
begin
  SelectedCollector := dmCustomer.SelectCollector(AKeybuffer);
  if not VarIsEmpty(SelectedCollector) then begin
    SearchEditCollector.Text := SelectedCollector[1];
    Filter;
  end;
end;

procedure TfmCollections.SearchEditCollectorButtonClick(Sender: TObject);
begin
  SelectCollector('');
end;

procedure TfmCollections.SearchEditCollectorKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then SelectCollector('');
end;

end.
