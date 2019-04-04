unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Item, SpTBXItem, TB2Dock, TB2Toolbar, ActnList, SpTBXDkPanels,
  ComCtrls, ImgList, PngImageList, TB2ExtItems, XPMan, ExtCtrls, Menus,
  frxDesgn, frxClass, DB, TreeViewMenuU, adpInstanceControl;

type


  TfmMain = class(TForm)
    SpTBXDock1: TSpTBXDock;
    tbMainMenu: TSpTBXToolbar;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXItem1: TSpTBXItem;
    SpTBXToolbar2: TSpTBXToolbar;
    SpTBXItem2: TSpTBXItem;
    ActionList1: TActionList;
    actAbout: TAction;
    PngImageList1: TPngImageList;
    TBVisibilityToggleItem1: TTBVisibilityToggleItem;
    actInvoices: TAction;
    actCollections: TAction;
    actPayments: TAction;
    actProducts: TAction;
    XPManifest1: TXPManifest;
    SpTBXStatusBar1: TSpTBXStatusBar;
    Splitter1: TSplitter;
    actCustomersCds: TAction;
    SpTBXPopupMenu1: TSpTBXPopupMenu;
    SpTBXItem4: TSpTBXItem;
    actShowTableConfig: TAction;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    actReports: TAction;
    frxDesigner1: TfrxDesigner;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXItem3: TSpTBXItem;
    actReportDesigner: TAction;
    frxReport1: TfrxReport;
    actPurchases: TAction;
    SpTBXSubmenuItem3: TSpTBXSubmenuItem;
    SpTBXItem6: TSpTBXItem;
    actManageCustBalances: TAction;
    SpTBXItem7: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    actChangeDatabase: TAction;
    actShowTowns: TAction;
    actShowSalesCredits: TAction;
    StatusBarDBName: TSpTBXLabelItem;
    ObjectViewerPanel: TSpTBXDockablePanel;
    SpTBXItem8: TSpTBXItem;
    adpInstanceControl1: TadpInstanceControl;
    actShowCollectors: TAction;
    SpTBXSubmenuItem4: TSpTBXSubmenuItem;
    actListCustomer: TAction;
    procedure SpTBXItem1Click(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actInvoicesExecute(Sender: TObject);
    procedure actCollectionsExecute(Sender: TObject);
    procedure actPaymentsExecute(Sender: TObject);
    procedure actProductsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actCustomersCdsExecute(Sender: TObject);
    procedure actReportsExecute(Sender: TObject);
    procedure actReportDesignerExecute(Sender: TObject);
    procedure actPurchasesExecute(Sender: TObject);
    procedure actManageCustBalancesExecute(Sender: TObject);
    procedure actChangeDatabaseExecute(Sender: TObject);
    procedure actListCustomerExecute(Sender: TObject);
    procedure actShowTownsExecute(Sender: TObject);
    procedure actShowSalesCreditsExecute(Sender: TObject);
    procedure SpTBXItem8Click(Sender: TObject);
    procedure actShowCollectorsExecute(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  oldCurrencyString: string;
  objectViewerMenu: TTreeViewMenu;

implementation

uses uAppSettings, InvoicesU, MainDM, CustomersCdsU,
  ReportsU, ProductsCdsU, PurchasesU,
  ManageCustBalancesU, ChangeDBU, TownMgrU, SalesCreditU, 
  CollectionsU, AboutBox, CollectorMgr, Customers, vfi_TableViewer;

{$R *.dfm}

procedure TfmMain.SpTBXItem1Click(Sender: TObject);
begin
  close; 
end;

procedure TfmMain.actAboutExecute(Sender: TObject);
begin
  //ShowMessage('Invoice Management System'#13#10'@Jeff Plata (jeffplata@yahoo.com)');
  TfmAboutBox.ShowForm;
end;

procedure TfmMain.actInvoicesExecute(Sender: TObject);
begin
  //invoices
  if dmMain.GoodConnection then
    TfmInvoices.ShowForm;
end;

procedure TfmMain.actCollectionsExecute(Sender: TObject);
begin
  //collections
  if dmMain.GoodConnection then
    TfmCollections.ShowForm;
    
end;

procedure TfmMain.actPaymentsExecute(Sender: TObject);
begin
  //payments
  
end;

procedure TfmMain.actProductsExecute(Sender: TObject);
begin
  //products
  if dmMain.GoodConnection then
    TfmProductsCds.ShowForm;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for i := screen.FormCount-1 downto 0 do
  begin
    if screen.forms[i]<>application.MainForm then
      screen.forms[i].close;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  ANode: TTreeNode;
begin
  Self.Caption := AppSettings.ApplicationName;
  Application.OnException := dmMain.DBErrorHandler;
  frxReport1.EngineOptions.UseGlobalDataSetList := False;
  StatusBarDBName.Caption := AppSettings.Database;

  CurrencyString := '';

  //----  
  objectViewerMenu := TTreeViewMenu.Create(Self);
  objectViewerMenu.Parent := ObjectViewerPanel;
  objectViewerMenu.Images := PngImageList1;

  with objectViewerMenu do begin
    ANode := AddMenuitem(nil, 'Invoices',         0, actInvoices);
    AddMenuitem(ANode,        'Collections',      1, actCollections);
    AddMenuitem(ANode,        'Stock Withdrawal', 3, actShowSalesCredits);
    Anode := AddMenuitem(nil, 'Customers',        2, actCustomersCds);
    AddMenuitem(Anode,        'Collectors',       2, actShowCollectors );
    AddMenuitem(Anode,        'Municipalities',   2, actShowTowns );
    ANode := AddMenuItem(nil, 'Customers',        2, actListCustomer);
    AddMenuitem(nil,          'Products',         3, actProducts);
    AddMenuitem(nil,          'Reports',          4, actReports);
    Display;
  end;

end;

procedure TfmMain.actCustomersCdsExecute(Sender: TObject);
begin
  //customers, using CDS
  if dmMain.GoodConnection then
    TfmCustomersCDS.ShowForm;
end;


procedure TfmMain.actReportsExecute(Sender: TObject);
begin
  //reports
  if dmMain.GoodConnection then
    TfmReports.ShowForm;
end;

procedure TfmMain.actReportDesignerExecute(Sender: TObject);
begin
  if dmMain.LastReportName <> '' then
    frxReport1.LoadFromFile(dmMain.LastReportName);
  frxReport1.DesignReport;
end;




procedure TfmMain.actPurchasesExecute(Sender: TObject);
begin
  if dmMain.GoodConnection then
    TfmPurchases.Display;
end;

procedure TfmMain.actManageCustBalancesExecute(Sender: TObject);
begin
  if dmMain.GoodConnection then
    TfmManageCustBalances.ShowForm;
end;

procedure TfmMain.actChangeDatabaseExecute(Sender: TObject);
var
  i: Integer;
begin
  with TfmChangeDB.Create(nil) do
  try
    if ShowModal = mrOk then begin
      StatusBarDBName.Caption := AppSettings.Database;
      for i := screen.FormCount-1 downto 0 do
        if screen.forms[i]<>application.MainForm then
          screen.forms[i].close;
    end;
  finally
    Free;
  end;
end;

procedure TfmMain.actListCustomerExecute(Sender: TObject);
begin
  TlstCustomers.Open(tvfiTableViewer(lstCustomers));
end;

procedure TfmMain.actShowTownsExecute(Sender: TObject);
begin
  if dmMain.GoodConnection then
    TfmTownMgr.OpenAsEditor;
end;

procedure TfmMain.actShowSalesCreditsExecute(Sender: TObject);
begin
  if dmMain.GoodConnection then
    TfmSalesCredit.ShowForm;
end;

procedure TfmMain.SpTBXItem8Click(Sender: TObject);
begin
  dmMain.SQLMonitor1.Active := SpTBXItem8.Checked;
end;

procedure TfmMain.actShowCollectorsExecute(Sender: TObject);
begin
  if dmMain.GoodConnection then
    TfmCollectorMgr.OpenAsEditor;
end;

end.
