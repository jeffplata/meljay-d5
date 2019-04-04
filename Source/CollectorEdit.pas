unit CollectorEdit;

interface

uses
  Windows, Variants, Classes, Controls, Forms,
  vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, DBCtrls, RzEdit,
  RzDBEdit, RzDBBnEd, Mask;

type
  TfmCollectorEdit = class(TvfiSimpleEditCDS)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RzDBButtonEdit1: TRzDBButtonEdit;
    DBMemo1: TDBMemo;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzDBButtonEdit1ButtonClick(Sender: TObject);
    procedure RzDBButtonEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzDBButtonEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    procedure SelectTown( keybuffer: string );
  public
    { Public declarations }
  end;

var
  fmCollectorEdit: TfmCollectorEdit;

implementation

uses
  CustomerDM, uAppSettings, MainDM;

{$R *.dfm}

procedure TfmCollectorEdit.FormCreate(Sender: TObject);
begin
  inherited;
  DBEdit1.ReadOnly := True;
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
  DataSource1.DataSet := dmCustomer.cdsCollectorLkup;
  DataSource1.DataSet.FieldByName('CLIENT_ID').OnGetText := dmMain.IDGetText;
  with DataSource1.DataSet do
    if State = dsInsert then
    begin
      FieldByName('CLIENT_ID').AsInteger := AppSettings.GlobalTempPKID;
      FieldByName('CLIENT_TYPE').AsString := 'CO';
    end;
end;

procedure TfmCollectorEdit.FormShow(Sender: TObject);
begin
  DBEdit2.SetFocus;
end;

procedure TfmCollectorEdit.RzDBButtonEdit1ButtonClick(Sender: TObject);
begin
  SelectTown('');
end;

procedure TfmCollectorEdit.SelectTown( keybuffer: string );
var
  town: Variant;
begin
  town := dmCustomer.SelectTown();
  if not VarIsEmpty(town) then begin
    //RzDBButtonEdit1.Text := town[1];
    DataSource1.DataSet.Edit;
    DataSource1.DataSet.FieldByName('TOWN_ID').AsInteger := town[0];
    DataSource1.DataSet.FieldByName('TOWNPROVINCE').AsString := town[1];
  end;
end;

procedure TfmCollectorEdit.RzDBButtonEdit1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F2 then SelectTown('');
end;

procedure TfmCollectorEdit.RzDBButtonEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key > #32) and (Key < #127) then begin
    SelectTown(Key);
    Key := #0;
  end;
end;

end.
