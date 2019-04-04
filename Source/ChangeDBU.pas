unit ChangeDBU;

interface

uses
  Windows, Forms,
  Dialogs, StdCtrls, LabelMessage, Classes, Controls;

type
  TfmChangeDB = class(TForm)
    btnOk: TButton;
    Button2: TButton;
    Label1: TLabel;
    DBNameEdit: TEdit;
    btnBrowse: TButton;
    OpenDialog1: TOpenDialog;
    LabelMessage1: TLabelMessage;
    Label2: TLabel;
    ServerNameEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBNameEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChangeDB: TfmChangeDB;

implementation

uses
  SysUtils, MainDM, uAppSettings, BigIni;

{$R *.dfm}

procedure TfmChangeDB.FormCreate(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if AppSettings.Database = '' then begin
    DBNameEdit.Text := '';
    btnOk.Enabled := False; end
  else begin
    ServerNameEdit.Text := AppSettings.Server;
    DBNameEdit.Text := AppSettings.Database;
  end
end;

procedure TfmChangeDB.btnBrowseClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    DBNameEdit.Text := OpenDialog1.FileName;
end;

procedure TfmChangeDB.btnOkClick(Sender: TObject);
begin
  try
    if ServerNameEdit.Text = '' then ServerNameEdit.Text := 'localhost';
    try
      LabelMessage1.ShowLabelMessage('Connecting...');
      dmMain.Connect(ServerNameEdit.Text, DBNameEdit.Text, True);
    finally
      LabelMessage1.Hide;
    end;
    AppSettings.Server   := ServerNameEdit.Text;
    AppSettings.Database := DBNameEdit.Text;
    AppSettings.SaveConfig;
    with TBiggerIniFile.Create(AppSettings.UserConfigFile) do
    try
      WriteString('data','server',AppSettings.Server);
      WriteString('data','database',AppSettings.Database);
    finally
      free;
    end;
    Self.ModalResult := mrOk;
  except
    LabelMessage1.ShowLabelMessage('Failed to connect to database.',True);
    DBNameEdit.SetFocus;
    raise;
  end;
end;

procedure TfmChangeDB.DBNameEditChange(Sender: TObject);
begin
  btnOk.Enabled := Trim(DBNameEdit.Text) <> '';
end;

end.
