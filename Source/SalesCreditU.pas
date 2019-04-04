unit SalesCreditU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_ObjectListCDS, DB, ImgList, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid, ExtCtrls,
  StdCtrls, TB2Item, TB2Dock, TB2Toolbar, NxColumns, NxDBColumns, RzEdit,
  RzBtnEdt, RzCmboBx, Mask, Buttons, PngSpeedButton, ComCtrls, Menus;

type
  TfmSalesCredit = class(TvfiObjectListCDS)
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    TBToolbar1: TTBToolbar;
    TBControlItem3: TTBControlItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    sbSelectDate: TPngSpeedButton;
    sbClearDate: TPngSpeedButton;
    Label4: TLabel;
    sbClearName: TPngSpeedButton;
    Label6: TLabel;
    sbClearNumber: TPngSpeedButton;
    pngsbFilter: TPngSpeedButton;
    pngsbReset: TPngSpeedButton;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    NumberEdit: TEdit;
    SearchEditCustomer: TRzButtonEdit;
    TBPopupMenu1: TTBPopupMenu;
    tbiToday: TTBItem;
    TBItem16: TTBItem;
    tbiThisMonth: TTBItem;
    TBItem17: TTBItem;
    TBItem18: TTBItem;
    PhantomMenu: TTBItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actAppendExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure tbiTodayClick(Sender: TObject);
    procedure sbSelectDateClick(Sender: TObject);
    procedure pngsbFilterClick(Sender: TObject);
    procedure pngsbResetClick(Sender: TObject);
    procedure SearchEditCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure SearchEditCustomerButtonClick(Sender: TObject);
    procedure sbClearDateClick(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
  private
    SelectedCustomer: variant;
    procedure Filter;
    procedure SelectCustomer( const aKeyBuffer: string = '');
  public
    class procedure ShowForm;
  end;

var
  fmSalesCredit: TfmSalesCredit;

implementation

uses
  SalesCreditDM, MainDM, Misc, Clipper, CustomerDM;

{$R *.dfm}

{ TfmSalesCredit }

class procedure TfmSalesCredit.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmSalesCredit) then begin
      TdmSalesCredit.Open(dmuSalesCredit);
      fmSalesCredit := TfmSalesCredit.Create(nil);
    end;
    fmSalesCredit.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmSalesCredit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TdmSalesCredit.Close(dmuSalesCredit);
  fmSalesCredit := nil;
end;

procedure TfmSalesCredit.FormCreate(Sender: TObject);
begin
  sbSelectDate.Flat     := true;
  sbClearDate.Flat      := True;
  sbClearName.Flat      := True;
  sbClearNumber.Flat    := True;
  sbSelectDate.PngImage  := PngImageList1.PngImages[7].PngImage;
  sbClearDate.PngImage   := PngImageList1.PngImages[3].PngImage;
  sbClearName.PngImage   := PngImageList1.PngImages[3].PngImage;
  sbClearNumber.PngImage := PngImageList1.PngImages[3].PngImage;
  pngsbFilter.PngImage   := PngImageList1.PngImages[8].PngImage;
  pngsbReset.PngImage    := PngImageList1.PngImages[3].PngImage;

  tbiThisMonth.Click;
  
  DataSource1.DataSet := dmSalesCredit.cdsSalesCr;

  inherited;   //inherited loads grid layout, hence, data first
end;

procedure TfmSalesCredit.Filter;
var
  params : array[0..3] of Variant;
  cust: Variant;
begin
  cust := null;
  if not VarIsEmpty(SelectedCustomer) then
    cust := SelectedCustomer[0];

  params[0] := IIFVariant(RzDateTimeEdit1.Text = '',     null, RzDateTimeEdit1.Text);
  params[1] := IIFVariant(RzDateTimeEdit2.Text = '',     null, RzDateTimeEdit2.Text);
  params[2] := IIFVariant(SearchEditCustomer.Text = '',  null, cust);
  params[3] := IIFVariant(NumberEdit.Text = '',          null, NumberEdit.Text);

  dmSalesCredit.FilterSalesCredits(params);

end;

procedure TfmSalesCredit.actAppendExecute(Sender: TObject);
begin
  dmSalesCredit.cdsSalesCr.Append;
  dmSalesCredit.EditSalesCredit;
end;

procedure TfmSalesCredit.actDeleteExecute(Sender: TObject);
begin
  dmSalesCredit.DeleteSalesCredit;
end;

procedure TfmSalesCredit.actEditExecute(Sender: TObject);
begin
  dmSalesCredit.EditSalesCredit;
end;

procedure TfmSalesCredit.tbiTodayClick(Sender: TObject);
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


procedure TfmSalesCredit.sbSelectDateClick(Sender: TObject);
var
  p: TPoint;
begin
  with sbSelectDate do
    p := ClientToScreen(Point(0,Height));
  TBPopupMenu1.Popup(p.X,p.y);
end;

procedure TfmSalesCredit.pngsbFilterClick(Sender: TObject);
begin
  Filter;
end;

procedure TfmSalesCredit.pngsbResetClick(Sender: TObject);
begin
  RzDateTimeEdit1.Clear;
  RzDateTimeEdit2.Clear;
  SearchEditCustomer.Clear;
  NumberEdit.Clear;
end;

procedure TfmSalesCredit.SearchEditCustomerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <#127) and (Key >#32) then begin
    //KeyBuff := Key;
    SelectCustomer( Key );
    key := #0;
  end;
end;

procedure TfmSalesCredit.SearchEditCustomerButtonClick(Sender: TObject);
begin
  SelectCustomer;
end;

procedure TfmSalesCredit.SelectCustomer( const aKeyBuffer: string );
var
  aVariant: Variant;
begin
  aVariant := dmCustomer.SelectCustomerEx(SearchEditCustomer,aKeyBuffer);
  if not VarIsEmpty(aVariant) then begin
    SelectedCustomer := aVariant;
    Filter;
  end;
end;

procedure TfmSalesCredit.sbClearDateClick(Sender: TObject);
begin
  if Sender = sbClearDate then begin
    RzDateTimeEdit1.Clear;
    RzDateTimeEdit2.Clear;
  end
  else if Sender = sbClearName then SearchEditCustomer.Clear
  else if Sender = sbClearNumber then NumberEdit.Clear;

end;

procedure TfmSalesCredit.NumberEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then begin key := #0; Filter; end;
end;

end.
