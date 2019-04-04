unit SalesCreditSelectItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB;

type
  TfmSalesCreditSelectItems = class(TForm)
    DBGrid1: TDBGrid;
    btnSelect: TButton;
    btnCancel: TButton;
    DataSource1: TDataSource;
    btnRefresh: TButton;
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function ShowForm: Integer;
  end;

var
  fmSalesCreditSelectItems: TfmSalesCreditSelectItems;

implementation

//uses
//  SalesCreditDM;

{$R *.dfm}

{ TfmSalesCreditSelectItems }

class function TfmSalesCreditSelectItems.ShowForm: Integer;
begin
  if not Assigned(fmSalesCreditSelectItems) then
    fmSalesCreditSelectItems := TfmSalesCreditSelectItems.Create(nil);
  Result := fmSalesCreditSelectItems.ShowModal;
end;

procedure TfmSalesCreditSelectItems.btnRefreshClick(Sender: TObject);
begin
  DataSource1.DataSet.Refresh;
end;

end.
