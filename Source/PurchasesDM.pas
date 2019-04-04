unit PurchasesDM;

interface

uses
  SysUtils, Classes, MainDM, Forms, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmPurchases = class(TDataModule)
    SQLDataSet1: TSQLDataSet;
    dspPurchases: TDataSetProvider;
    cdsPurchases: TClientDataSet;
    cdsPurchases_Edit: TClientDataSet;
  private
    ActiveUsers : TDMUsers;
  public
    class procedure Open( DMUser: TDMUser );
    class procedure Close( DMUser: TDMUser );
    procedure OpenPurchases;
  end;

var
  dmPurchases: TdmPurchases;

implementation

uses
  Misc;



{$R *.dfm}

{ TdmPurchases }

class procedure TdmPurchases.Close(DMUser: TDMUser);
begin
  if Assigned(dmPurchases) then
  with dmPurchases do
  begin
    if DMUser in ActiveUsers then
      ActiveUsers := ActiveUsers - [DMUser];
    if ActiveUsers = [] then
    begin
      FreeAndNil(dmPurchases);
    end;
  end;
end;

class procedure TdmPurchases.Open(DMUser: TDMUser);
begin
  if not Assigned(dmPurchases) then
    dmPurchases := TdmPurchases.Create(Application);
  with dmPurchases do
    if not (DMUser in ActiveUsers) then
      ActiveUsers := ActiveUsers + [DMUser];
end;

procedure TdmPurchases.OpenPurchases;
var
  oldIndexName: string;
begin
  with cdsPurchases do begin
    oldIndexName := IndexName;
    IndexName := '';
    Close;
    Open;
  end;

  if oldIndexName <> '' then
  begin
    SortCDS( cdsPurchases,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;


  cdsPurchases_Edit.Close;
  cdsPurchases_Edit.CloneCursor(cdsPurchases, False, True);

  cdsPurchases_Edit.FieldByName('TXN_ID').OnGetText := dmMain.IDGetText;
end;

end.
