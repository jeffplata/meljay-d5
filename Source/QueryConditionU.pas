unit QueryConditionU;

interface

uses
  Classes, SysUtils, Variants, Contnrs, DB, ReportVariablesU;

type
  TCondition = class(TObject)
  private
    FCondition : string;
    FActive: Boolean;
  public
    property Condition: string read FCondition write FCondition;
    property Active: Boolean read FActive write FActive;
    constructor Create( const ACond: string );
  end;

  TConditionList = class(TObjectList)
  private
    FStrIndex: TStrings;
    FVariables: TReportVariables;
    function GetCondition( sIndex: string ): TCondition;
    procedure SetCondition( sIndex: string; AValue: TCondition );
    function GetVariable(sIndex: string): Variant;
    procedure SetVariable(sIndex: string; const Value: Variant);
  public
    constructor Create( AOwner: TComponent ); 
    destructor Destory;
    function Add( sIndex: string; ACond: TCondition ): integer;
    property Items[sIndex: string] : TCondition read GetCondition write SetCondition; default;
    property Variables[ sIndex: string]: Variant  read GetVariable write SetVariable;
    function BuildCondition: string;
    function ExpandCondition: string;
  end;


implementation


{ TCondition }

constructor TCondition.Create(const ACond: string);
begin
  inherited Create;
  FCondition := ACond;
end;

{ TConditionList }

function TConditionList.Add(sIndex: string; ACond: TCondition): integer;
begin
  Result := inherited Add(ACond);
  FStrIndex.Add(sIndex);
end;

function TConditionList.BuildCondition: string;
var
  i: Integer;
  connStr : string;
  condString: string;
  condActive: Boolean;
const
  ANDSTR = ' AND '#13#10;
begin
  Result := '';
  for i := 0 to Count-1 do
  begin
    condString := TCondition(inherited Items[i]).Condition;
    condActive := TCondition(inherited Items[i]).Active;
    if condActive then
    begin
      if Result <> '' then connStr := ANDSTR;
      Result := Result + connStr + '('+ condString + ')';
    end;
  end;  
end;

constructor TConditionList.Create(AOwner: TComponent);
begin
  inherited;
  FStrIndex := TStringList.Create;
  FVariables := TReportVariables.Create(AOwner);
end;

destructor TConditionList.Destory;
begin
  FStrIndex.Free;
  FVariables.Free;
  inherited;
end;

function TConditionList.ExpandCondition: string;
begin
  result := FVariables.ExpandVariables(BuildCondition);
end;

function TConditionList.GetCondition(sIndex: string): TCondition;
var
  i : Integer;
begin
  i := FStrIndex.IndexOf(sIndex);
  if i = -1 then
    i := Add(sIndex, TCondition.Create(''));
  Result := inherited items[i] as TCondition;
end;

function TConditionList.GetVariable(sIndex: string): Variant;
begin
  Result := FVariables[sIndex];
end;

procedure TConditionList.SetCondition(sIndex: string; AValue: TCondition);
var
  i: Integer;
begin
  i := FStrIndex.IndexOf(sIndex);
  if i = -1 then
  begin
    i := Add(sIndex, AValue);
  end;
  inherited items[i] := AValue;
end;

procedure TConditionList.SetVariable(sIndex: string; const Value: Variant);
begin
  FVariables[sIndex] := Value;
end;

end.

