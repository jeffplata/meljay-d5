unit LabelMessage;

interface
uses
  StdCtrls, Classes, Graphics;

type
  TLabelMessage = class(TLabel)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowLabelMessage(AString: string; const bError: Boolean = False);
    procedure HideLabelMessage;
  published
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Hybrid',[TLabelMessage]);
end;

{ TLabelMessage }

constructor TLabelMessage.Create(AOwner: TComponent);
begin
  inherited;
  Visible := False;
  Font.Color := clBlue;
end;

destructor TLabelMessage.Destroy;
begin
  inherited;
end;

procedure TLabelMessage.HideLabelMessage;
begin
  Visible := False;
end;

procedure TLabelMessage.ShowLabelMessage(AString: string;
  const bError:Boolean = False);
begin
  Caption := '';
  if bError then begin
    Font.Color := clRed;
    Font.Style := [fsBold];
  end else begin
    Font.Color := clRed;
    Font.Style := [];
  end;
  Caption := AString;
  Visible := True;
end;

end.
