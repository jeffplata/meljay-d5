unit ReportsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Misc, ExtCtrls, StdCtrls, TB2Item, TB2Dock, TB2Toolbar, ComCtrls,
  frxClass, FMTBcd, DB, BigIni, Contnrs,
  ImgList, PngImageList, ReportVariablesU, uAppSettings, Buttons,
  PngSpeedButton, DBCtrls, RzCommon, Mask, RzEdit,
  RzBtnEdt, RzDBLook;

type

  TItemReport = class
  private
    FName : string;
    FSQL  : string;
  public
    property Name : String read FName write FName;
    property SQL  : String read FSQL write FSQL;
    constructor Create(const AName, ASQL: string );
  end;

  TItem = class
  private
    FShortName: string;
    FTabsheet: TTabSheet;
    FReportName: string;
    FReportSQL: string;
    FReports: TObjectList;
    FSelectedReportIndex: integer;
    function GetReports: TObjectList;
  public
    property ShortName: string read FShortName write FShortName;
    property Tabsheet: TTabSheet read FTabSheet write FTabsheet;
    property ReportName: string read FReportName;
    property ReportSQL: string read FReportSQL;
    property Reports: TObjectList read GetReports;
    property SelectedReportIndex : Integer read FSelectedReportIndex write FSelectedReportIndex;
    constructor Create( ATabSheet: TTabSheet );
    destructor Destroy; override;
  end;

  TReportSettings = class(TSaveComponent)
  private
    FProductionPeriod: string;
    FProductionProductID: integer;
    FProductionProductDesc: string;
    FProductionSRID: integer;
    FProductionSRName: string;
    FProductionTeamName: string;


    //FReportPeriod: string;
//    FProductID: Integer;
//    FProductDesc: string;
//    FProdSumPeriod: string;
//    FProdSumProdID: Integer;
//    FProdSumProdDesc: string;
//    FProdSumSRID: Integer;
//    FProdSumSRName: string;
  published
    property ProductionPeriod: string read FProductionPeriod write FProductionPeriod;
    property ProductionProductID: Integer read FProductionProductID write FProductionProductID;
    property ProductionProductDesc: string read FProductionProductDesc write FProductionProductDesc;
    property ProductionSRID: Integer read FProductionSRID write FProductionSRID;
    property ProductionSRName: string read FProductionSRName write FProductionSRName;
    property ProductionTeamName: string read FProductionTeamName write FProductionTeamName;


    //property ReportPeriod: string read FReportPeriod write FReportPeriod;
//    property ProductID: Integer read FProductID write FProductID;
//    property ProductDesc: string read FProductDesc write FProductDesc;
//    property ProdSumPeriod: string read FProdSumPeriod write FProdSumPeriod;
//    property ProdSumProdID: Integer read FProdSumProdID write FProdSumProdID;
//    property ProdSumProdDesc: string read FProdSumProdDesc write FProdSumProdDesc;
//    property ProdSumSRID: integer read FProdSumSRID write FProdSumSRID;
//    property ProdSumSRName: string read FProdSumSRName write FProdSumSRName;
  end;

  TfmReports = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tabOutstandingInv: TTabSheet;
    tabInvSummary: TTabSheet;
    Label1: TLabel;
    dtpInvbal: TDateTimePicker;
    rbbydaysoverdue: TRadioButton;
    rbbycustomer: TRadioButton;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    tbiShowReport: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    tbiClose: TTBItem;
    ListView1: TListView;
    Label2: TLabel;
    dtpInvSumm1: TDateTimePicker;
    dtpInvSumm2: TDateTimePicker;
    TBToolbar2: TTBToolbar;
    TBSubmenuItem1: TTBSubmenuItem;
    PngImageList1: TPngImageList;
    tabCustBalances: TTabSheet;
    dtpCustBalances: TDateTimePicker;
    Label3: TLabel;
    DataSource1: TDataSource;
    tabProdSum: TTabSheet;
    Label6: TLabel;
    edtProductionPeriod: TEdit;
    Label7: TLabel;
    edtProductionProduct: TEdit;
    sbtProductionProduct: TPngSpeedButton;
    pnlTabProdSummSR: TPanel;
    Label8: TLabel;
    edtProductionSR: TEdit;
    sbtProductionSR: TPngSpeedButton;
    Label9: TLabel;
    pnlTabProdSummGroup: TPanel;
    Label4: TLabel;
    edtProductionTeamName: TEdit;
    tabColl: TTabSheet;
    Label5: TLabel;
    Label10: TLabel;
    edtCollPeriod: TEdit;
    dtpCollFrom: TRzDateTimeEdit;
    dtpCollTo: TRzDateTimeEdit;
    RzPropertyStore1: TRzPropertyStore;
    RzRegIniFile1: TRzRegIniFile;
    pnlTabProdSummProvince: TPanel;
    Label11: TLabel;
    RzDBLookupDialog1: TRzDBLookupDialog;
    RzButtonEdit1: TRzButtonEdit;
    procedure tbiCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbiShowReportClick(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure rbbydaysoverdueClick(Sender: TObject);
    procedure rbbycustomerClick(Sender: TObject);
    procedure tbiTodayClick( Sender: TObject );
    procedure edtProductionSRKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtProductionProductKeyPress(Sender: TObject; var Key: Char);
    procedure edtProductionProductKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbtProductionProductClick(Sender: TObject);
    procedure RzButtonEdit1ButtonClick(Sender: TObject);
  private
    FCurrentReportName: string;
    FCurrentReportSQL : string;
    FCompanyName: string;
    FBigIni: TBiggerIniFile;
    FReportVariables: TReportVariables;
    FReportSettings: TReportSettings;
    RzPropertyStore: TRzPropertyStore;
    RzRegIniFile: TRzRegIniFile;
    procedure FillReportList;
    procedure SelectProduct( const keybuffer: string = '' );
    procedure SelectSalesRep( const keybuffer: string = '' );
    procedure ShowReport;
    procedure SetComponentProp;
    procedure LoadSaveComponentProp(flag: Integer);
  public
    savethisproperty: string;
    class procedure ShowForm;
  end;

var
  fmReports: TfmReports;

implementation

uses MainDM, Clipper, ReportsDM, ProductsDM, CustomerDM, Clipbrd;

{$R *.dfm}

{ TfmReports }

class procedure TfmReports.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmReports) then
    begin
      TdmReports.Open(dmuReports);
      fmReports := TfmReports.Create(nil);
    end;
    fmReports.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmReports.tbiCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfmReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if edtProductionPeriod.Text <> '' then
    FReportSettings.ProductionPeriod := edtProductionPeriod.Text;
  FReportSettings.ProductionProductDesc := edtProductionProduct.Text;
  FReportSettings.ProductionSRName := edtProductionSR.Text;
  FReportSettings.ProductionTeamName := edtProductionTeamName.Text;

  TdmReports.Close(dmuReports);
  TdmProducts.Close(dmuReports);
//  TdmCustomer.Close(dmuReports);

  //RzPropertyStore1.Save;
  LoadSaveComponentProp(0);
  action := caFree;
end;

procedure TfmReports.FormDestroy(Sender: TObject);
begin
  FReportSettings.Destroy;
  FReportVariables.Free;
  fmReports := nil;
end;

procedure TfmReports.FormCreate(Sender: TObject);
var
  i: integer;
begin
  ListView1.Columns[0].Width := ListView1.Width -4;

  for i := 0 to PageControl1.PageCount - 1 do
    PageControl1.Pages[i].TabVisible := False;

  pnlTabProdSummSR.BevelOuter := bvNone;
  pnlTabProdSummGroup.BevelOuter := bvNone;
  pnlTabProdSummProvince.BevelOuter := bvNone;

  //TdmCustomer.Open(dmuReports);
//  TdmProducts.Open(dmuReports);
  FReportSettings := TReportSettings.Create(ExtractFilePath(ParamStr(0)) + 'report.cfg');
  FReportSettings.Name := 'FReportSettings';

  edtProductionPeriod.Text      := FReportSettings.ProductionPeriod;
  edtProductionProduct.Text     := FReportSettings.ProductionProductDesc;
  edtProductionSR.Text          := FReportSettings.ProductionSRName;
  edtProductionTeamName.Text    := FReportSettings.ProductionTeamName;

  dtpInvbal.Date := Date;
  dtpInvSumm1.Date := Date;
  dtpInvSumm2.Date := Date;
  dtpCustBalances.Date := Date;

  FCompanyName := AppSettings.CompanyName;

  FReportVariables := TReportVariables.Create(Self);

  FillReportList;

  //RzPropertyStore1.Load;
  LoadSaveComponentProp(1);
end;

procedure TfmReports.tbiShowReportClick(Sender: TObject);
begin
  ShowReport;
end;

procedure TfmReports.FillReportList;
var
  item: TItem;

  function AddItem(const Caption: string; AItem: TItem): TItem;
  var
    li : TListItem;
  begin
    li := ListView1.Items.Add;
    li.Caption := Caption;
    li.Data := AItem;
    Result := AItem;
  end;
begin
  //todo: transfer report data into db; shortname, reportname, sql; should eliminate recompile if updating reports
  ListView1.Clear;
  AddItem('Customer Reports',nil);
  item := AddItem('     1) Outstanding Invoices',TItem.Create(tabOutstandingInv));
  item.Reports.Add(TItemReport.Create('cus_OutstandingInvoices_byDaysOverdue',
                                      'cus_OutstandingInvoices_byDaysOverdue'));
  item.Reports.Add(TItemReport.Create('cus_OutstandingInvoices_byCustomer',
                                      'cus_OutstandingInvoices_byCustomer'));
  item := AddItem('     2) Invoice Summary',TItem.Create(tabInvSummary));
  item.Reports.Add(TItemReport.Create('cus_InvoiceSummary', 'cus_InvoiceSummary'));
  item := AddItem('     3) Customer Balances',TItem.Create(tabCustBalances));
  item.Reports.Add(TItemReport.Create('cus_Balances', 'cus_Balances'));

  AddItem('Production Reports',nil);
  item := AddItem('     4) Daily Production',TItem.Create(tabProdSum));
  item.Reports.Add(TItemReport.Create('prod_Daily', 'prod_Daily'));
  item := AddItem('     5) Production by Municipality',TItem.Create(tabProdSum));
  item.Reports.Add(TItemReport.Create('prod_Daily_ByTown', 'prod_Daily_ByTown'));
  item := AddItem('     6) Production Summary by Sales Rep',TItem.Create(tabProdSum));
  item.ShortName := 'PRODSUMM';
  item.Reports.Add(TItemReport.Create('prod_Summary', 'prod_Summary'));
  item := AddItem('     7) Production Summary by Team',TItem.Create(tabProdSum));
  item.ShortName := 'PRODSUMMGROUP';
  item.Reports.Add(TItemReport.Create('prod_Summary_byGroup', 'prod_Summary_byGroup'));

  AddItem('Updated Production Reports',nil);
  item := AddItem('     8) Production Summary by Municipality', TItem.Create(tabProdSum));
  item.ShortName := 'PRODSUMMTOWN';
  item.Reports.Add(TItemReport.Create('prod_Summary_Updated_byTown', 'prod_Summary_Updated_byTown'));
  item := AddItem('     9) Production Summary by Sales Rep', TItem.Create(tabProdSum));
  item.ShortName := 'PRODSUMMSR';
  item.Reports.Add(TItemReport.Create('prod_Summary_Updated_bySR', 'prod_Summary_Updated_bySR'));
  item := AddItem('    10) Collector''s Reference',TItem.Create(tabProdSum));
  item.ShortName := 'COLLECTORSREF';
  item.Reports.Add(TItemReport.Create('prod_Collectors_Reference', 'prod_Collectors_Reference'));
  item := AddItem('    11) Collector''s Reference by Sales Rep',TItem.Create(tabProdSum));
  item.Reports.Add(TItemReport.Create('prod_Collectors_Reference', 'prod_Collectors_Reference_bySR'));

  AddItem('Collection Reports',nil);
  item := AddItem('    13) Collection Detail by Sales Rep', TItem.Create(tabColl));
  item.Reports.Add(TItemReport.Create('col_Breakdown_bySR', 'col_Breakdown_bySR'));
  item := AddItem('    14) Collection Summary Report by Sales Rep', TItem.Create(tabColl));
  item.Reports.Add(TItemReport.Create('col_Summary_bySR', 'col_Summary_bySR'));
  item := AddItem('    15) Collection Summary Report by Municipality', TItem.Create(tabColl));
  item.Reports.Add(TItemReport.Create('col_Summary_byTown', 'col_Summary_byTown'));
  item := AddItem('    16) Collection Summary by Collector', TItem.Create(tabColl));
  item.Reports.Add(TItemReport.Create('col_Summary_byCollector', 'col_Summary_byCollector'));
  item := AddItem('    17) Collection Summary by Province', TItem.Create(tabColl));
  item.Reports.Add(TItemReport.Create('col_Summary_byProvince', 'col_Summary_byProvince'));

end;

procedure TfmReports.tbiTodayClick(Sender: TObject);

var
  d1, d2: TDateTimePicker;
begin
  d1 := dtpInvSumm1;
  d2 := dtpInvSumm2;
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

end;

procedure TfmReports.SelectProduct(const keybuffer: string);
begin
  if not Assigned(dmProducts) then TdmProducts.Open(dmuReports);
  dmProducts.SelectProduct(keybuffer);
  if not VarIsEmpty(dmProducts.SelectedProduct) then begin
    FReportSettings.ProductionProductID   := dmProducts.SelectedProduct[0];
    FReportSettings.ProductionProductDesc := dmProducts.SelectedProduct[1];
    edtProductionProduct.Text := FReportSettings.ProductionProductDesc;
  end;
end;

procedure TfmReports.SelectSalesRep(const keybuffer: string);
begin
 // if not Assigned(dmCustomer) then TdmCustomer.Open(dmuReports);
 TdmCustomer.OpenCustomers(dmuReports);
  dmCustomer.SelectSalesRep(keybuffer);
  if not VarIsEmpty(dmCustomer.SelectedSalesRep) then begin
    FReportSettings.ProductionSRID   := dmCustomer.SelectedSalesRep[0];
    FReportSettings.ProductionSRName := dmCustomer.SelectedSalesRep[1];
    edtProductionSR.Text := FReportSettings.ProductionSRName;
  end;
end;

procedure TfmReports.ShowReport;
var
  sl: TStringList;
  s: string;
  orderby: string;
  item: TItem;
  itemreport: TItemReport;
begin
  with ListView1 do
    if (ItemIndex = -1) or (Selected.Data = nil) then Exit;
  item := ListView1.Selected.Data;
  itemreport := TItemReport(item.reports[item.selectedreportindex]);
  FCurrentReportName := 'reports\'+itemreport.Name+'.fr3';
  FCurrentReportSQL  := itemreport.SQL;

  dmMain.LastReportName := FCurrentReportName;
  
  //todo: transfer 'meljay.sql' to reports, appsettings as reports.sql
  FBigIni := TBiggerIniFile.Create('reports\meljay.sql');
  try
    sl := TStringList.Create;
    try
      FBigIni.ReadSectionValues(FCurrentReportSQL,sl);
      s := sl.Text;
    finally
      sl.Free;
    end;
  finally
    FBigIni.Free;
  end;

  with FReportVariables do
  begin
    Variables['ASOFDATE_INVBAL'] := QuotedStr( DateToStr(dtpInvbal.Date) );
    Variables['FROMDATE'] := QuotedStr( DateToStr(dtpInvSumm1.Date) );
    Variables['TODATE']   := QuotedStr( DateToStr(dtpInvSumm2.Date) );
    Variables['ASOFDATE'] := QuotedStr( DateToStr(dtpCustBalances.Date) );
    Variables['PERIOD']   := edtProductionPeriod.Text;
    Variables['PRODUCTID']:= IntToStr(FReportSettings.ProductionProductID);
    Variables['PRODSUMPERIOD']     := edtProductionPeriod.Text;
    Variables['PRODSUMPRODUCTID']  := IntToStr(FReportSettings.ProductionProductID);
    Variables['PROVINCE'] := RzButtonEdit1.Text;
    if edtProductionSR.Text <> '' then
      Variables['PRODSUMSALESREPID'] := ' WHERE AGENT_ID = '+IntToStr(FReportSettings.ProductionSRID) else
      Variables['PRODSUMSALESREPID'] := '';
    if RzButtonEdit1.Text <> '' then
      Variables['PRODSUMMPROVINCE'] := ' WHERE PROVINCE = '+ QuotedStr(RzButtonEdit1.Text) else
      Variables['PRODSUMMPROVINCE'] := '';
    if PageControl1.ActivePage = tabColl then begin
      Variables['PERIOD']     := edtCollPeriod.Text;
      Variables['FROMDATE']   := DateToStr(dtpCollFrom.Date);
      Variables['TODATE']     := DateToStr(dtpCollTo.Date);
    end;
  end;

  with dmReports do
  begin
    SQLDataSet1.CommandText := FReportVariables.ExpandVariables(s);
//    ShowMessage(SQLDataSet1.CommandText);
    with frxReport1 do begin
      Report.LoadFromFile(FCurrentReportName);
      Script.Variables['COMPANY_NAME'] := FCompanyName;
      Script.Variables['ASOFDATE']     := dtpInvbal.Date;
      Script.Variables['GROUP']        := orderby;
      Script.Variables['FROMDATE']     := dtpInvSumm1.Date;
      Script.Variables['TODATE']       := dtpInvSumm2.Date;
      Script.Variables['TEAMNAME']     := edtProductionTeamName.Text;
      Script.Variables['PERIOD']       := edtProductionPeriod.Text;
      if PageControl1.ActivePage = tabColl then begin
        Script.Variables['PERIOD']     := edtCollPeriod.Text;
        Script.Variables['FROMDATE']   := dtpCollFrom.Text;
        Script.Variables['TODATE']     := dtpCollTo.Text;
      end;

      ShowReport(True);
    end;
  end;

end;

procedure TfmReports.SetComponentProp;
begin
  RzPropertyStore.Section := 'Reports';
  RzPropertyStore.AddProperty(edtCollPeriod, 'text');
  RzPropertyStore.AddProperty(dtpCollFrom, 'date');
  RzPropertyStore.AddProperty(dtpCollTo, 'date');
  RzPropertyStore.AddProperty(RzButtonEdit1, 'text');
end;

procedure TfmReports.LoadSaveComponentProp(flag: integer);
begin
  RzRegIniFile := TRzRegIniFile.Create(Self);
  RzPropertyStore := TRzPropertyStore.Create(Self);
  RzPropertyStore.RegIniFile := RzRegIniFile;
  SetComponentProp;
  try
    if flag = 0 then
      RzPropertyStore.Save else
      RzPropertyStore.Load;
  finally
    RzPropertyStore.Free;
    RzRegIniFile.Free;
  end;
end;

{ TItem }

constructor TItem.Create(ATabSheet: TTabSheet);
begin
  FTabsheet := ATabSheet;
  FShortName := '';
end;

procedure TfmReports.ListView1Click(Sender: TObject);
var
  item : TItem;
  itemreport: TItemReport;
begin
  if ListView1.Selected = nil then Exit;
  with ListView1 do
    item := TItem(Selected.Data);
  if item <> nil then begin
    itemreport := TItemReport(item.Reports[item.SelectedReportIndex]);
    PageControl1.ActivePage := item.Tabsheet;
    FCurrentReportName := itemreport.Name;
    FCurrentReportSQL := itemreport.SQL;
  end
  else begin
    PageControl1.ActivePage := nil;
    FCurrentReportName := '';
  end;

  if Assigned(item) then begin
    pnlTabProdSummSR.Visible := ( item.FShortName = 'PRODSUMM' ) or
                                ( item.FShortName = 'PRODSUMMSR' );
    pnlTabProdSummGroup.Visible := item.FShortName = 'PRODSUMMGROUP';
    pnlTabProdSummProvince.Visible := (item.ShortName = 'COLLECTORSREF')
                                   or (item.ShortName = 'PRODSUMMTOWN');
  end;

end;

destructor TItem.Destroy;
begin
  Reports.Free;
  inherited;
end;

function TItem.GetReports: TObjectList;
begin
  if FReports = nil then FReports := TObjectList.Create;
  result := FReports;
end;

{ TItemReport }

constructor TItemReport.Create(const AName, ASQL: string);
begin
  FName := AName;
  FSQL  := ASQL;
end;

procedure TfmReports.rbbydaysoverdueClick(Sender: TObject);
begin
  TItem(ListView1.Selected.Data).SelectedReportIndex := 0;
end;

procedure TfmReports.rbbycustomerClick(Sender: TObject);
begin
  TItem(ListView1.Selected.Data).SelectedReportIndex := 1;
end;

procedure TfmReports.edtProductionSRKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ///
  if Key = VK_BACK then begin
    key := 0;
    edtProductionSR.Text := '';
    FReportSettings.ProductionSRID := 0;
    FReportSettings.ProductionSRName := '';
  end else
  if key = VK_F2 then
    SelectSalesRep;
end;

procedure TfmReports.edtProductionProductKeyPress(Sender: TObject;
  var Key: Char);
begin
  ////
  if (Key >=#32) and (key <= #127) then begin
    if Sender = edtProductionProduct then SelectProduct(Key) else
    if Sender = edtProductionSR      then SelectSalesRep(Key);
  end;

end;

procedure TfmReports.edtProductionProductKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ///
  if key = VK_F2 then SelectProduct;
end;

procedure TfmReports.sbtProductionProductClick(Sender: TObject);
begin
  ///
  if Sender = sbtProductionProduct then SelectProduct else
  if Sender = sbtProductionSR      then SelectSalesRep;
end;

procedure TfmReports.RzButtonEdit1ButtonClick(Sender: TObject);
begin
  //TdmCustomer.Open(dmuReports);
  TdmCustomer.OpenTowns(dmuReports);
  RzDBLookupDialog1.Dataset := dmCustomer.cdsProvinces;
  //RzDBLookupDialog1.SearchString := RzButtonEdit1.Text;
  RzDBLookupDialog1.Execute;
end;

end.
