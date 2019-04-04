unit statusForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls{, LMDCustomButton, LMDButton};

type
  TstatusFm = class(TForm)
    Panel1: TPanel;
    label1: TPanel;
    cancelpanel: TPanel;
    LMDButton1: tbutton;
    procedure FormCreate(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
  private
    fMessageText: string;
    fPrevMessage: string;
    fCancelled: boolean;
    procedure SetMessageText(aText:string);
  public
    property MessageText:string read fMessageText write SetMessageText;
    property Cancelled:boolean read fCancelled;
  end;

var
  statusFm: TstatusFm;

implementation

{$R *.DFM}

procedure TstatusFm.FormCreate(Sender: TObject);
begin
  fPrevMessage := chr(0);
  fCancelled := false;
end;

procedure TstatusFm.SetMessageText(aText:string);
begin

  if fPrevMessage=aText then
    exit;
  fPrevMessage := aText;

  fMessageText := aText;
  cancelpanel.Visible := false;
  if (aText<>'') and (aText[1] = '!') then begin
    fMessageText := copy(aText,2,10000);
    cancelpanel.Visible := true
  end;

  label1.Caption := fMessageText;

  if fMessageText<>'' then begin
    if not self.Visible then
      self.show;
    self.Update;
    sleep(500);
  end
  else begin
    self.Hide;
    fCancelled := false;
  end;
end;

procedure TstatusFm.LMDButton1Click(Sender: TObject);
begin
  fCancelled := true;
end;

end.
