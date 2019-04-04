unit SalesCreditEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, Grids, DBGrids,
  Mask, DBCtrls, Buttons, RzEdit, RzDBEdit, RzDBBnEd;

type
  TfmSalesCreditEdit = class(TvfiSimpleEditCDS)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DataSource2: TDataSource;
    RzDBButtonEdit1: TRzDBButtonEdit;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    btnSelect: TButton;
    btnRemove: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzDBButtonEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzDBButtonEdit1ButtonClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    procedure SelectCustomer(const keybuffer: string = '');
  public
    { Public declarations }
  end;

var
  fmSalesCreditEdit: TfmSalesCreditEdit;

implementation

uses
  uAppSettings, SalesCreditDM, CustomerDM, SalesCreditSelectItems, ProductsDM;

{$R *.dfm}

procedure TfmSalesCreditEdit.FormCreate(Sender: TObject);
begin
  DataSource1.DataSet := dmSalesCredit.cdsSalesCr;
  DataSource2.DataSet := dmSalesCredit.cdsSalesCrLines;
  DBEdit4.Color := AppSettings.ReadOnlyFieldColor;
  //LoadDBGridColumns(DBGrid1);
end;

procedure TfmSalesCreditEdit.FormShow(Sender: TObject);
var
  aid: Variant;
begin
  inherited;
  Caption := 'Edit Stock Withdrawal ';
  aid := dmSalesCredit.cdsSalesCr['SALES_CR_ID'];
  if aid < 0 then
    Caption := Caption + '[New]' else
    Caption := Caption + format('[%s]',[aid]);
  RzDBButtonEdit1.SetFocus;
end;

procedure TfmSalesCreditEdit.SelectCustomer(const keybuffer: string = '');
begin
  dmCustomer.SelectCustomer(keybuffer);
  if not VarIsEmpty(dmCustomer.SelectedCustomer) then
    with dmSalesCredit do
    begin
      cdsSalesCr.Edit;
      cdsSalesCr['CLIENT_ID'] := dmCustomer.SelectedCustomer[0];
      cdsSalesCr['ClientName'] := dmCustomer.SelectedCustomer[1];
    end;
end;

procedure TfmSalesCreditEdit.RzDBButtonEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in [#32..#127] then begin
    SelectCustomer(Key);
    key := #0;
  end;
end;

procedure TfmSalesCreditEdit.RzDBButtonEdit1ButtonClick(Sender: TObject);
begin
  SelectCustomer;
end;

procedure TfmSalesCreditEdit.btnSelectClick(Sender: TObject);
var
  sClientID: string;
begin
  sClientID := dmSalesCredit.cdsSalesCr.fieldbyname('CLIENT_ID').AsString;

  with dmSalesCredit.cdsCollectibles do
  begin
    Filter := 'CLIENT_ID = '+QuotedStr(sClientID);
    Filtered := True;
  end;

  if TfmSalesCreditSelectItems.ShowForm = mrOk then
  begin
    with dmSalesCredit, dmSalesCredit.cdsSalesCrLines do
    begin
      Append;
      FieldByName('SALES_DOC_NO').AsString := cdsCollectibles.fieldbyname('TXN_NUMBER').AsString;
      FieldByName('PRODUCT_ID').AsInteger :=  cdsCollectibles.fieldbyname('PRODUCT_ID').AsInteger;
      FieldByName('QTY').AsInteger :=         cdsCollectibles.fieldbyname('QTYOUT').AsInteger;
      FieldByName('PRICE_UNIT').AsCurrency := cdsCollectibles.fieldbyname('PRICE_UNIT').AsCurrency;
      FieldByName('PRODUCTNAME').AsString  := dmProducts.cdsProduct_Lkup.Lookup('PRODUCT_ID',FieldByName('PRODUCT_ID').AsInteger,'PRODUCT_NAME');
      try
        Post;
      except
        Cancel;
      end;  
    end;
  end;
end;

procedure TfmSalesCreditEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fmSalesCreditSelectItems);
  fmSalesCreditEdit := nil;
end;

procedure TfmSalesCreditEdit.btnRemoveClick(Sender: TObject);
begin
  if not DataSource2.DataSet.Eof then
    DataSource2.DataSet.Delete;
end;

end.
