unit PurchasesU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_ObjectListCDS, DB, ImgList, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid, ExtCtrls,
  StdCtrls, TB2Item, TB2Dock, TB2Toolbar;

type
  TfmPurchases = class(TvfiObjectListCDS)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure Display;
  end;

var
  fmPurchases: TfmPurchases;

implementation

uses
  Misc, MainDM, PurchasesDM;

{$R *.dfm}

{ TfmPurchases }

class procedure TfmPurchases.Display;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmPurchases) then
    begin
      TdmPurchases.Open(dmuPurchases);
      fmPurchases := TfmPurchases.Create(nil);
    end;
    fmPurchases.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmPurchases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmPurchases := nil;
  inherited;
end;

procedure TfmPurchases.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmPurchases.cdsPurchases;
  dmPurchases.OpenPurchases;
end;

end.
