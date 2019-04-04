program MelJay;

{%ToDo 'MelJay.todo'}

uses
  Forms,
  MainFormU in 'MainFormU.pas' {fmMain},
  MainDM in 'MainDM.pas' {dmMain: TDataModule},
  uAppSettings in 'uAppSettings.pas',
  Misc in '..\..\source-common\Misc.pas',
  CustomerDM in 'CustomerDM.pas' {dmCustomer: TDataModule},
  TB2Merge in '..\Misc\TB2Merge.pas',
  InvoicesU in 'InvoicesU.pas' {fmInvoices},
  InvoiceDM in 'InvoiceDM.pas' {dmInvoice: TDataModule},
  vfi_SimpleEdit_CDS in 'vfi_SimpleEdit_CDS.pas' {vfiSimpleEditCDS},
  InvoiceEditCdsU in 'InvoiceEditCdsU.pas' {fmInvoiceEditCDS},
  ThemedDBGrid in 'ThemedDBGrid.pas',
  ProductsDM in 'ProductsDM.pas' {dmProducts: TDataModule},
  ProductEditCdsU in 'ProductEditCdsU.pas' {fmProductEditCDS},
  vfi_itemmanagerCDS in 'vfi_itemmanagerCDS.pas' {vfiItemManagerCDS},
  ProductTypesMgrU in 'ProductTypesMgrU.pas' {fmProductTypeMgr},
  ReconcileStandardDialog in 'ReconcileStandardDialog.pas' {ReconcileErrorForm},
  vfi_ObjectListCDS in 'vfi_ObjectListCDS.pas' {vfiObjectListCDS},
  CustomersCdsU in 'CustomersCdsU.pas' {fmCustomersCDS},
  DBGridSortU in 'DBGridSortU.pas',
  CustomerMgrCdsU in 'CustomerMgrCdsU.pas' {fmCustomerMgrCds},
  ProductMgr in 'ProductMgr.pas' {fmProductMgr},
  DSFilterU in 'DSFilterU.pas',
  CollectionsU in 'CollectionsU.pas' {fmCollections},
  CollectionEditU in 'CollectionEditU.pas' {fmCollectionsEdit},
  SearchEditU in 'SearchEditU.pas',
  UnpaidInvSelectionU in 'UnpaidInvSelectionU.pas' {fmUnpaidInvSelection},
  ReportsU in 'ReportsU.pas' {fmReports},
  ProductsCdsU in 'ProductsCdsU.pas' {fmProductsCds},
  ReportVariablesU in 'ReportVariablesU.pas',
  QueryConditionU in 'QueryConditionU.pas',
  ReportsDM in 'ReportsDM.pas' {dmReports: TDataModule},
  PurchasesU in 'PurchasesU.pas' {fmPurchases},
  PurchasesDM in 'PurchasesDM.pas' {dmPurchases: TDataModule},
  ManageCustBalancesU in 'ManageCustBalancesU.pas' {fmManageCustBalances},
  TownMgrU in 'TownMgrU.pas' {fmTownMgr},
  TownEditU in 'TownEditU.pas' {fmTownEdit},
  SalesRepMgr in 'SalesRepMgr.pas' {fmSalesRepMgr},
  CustomerEditCdsU in 'CustomerEditCdsU.pas' {fmCustomerEditCDS},
  SalesRepEdit in 'SalesRepEdit.pas' {fmSalesRepEdit},
  ChangeDBU in 'ChangeDBU.pas' {fmChangeDB},
  SalesCreditU in 'SalesCreditU.pas' {fmSalesCredit},
  SalesCreditDM in 'SalesCreditDM.pas' {dmSalesCredit: TDataModule},
  SalesCreditEdit in 'SalesCreditEdit.pas' {fmSalesCreditEdit},
  SalesCreditSelectItems in 'SalesCreditSelectItems.pas' {fmSalesCreditSelectItems},
  FilterItems in 'FilterItems.pas',
  TreeViewMenuU in '..\..\source-common\TreeViewMenuU.pas',
  AboutBox in 'AboutBox.pas' {fmAboutBox},
  CollectorMgr in 'CollectorMgr.pas' {fmCollectorMgr},
  CollectorEdit in 'CollectorEdit.pas' {fmCollectorEdit},
  vfi_TableViewer in '..\..\source-common\DianaSet\vfi_TableViewer.pas' {vfiTableViewer},
  Customers in 'Customers.pas' {lstCustomers},
  dmi_Generic in '..\..\source-common\dmi_Generic.pas' {dmiGeneric: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  //Application.Title := 'MelJay';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
