unit CustomerEditCdsU;

interface

uses
  Windows, Variants, Classes, Controls, Forms,
  vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, DBCtrls, Mask,
  Buttons;

type
  TfmCustomerEditCDS = class(TvfiSimpleEditCDS)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBMemo2: TDBMemo;
    Label4: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    DataSource2: TDataSource;
    btnCopyLast: TButton;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    sbtTown: TSpeedButton;
    sbtSR: TSpeedButton;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopyLastClick(Sender: TObject);
    procedure sbtTownClick(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    procedure SelectTown(keybuffer: string);
    procedure SelectSalesRep(const keybuffer: string = '');
  public
    { Public declarations }
  end;

var
  fmCustomerEditCDS: TfmCustomerEditCDS;

implementation

uses CustomerDM, uAppSettings, DBClient;

{$R *.dfm}

procedure TfmCustomerEditCDS.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmCustomer.cdsCust{_Edit};
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
end;

procedure TfmCustomerEditCDS.FormShow(Sender: TObject);
begin
  inherited;
  DBEdit2.SetFocus;
  btnCopyLast.Visible := not VarIsEmpty(dmCustomer.CopyBuffer_Customer);
end;

procedure TfmCustomerEditCDS.btnCopyLastClick(Sender: TObject);
begin
  dmCustomer.CopyFromBuffer;
  DBEdit2.SetFocus;
end;

procedure TfmCustomerEditCDS.sbtTownClick(Sender: TObject);
begin
  if Sender = sbtTown then SelectTown('') else
  if Sender = sbtSR then SelectSalesRep('');
end;

procedure TfmCustomerEditCDS.DBEdit4KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key > #31) and (Key < #127) then
  begin
    if Sender = DBEdit4 then SelectTown(Key) else
    if Sender = DBEdit6 then SelectSalesRep(Key);
  end;
end;

procedure TfmCustomerEditCDS.SelectTown(keybuffer: string);
//var
//  town: Variant;
begin
  dmCustomer.SelectTownEx(TCustomClientDataset(DataSource1.DataSet), keybuffer);
  {
  town := dmCustomer.SelectTown(keybuffer);
  if not VarIsEmpty(town) then begin
    DataSource1.DataSet.FieldByName('TOWN_ID').AsString := town[0];
    DataSource1.DataSet.FieldByName('TOWNPROVINCE').AsString := town[1];
  end;
  }
end;

procedure TfmCustomerEditCDS.DBEdit4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then begin
    if Sender = DBEdit4 then SelectTown('') else
    if Sender = DBEdit6 then SelectSalesRep('');
  end;
end;

procedure TfmCustomerEditCDS.SelectSalesRep(const keybuffer: string);
var
  selRecord: variant;
begin
  selRecord := dmCustomer.SelectSalesRep(keybuffer);
  if not VarIsEmpty(selRecord) then
  begin
    DataSource1.DataSet.Edit;
    DataSource1.DataSet['AGENT_ID;AgentName'] := selRecord;
  end;
end;

procedure TfmCustomerEditCDS.btnOkClick(Sender: TObject);
begin
  //dmCustomer.cdscust_edit.fieldbyname('CLIENTTYPEDESC').asstring :=
  DataSource1.DataSet.fieldbyname('CLIENTTYPEDESC').asstring :=
    dblookupcombobox3.text;
  inherited;

end;

end.
