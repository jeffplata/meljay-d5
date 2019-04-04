unit TownEditU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, StdCtrls, Mask, DBCtrls, DB, ComCtrls;

type
  TfmTownEdit = class(TvfiSimpleEditCDS)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTownEdit: TfmTownEdit;

implementation

uses
  CustomerDM, uAppSettings;

{$R *.dfm}

procedure TfmTownEdit.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmCustomer.cdsTownLkup;
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
end;

end.
