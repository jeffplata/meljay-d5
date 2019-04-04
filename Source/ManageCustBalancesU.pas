unit ManageCustBalancesU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Misc;

type
  TfmManageCustBalances = class(TForm)
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure ShowForm;
  end;

var
  fmManageCustBalances: TfmManageCustBalances;

implementation

{$R *.dfm}

{ TfmManageCustBalances }

class procedure TfmManageCustBalances.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmManageCustBalances) then begin
      fmManageCustBalances := TfmManageCustBalances.Create(nil);
    end;
    fmManageCustBalances.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmManageCustBalances.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmManageCustBalances := nil;
  Action := caFree;
end;

procedure TfmManageCustBalances.Button1Click(Sender: TObject);
begin
  close;
end;

end.
