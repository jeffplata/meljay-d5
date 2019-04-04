unit SalesRepEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, DBCtrls, Mask,
  Buttons;

type
  TfmSalesRepEdit = class(TvfiSimpleEditCDS)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label7: TLabel;
    DBMemo2: TDBMemo;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    sbtTown: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtTownClick(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure ShowTownMgr(keybuffer: string);
  public
    { Public declarations }
  end;

var
  fmSalesRepEdit: TfmSalesRepEdit;

implementation

uses CustomerDM, uAppSettings;

{$R *.dfm}

procedure TfmSalesRepEdit.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmCustomer.cdsSRLkup;
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
end;



procedure TfmSalesRepEdit.FormShow(Sender: TObject);
begin
  inherited;
  DBEdit2.SetFocus;
end;

procedure TfmSalesRepEdit.sbtTownClick(Sender: TObject);
begin
  if Sender = sbtTown then ShowTownMgr('');
end;

procedure TfmSalesRepEdit.DBEdit4KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key > #31) and (Key < #127) then
    ShowTownMgr(Key);
end;

procedure TfmSalesRepEdit.ShowTownMgr(keybuffer: string);
begin
  dmCustomer.SelectTownEx(dmCustomer.cdsSRLkup, keybuffer);
  {
  dmCustomer.TownMgrKeyBuffer := keybuffer;
  dmCustomer.actShowTownMgr.Execute;
  if not VarIsEmpty(dmCustomer.SelectedTown) then
    with dmCustomer do begin
      cdsSRLkup.Edit;
      cdsSRLkup['TOWN_ID'] := SelectedTown[0];
      cdsSRLkup['TownProvince'] := SelectedTown[1];
    end;
  }
end;

procedure TfmSalesRepEdit.DBEdit4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    ShowTownMgr('');
end;


end.
