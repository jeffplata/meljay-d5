unit ProductMgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_itemmanagerCDS, DB, ImgList, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar;

type
  TfmProductMgr = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProductMgr: TfmProductMgr;

implementation

uses
  Misc, ProductsDM;

{$R *.dfm}

procedure TfmProductMgr.FormCreate(Sender: TObject);
begin
  inherited;
//  DataSource1.DataSet := dmInvoice.cdsProd_Lkup;
  DataSource1.DataSet := dmProducts.cdsProduct_Lkup;
  AutoStretchDBGridColumns(DBGrid1,[0,1],[40,40]);
end;

end.
