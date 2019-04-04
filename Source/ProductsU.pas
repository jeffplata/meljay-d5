unit ProductsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_ObjectList, ImgList, PngImageList, IB_ActionUpdate,
  ActnList, IB_Components, ExtCtrls, Grids, IB_Grid, StdCtrls, TB2Item,
  TB2Dock, TB2Toolbar;

type
  TfmProducts = class(TvfiObjectList)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IB_ActionAppend1Execute(Sender: TObject);
    procedure IB_ActionEdit1Execute(Sender: TObject);
  private
    procedure ShowEditForm;
  public
    class procedure ShowForm;
  end;

var
  fmProducts: TfmProducts;

implementation

uses ProductsDM, Misc, ProductEditCdsU;

{$R *.dfm}

{ TfmProducts }

class procedure TfmProducts.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmProducts) then
    begin
      TdmProducts.Open;
      fmProducts := TfmProducts.Create(nil);
    end;
    fmProducts.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmProducts.FormCreate(Sender: TObject);
begin
  inherited;
  IB_DataSource1.Dataset := dmProducts.ibqrProducts;
  dmProducts.ibqrProducts.Open;
end;

procedure TfmProducts.FormDestroy(Sender: TObject);
begin
  inherited; 
  FreeAndNil(fmProductEditCDS);
  fmProducts := nil;
  TdmProducts.Close;
end;

procedure TfmProducts.ShowEditForm;
begin
  if not Assigned(fmProductEditCDS) then
    fmProductEditCDS := TfmProductEditCDS.Create(Self);
  fmProductEditCDS.ShowModal;
end;

procedure TfmProducts.IB_ActionAppend1Execute(Sender: TObject);
begin
  dmProducts.OpenCDS(1);
  ShowEditForm;
end;

procedure TfmProducts.IB_ActionEdit1Execute(Sender: TObject);
begin
  dmProducts.OpenCDS(2);
  ShowEditForm;
end;

end.
