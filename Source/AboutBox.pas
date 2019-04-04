unit AboutBox;

interface

uses
  Windows, {Messages, SysUtils, Variants, Classes, Graphics, Controls,} Forms,
  {Dialogs, }StdCtrls, ComCtrls, RzStatus, Controls, Classes;

type
  TfmAboutBox = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    AppNameVersion: TLabel;
    AppCopyright: TLabel;
    lblAuthorEmail: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    RzVersionInfo1: TRzVersionInfo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure ShowForm;
  end;

var
  fmAboutBox: TfmAboutBox;

implementation

uses
  uAppSettings;

{$R *.dfm}

{ TfAboutBox }

procedure TfmAboutBox.FormCreate(Sender: TObject);
begin
  //lblAppTitle.Caption := AppSettings.ApplicationName +' '+AppSettings.ApplicationVersionNo;
  AppNameVersion.Caption := RzVersionInfo1.ProductName + ' ' +
    //RzVersionInfo1.FileVersion;
    RzVersionInfo1.ProductVersion;
  AppCopyright.Caption := RzVersionInfo1.Copyright;
  Memo1.Clear;
  Memo1.Lines.Add(ComponentToString(AppSettings));
end;

class procedure TfmAboutBox.ShowForm;
begin
  with TfmAboutBox.Create(nil) do
  try
    PageControl1.ActivePageIndex := 0;
    ShowModal;
  finally
    free;
  end;
end;

end.
