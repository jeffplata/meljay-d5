unit AgentEditStd;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LabelMessage, DB;

type
  TfmAgentEditStd = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    LabelMessage1: TLabelMessage;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    EditMode : integer;
  public
    class function ShowForm( const AMode: Integer = 2 ): Boolean;
  end;

var
  fmAgentEditStd: TfmAgentEditStd;

implementation

uses CustomerDM, MainDM;

{$R *.dfm}

procedure TfmAgentEditStd.Button1Click(Sender: TObject);
begin
  //ok button
  if Trim(Edit1.Text) = '' then begin
    LabelMessage1.ShowLabelMessage('''Agent Name'' cannot be empty.');
    Edit1.SetFocus;
    ModalResult := mrNone;
  end else
    with dmCustomer.cdsAgentLkup do
    begin
      if EditMode = 1 then  begin
        Append;
        FieldByName('AGENT_ID').AsInteger := dmMain.GetNextPK;
      end else
        Edit;
      FieldByName('AGENT_NAME').AsString := Edit1.Text;
      FieldByName('AREA').AsString := Edit2.Text;
      Post;
      ModalResult := mrOk;
    end;
end;

class function TfmAgentEditStd.ShowForm(const AMode: Integer ): Boolean;
begin
  // Amode = 1 insert, amode = 2 edit
  if not Assigned(fmAgentEditStd) then
    fmAgentEditStd := TfmAgentEditStd.Create(nil);
  fmAgentEditStd.EditMode := AMode;
  case AMode of
  1:
    with fmAgentEditStd do
    begin
      Edit1.Text := '';
      Edit2.Text := '';
    end;
  2:
    with fmAgentEditStd do
    begin
      Edit1.Text := dmCustomer.cdsAgentLkup.fieldbyname('AGENT_NAME').AsString;
      edit2.Text := dmCustomer.cdsAgentLkup.fieldbyname('AREA').AsString;
    end;
  end;
  Result := (fmAgentEditStd.ShowModal = mrOk);
end;

procedure TfmAgentEditStd.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
