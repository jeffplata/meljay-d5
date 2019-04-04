unit InvoicesU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, PngImageList, 
  ActnList, ExtCtrls, StdCtrls, TB2Item,
  TB2Dock, TB2Toolbar, DB, vfi_ObjectListCDS, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxDBGrid, NxColumns, NxDBColumns,
  TB2ExtItems, Menus, ComCtrls, DSFilterU, DBClient,
  SqlExpr, MainDM, Mask, RzEdit, SpTBXItem, RzBtnEdt, RzCmboBx, Buttons,
  PngSpeedButton ;

type
  TFilterIndex =  (fiShowNone, fiPeriod, fiType, fiNumber, fiCustomer, fiAgent,
    fiBatchNo, fiAddress);

  TfmInvoices = class(TvfiObjectListCDS)
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    NxDBTextColumn5: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn6: TNxDBTextColumn;
    TBSeparatorItem1: TTBSeparatorItem;
    TBPopupMenu1: TTBPopupMenu;
    TBVisibilityToggleItem1: TTBVisibilityToggleItem;
    TBVisibilityToggleItem2: TTBVisibilityToggleItem;
    NxDBTextColumn8: TNxDBTextColumn;
    NxDBTextColumn7: TNxDBTextColumn;
    TBSubmenuItem2: TTBSubmenuItem;
    TBItem5: TTBItem;
    actReceivePayment: TAction;
    TBItem6: TTBItem;
    TBSeparatorItem9: TTBSeparatorItem;
    TBPopupMenu2: TTBPopupMenu;
    TBVisibilityToggleItem3: TTBVisibilityToggleItem;
    TBVisibilityToggleItem4: TTBVisibilityToggleItem;
    actPrintList: TAction;
    NxDBTextColumn9: TNxDBTextColumn;
    NxDBTextColumn10: TNxDBTextColumn;
    tbiCancelChangeSep: TTBSeparatorItem;
    tbiCancelChange: TTBItem;
    TBToolbar1: TTBToolbar;
    TBControlItem15: TTBControlItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label7: TLabel;
    sbPeriods: TPngSpeedButton;
    sbClearDates: TPngSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    sbClearBatch: TPngSpeedButton;
    sbClearCustomer: TPngSpeedButton;
    Label10: TLabel;
    sbClearNumber: TPngSpeedButton;
    sbApply: TPngSpeedButton;
    Label11: TLabel;
    sbClearShowWhat: TPngSpeedButton;
    sbReset: TPngSpeedButton;
    Label12: TLabel;
    sbClearSalesRep: TPngSpeedButton;
    dateEdit1: TRzDateTimeEdit;
    dateEdit2: TRzDateTimeEdit;
    edtFilterNumber: TEdit;
    cmbShowWhat: TComboBox;
    edtFilterCustomer: TRzButtonEdit;
    edtFilterSalesRep: TRzButtonEdit;
    edtFilterBatchNo: TEdit;
    edtFilterAddress: TRzButtonEdit;
    sbClearAddress: TPngSpeedButton;
    Label13: TLabel;
    TBPopupMenu3: TTBPopupMenu;
    tbiToday: TTBItem;
    TBItem7: TTBItem;
    TBItem8: TTBItem;
    TBItem9: TTBItem;
    tbThisMonth: TTBItem;
    TBItem11: TTBItem;
    TBItem12: TTBItem;
    TBItem13: TTBItem;
    TBItem14: TTBItem;
    TBItem15: TTBItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure NextDBGridSortColumn(Sender: TObject; ACol: Integer;
      Ascending: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbiTodayClick(Sender: TObject);
    procedure actReceivePaymentExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure NextDBGridCellFormating(Sender: TObject; ACol, ARow: Integer;
      Value: WideString; var TextColor: TColor; var FontStyle: TFontStyles;
      CellState: TCellState);
    procedure TBSubmenuItem2Popup(Sender: TTBCustomItem;
      FromLink: Boolean);
    procedure tbiCancelChangeClick(Sender: TObject);
    procedure sbPeriodsClick(Sender: TObject);
    procedure sbApplyClick(Sender: TObject);
    procedure sbResetClick(Sender: TObject);
    procedure sbClearDatesClick(Sender: TObject);
    procedure edtFilterBatchNoKeyPress(Sender: TObject; var Key: Char);
    procedure cmbShowWhatChange(Sender: TObject);
    procedure sbClearShowWhatClick(Sender: TObject);
    procedure edtFilterCustomerButtonClick(Sender: TObject);
    procedure edtFilterCustomerKeyPress(Sender: TObject; var Key: Char);
  private
    KeyBuff: Char;
    FFilter : array[TFilterIndex] of TFilter;
    FSelectedCustomerID: integer;
    FSelectedSalesRepID: Integer;
    FSelectedTownID: Integer;

    procedure UpdateFooters;
    procedure Filter;
    procedure SelectEntity( Sender: TObject; const aKeyBuffer: string = '');
  public
    class procedure ShowForm;
  end;

var
  fmInvoices: TfmInvoices;




implementation

uses Misc, InvoiceDM, CustomerDM, Clipper;

{$R *.dfm}

{ TfmInvoices }

class procedure TfmInvoices.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmInvoices) then
    begin
      TdmInvoice.Open(dmuInvoices);
      fmInvoices := TfmInvoices.Create(Application);
    end;
    fmInvoices.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmInvoices.FormDestroy(Sender: TObject);
begin
  inherited;
  fmInvoices := nil;
end;

procedure TfmInvoices.FormCreate(Sender: TObject);
begin

  with sbClearDates do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearBatch do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearCustomer do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearNumber do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearShowWhat do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearSalesRep do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;
  with sbClearAddress do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;

  with sbPeriods do begin Flat := True; PngImage := PngImageList1.PngImages[9].PngImage end;
  with sbApply do begin Flat := True; PngImage := PngImageList1.PngImages[11].PngImage end;
  with sbReset do begin Flat := True; PngImage := PngImageList1.PngImages[3].PngImage end;


  dateEdit1.Date := Clipper.BoM(Now);
  dateEdit2.Date := Clipper.EoM(Now);


  Filter;
  DataSource1.DataSet := dmInvoice.cdsInv;
  DataSource1.DataSet.Filter := 'Balance > 0';  // filter for paid/unpaid
  inherited;  //inherited loads grid layout, hence, data first

end;

procedure TfmInvoices.actAppendExecute(Sender: TObject);
begin
  dmInvoice.cdsInv.Append;
  dmInvoice.EditInvoice;
  UpdateFooters;
end;

procedure TfmInvoices.actEditExecute(Sender: TObject);
begin
  dminvoice.EditInvoice ;
  UpdateFooters;
end;

procedure TfmInvoices.NextDBGridSortColumn(Sender: TObject; ACol: Integer;
  Ascending: Boolean);
begin
  NDBGSortColumn(Sender,ACol,Ascending);
end;

procedure TfmInvoices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TdmCustomer.Close(dmuInvoices);
  TdmInvoice.Close(dmuInvoices);
//  fmInvoices := nil;
end;

procedure TfmInvoices.tbiTodayClick(Sender: TObject);
var
  d1, d2: TRzDateTimeEdit;
begin
  d1 := dateEdit1;
  d2 := dateEdit2;
  case TDateTimePicker(Sender).Tag of
  1:  begin d1.Date := Date;             d2.Date := Date; end;
  11: begin d1.Date := Date-1;           d2.Date := Date-1; end;
  2:  begin d1.Date := BoW(Date+1);      d2.Date := EoW(Date+1)-1 end;
  21: begin d1.Date := BoW(Date+1)-7;    d2.Date := EoW(d1.Date+1)-1 end;
  3:  begin d1.Date := BoM(Date);        d2.Date := EoM(Date) end;
  31: begin d1.Date := BoM(BoM(Date)-1); d2.Date := EoM(d1.Date) end;
  4:  begin d1.Date := BoQ(Date);        d2.Date := EoQ(Date) end;
  41: begin d1.Date := BoQ(BoQ(Date)-1); d2.Date := EoQ(d1.Date) end;
  5:  begin d1.Date := BoY(Date);        d2.Date := EoY(Date) end;
  51: begin d1.Date := BoY(BoY(Date)-1); d2.Date := EoY(d1.Date) end;
  end;

  dateEdit1.Date := d1.Date;
  dateEdit2.Date := d2.Date;
  Filter;

end;



procedure TfmInvoices.actReceivePaymentExecute(Sender: TObject);
begin
  dmInvoice.ReceivePayment;
end;



procedure TfmInvoices.actDeleteExecute(Sender: TObject);
begin
  dmInvoice.DeleteInvoice;
  UpdateFooters;
end;

procedure TfmInvoices.NextDBGridCellFormating(Sender: TObject; ACol,
  ARow: Integer; Value: WideString; var TextColor: TColor;
  var FontStyle: TFontStyles; CellState: TCellState);
var
  amt, bal: Double;
begin
  if not Assigned(dmInvoice) then Exit;
  amt := NextDBGrid.Columns[3].Field.AsFloat;  //amount
  bal := NextDBGrid.Columns[4].Field.AsFloat;  //balance
  if dmInvoice.cdsInv.UpdateStatus in [usModified, usInserted, usDeleted] then begin
    if not (csEmpty in CellState) then
      FontStyle := FontStyle + [fsBold];
  end else
  if ACol = 4 then
    if {not(csSelected in CellState) and} not(csEmpty in CellState) then
      if amt = bal then
        FontStyle := FontStyle + [fsBold];
end;

procedure TfmInvoices.TBSubmenuItem2Popup(Sender: TTBCustomItem;
  FromLink: Boolean);
var
  ShowChangeRelated: Boolean;
begin
  ShowChangeRelated := (dmInvoice.cdsInv.UpdateStatus in [usModified, usInserted]);
  tbiCancelChangeSep.Visible := ShowChangeRelated;
  tbiCancelChange.Visible := ShowChangeRelated;
end;

procedure TfmInvoices.tbiCancelChangeClick(Sender: TObject);
begin
  dmInvoice.cdsInv.RevertRecord;
end;

procedure TfmInvoices.UpdateFooters;
var
  FooterInvAmt, FooterBalance{, FooterInvBal}: Double;
begin
  if dmInvoice.cdsInv.fieldbyname('SumInvoiceAmount').value <> null then
    footerinvamt := dmInvoice.cdsInv.fieldbyname('SumInvoiceAmount').value else
    footerinvamt := 0;
  if dmInvoice.cdsInv.FieldByName('SumBalance').Value <> null then
    FooterBalance := dmInvoice.cdsInv.fieldbyname('SumBalance').Value else
    FooterBalance := 0;
  NextDBGrid.Columns[3].Footer.Caption := FormatFloat('#,#00.00',FooterInvAmt);
  NextDBGrid.Columns[4].Footer.Caption := FormatFloat('#,#00.00',FooterBalance);
end;

procedure TfmInvoices.Filter;
var
  params: array [0..6] of Variant;
begin

  params[0] := IIFVariant(dateEdit1.Text = '',          null, dateEdit1.Text);
  params[1] := IIFVariant(dateEdit2.Text = '',          null, dateEdit2.Text);
  params[2] := IIFVariant(edtFilterBatchno.Text = '',   null, edtFilterBatchno.Text);
  params[3] := IIFVariant(edtFilterCustomer.Text = '',  null, FSelectedCustomerID);
  params[4] := IIFVariant(edtFilterSalesRep.Text = '',  null, FSelectedSalesRepID);
  params[5] := IIFVariant(edtFilterAddress.Text = '',   null, FSelectedTownID);
  params[6] := IIFVariant(edtFilterNumber.Text = '',    null, edtFilterNumber.Text);

  dmInvoice.FilterInvoices(params);
  UpdateFooters;

end;

procedure TfmInvoices.sbPeriodsClick(Sender: TObject);
var
  p: TPoint;
begin
  with sbPeriods do
    p := ClientToScreen(Point(0,Height));
  TBPopupMenu3.Popup(p.X,p.y);
end;

procedure TfmInvoices.sbApplyClick(Sender: TObject);
begin
  Filter;
end;

procedure TfmInvoices.sbResetClick(Sender: TObject);
begin
  dateEdit1.Clear;
  dateEdit2.Clear;
  edtFilterNumber.Clear;
  edtFilterCustomer.Clear;
  edtFilterSalesRep.Clear;
  edtFilterAddress.Clear;
  edtFilterBatchNo.Clear;
  cmbShowWhat.ItemIndex := 0;
end;

procedure TfmInvoices.sbClearDatesClick(Sender: TObject);
begin
  if Sender = sbClearDates then
    begin dateEdit1.Clear; dateEdit2.Clear end
  else if Sender = sbClearBatch then edtFilterBatchNo.Clear
  else if Sender = sbClearCustomer then edtFilterCustomer.Clear
  else if Sender =  sbClearNumber then edtFilterNumber.Clear
  else if Sender = sbClearSalesRep then edtFilterSalesRep.Clear
  else if Sender = sbClearAddress then edtFilterAddress.Clear;
end;

procedure TfmInvoices.edtFilterBatchNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    if (Sender = edtFilterBatchNo)
      or (Sender = edtFilterNumber)
    then Filter; 
  end;
end;

procedure TfmInvoices.cmbShowWhatChange(Sender: TObject);
begin
  DataSource1.DataSet.Filtered := (cmbShowWhat.ItemIndex > 0);
end;

procedure TfmInvoices.sbClearShowWhatClick(Sender: TObject);
begin
  cmbShowWhat.ItemIndex := 0;
  cmbShowWhatChange(cmbShowWhat);
end;

procedure TfmInvoices.edtFilterCustomerButtonClick(Sender: TObject);
begin
  SelectEntity(Sender);
end;

procedure TfmInvoices.edtFilterCustomerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    SelectEntity(Sender, Key);
    key := #0;
  end;
end;

procedure TfmInvoices.SelectEntity(Sender: TObject; const aKeyBuffer: string);
var
  ReturnVar: Variant;
begin
  if Sender = edtFilterCustomer then ReturnVar := dmCustomer.SelectCustomerEx(edtFilterCustomer, aKeyBuffer)
  else if Sender = edtFilterSalesRep then ReturnVar := dmCustomer.SelectSalesRepEx(edtFilterSalesRep, aKeyBuffer)
  else if Sender = edtFilterAddress then ReturnVar := dmCustomer.SelectTownEx(edtFilterAddress, aKeyBuffer);
  if not VarIsEmpty(ReturnVar) then begin
    if Sender = edtFilterCustomer then FSelectedCustomerID := ReturnVar[0]
    else if Sender = edtFilterSalesRep then FSelectedSalesRepID := ReturnVar[0]
    else if Sender = edtFilterAddress then FSelectedTownID := ReturnVar[0];
    Filter;
  end;
end;

end.
