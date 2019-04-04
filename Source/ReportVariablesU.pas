unit ReportVariablesU;

interface

uses
  Classes, SysUtils, Variants;

type
  TReportVariables = class(TComponent)
  private
    FItems: TStrings;
    function GetVariable(sIndex: string): Variant;
    procedure SetVariable(sIndex: string; const Value: Variant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExpandVariables( Subject: String ): String;
    property Variables[index: string]: Variant read GetVariable write SetVariable; default;
  end;

implementation

uses
  Dialogs;





{ TReportVariable }

constructor TReportVariables.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
end;

destructor TReportVariables.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TReportVariables.ExpandVariables(Subject: String): String;
var
  i: integer;
  sInd: string;
const
  DL1 = '{';
  DL2 = '}';
begin
  Result := Subject;
  for i := 0 to FItems.Count-1 do
  begin
    sInd := FItems.Names[i];
//    Result := StringReplace(Result, DL1+sInd+DL2, QuotedStr(FItems.Values[sInd]),
//      [rfReplaceAll,rfIgnoreCase]);
    Result := StringReplace(Result, DL1+sInd+DL2, FItems.Values[sInd],
      [rfReplaceAll,rfIgnoreCase]);
  end;
end;

function TReportVariables.GetVariable(sIndex: string): Variant;
var
  i: integer;
begin
  result := '';
  i := FItems.IndexOfName(sIndex);
  if i <> -1 then
    Result := FItems.Values[FItems.Names[i]];
end;

procedure TReportVariables.SetVariable(sIndex: string;
  const Value: Variant);
var
  i: Integer;
begin
  if not VarIsEmpty(Value) then
  begin
    i := FItems.IndexOfName(sIndex);
    if i = -1 then
      FItems.Add(sIndex+'='+value) else
      FItems[i] := sIndex+'='+value;
  end;
end;

end.
