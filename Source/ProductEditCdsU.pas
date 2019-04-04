unit ProductEditCdsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, Mask, DBCtrls,
  Buttons;

type
  TfmProductEditCDS = class(TvfiSimpleEditCDS)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource2: TDataSource;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProductEditCDS: TfmProductEditCDS;

implementation

uses ProductsDM, uAppSettings;

{$R *.dfm}

procedure TfmProductEditCDS.FormCreate(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
  DataSource1.DataSet := dmProducts.cdsProduct_Edit;
  DataSource2.DataSet := dmProducts.CDSLkProdType;
  if not dmProducts.CDSLkProdType.Active then
    dmProducts.CDSLkProdType.Open;
end;

procedure TfmProductEditCDS.FormShow(Sender: TObject);
begin
  inherited;
  DBEdit2.SetFocus;
end;

procedure TfmProductEditCDS.SpeedButton1Click(Sender: TObject);
begin
  dmProducts.actShowProductTypeMgr.Execute;
  if not VarIsEmpty(dmProducts.SelectedProductType) then
    with dmProducts do begin
      //we can also assign each variantarray value to a variant  
      //value := dmProducts.SelectedProductType[1];   //value is type variant
      cdsProduct_Edit.Edit;
      cdsProduct_Edit['PRODUCT_TYPE_ID;ProductType'] := dmProducts.SelectedProductType;
      //cdsProduct_Edit.Post;
    end;
end;

end.
