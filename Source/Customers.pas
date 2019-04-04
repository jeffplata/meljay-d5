unit Customers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_TableViewer, DB, ImgList, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid,
  MyNextDBGrid, ExtCtrls, TB2Item, TB2Dock, TB2Toolbar, SQLWhereBuilderNV,
  RzBtnEdt, StdCtrls, Mask, RzEdit, Buttons, PngSpeedButton, ComCtrls,
  MyPngSpeedButton, RzSpnEdt;

type
  TlstCustomers = class(TvfiTableViewer)
    actFilter: TAction;
    TBToolbar1: TTBToolbar;
    TBControlItem15: TTBControlItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzButtonEdit1: TRzButtonEdit;
    sbClearName: TMyPngSpeedButton;
    sbClearAdd: TMyPngSpeedButton;
    sbClearSalesRep: TMyPngSpeedButton;
    sbApply: TMyPngSpeedButton;
    sbReset: TMyPngSpeedButton;
    RzSpinEdit1: TRzSpinEdit;
    Label1: TLabel;
    procedure actFilterExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzSpinEdit1Change(Sender: TObject);
    procedure sbApplyClick(Sender: TObject);
    procedure sbClearNameClick(Sender: TObject);
    procedure sbResetClick(Sender: TObject);
  private
    sqlWhereClauses: TSQLWhereBuilder;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lstCustomers: TlstCustomers;

implementation

uses
  CustomerDM, dmi_Generic, TypesImages, AppSettingsU;

{$R *.dfm}

procedure TlstCustomers.actFilterExecute(Sender: TObject);
begin
  sqlWhereClauses.UpdateWhereClauses;
  dmCustomer.FilterCustomer(sqlWhereClauses.WhereList.Text);
end;

procedure TlstCustomers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  TdmCustomer.CloseDM(self.Name,tdmigeneric(dmCustomer));
  lstCustomers := nil;
  inherited;
end;

procedure TlstCustomers.FormCreate(Sender: TObject);
begin
  sbClearName.PngImage := AppSettings.PngImageList.PngImages.Items[Ord(iEraser)].PngImage;
  sbClearAdd.PngImage := AppSettings.PngImageList.PngImages.Items[Ord(iEraser)].PngImage;
  sbClearSalesRep.PngImage := AppSettings.PngImageList.PngImages.Items[Ord(iEraser)].PngImage;
  sbApply.PngImage := AppSettings.PngImageList.PngImages.Items[Ord(iCheckGreen)].PngImage;
  sbReset.PngImage := AppSettings.PngImageList.PngImages.Items[15].PngImage;

  TdmCustomer.OpenDM(self.Name,tdmiGeneric(dmCustomer));
  DataSource.DataSet := dmCustomer.cdsCust;

  NextDBGrid.DataAwareOptions := NextDBGrid.DataAwareOptions + [doBufferRecords];
  NextDBGrid.SaveForm := False;

  sqlWhereClauses := TSQLWhereBuilder.Create(Self);
  sqlWhereClauses.AddWhereClauseAnd('client_name','c.client_name containing ?',
    [RzEdit1,'text']);
  sqlWhereClauses.AddWhereClauseAnd('xxx','coalesce(c.street_address||'' '','''')||coalesce(c.address||'' '','''')||t.town_province containing ?',
    [RzEdit2,'text']);
  sqlWhereClauses.AddWhereClauseAnd('xxx','ag.client_name containing ?',
    [RzButtonEdit1,'text']);

  dmCustomer.OpenCustomer;
  inherited;
end;

procedure TlstCustomers.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    actFilter.Execute;
    key := #0;
  end
  else
    inherited;
end;

procedure TlstCustomers.RzSpinEdit1Change(Sender: TObject);
begin
  dmCustomer.ResultCountCust := RzSpinEdit1.IntValue;
  actFilter.Execute;
  NextDbGrid.LoadFromIniEx;
end;

procedure TlstCustomers.sbApplyClick(Sender: TObject);
begin
  actfilter.Execute;
end;

procedure TlstCustomers.sbClearNameClick(Sender: TObject);
begin
  if Sender = sbClearName then RzEdit1.Clear
  else if sender = sbClearAdd then RzEdit2.Clear
  else if Sender = sbClearSalesRep then RzButtonEdit1.Clear;
end;

procedure TlstCustomers.sbResetClick(Sender: TObject);
begin
  RzEdit1.Clear;
  RzEdit2.Clear;
  RzButtonEdit1.Clear;
end;

end.
