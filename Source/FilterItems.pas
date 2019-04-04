unit FilterItems;

interface

uses
  Classes, Variants, Contnrs;

type
  TFilterItemsStatuses =  class(TObjectList)
  public
    Active: Boolean;
  end;


  TFilterItems = class(TComponent)
  private
    FItems: TStrings;
    FObjects: TFilterItemsStatuses;
    function GetCondition(sIndex: string): Variant;
    procedure SetCondition(sIndex: string; const Value: Variant);
    function GetIsActive(sIndex: string): Boolean;
    procedure SetIsActive(sIndex: string; const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //function ExpandVariables( Subject: String ): String;
    property Condition[index: string]: Variant read GetCondition write SetCondition; default;
    property Active[index: string]: Boolean read GetIsActive write SetIsActive;
  end;

implementation





{ TReportVariable }

constructor TFilterItems.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  FObjects := TFilterItemsStatuses.Create;
end;

destructor TFilterItems.Destroy;
begin
  FObjects.Free;
  FItems.Free;
  inherited;
end;

//------------------
//function TReportVariables.ExpandVariables(Subject: String): String;
//var
//  i: integer;
//  sInd: string;
//const
//  DL1 = '{';
//  DL2 = '}';
//begin
//  Result := Subject;
//  for i := 0 to FItems.Count-1 do
//  begin
//    sInd := FItems.Names[i];
//    Result := StringReplace(Result, DL1+sInd+DL2, FItems.Values[sInd],
//      [rfReplaceAll,rfIgnoreCase]);
//  end;
//end;


function TFilterItems.GetCondition(sIndex: string): Variant;
var
  i: integer;
begin
  result := '';
  i := FItems.IndexOfName(sIndex);
  if i <> -1 then
    Result := FItems.Values[FItems.Names[i]];
end;


procedure TFilterItems.SetCondition(sIndex: string;
  const Value: Variant);
var
  i: Integer;
begin
  if not VarIsEmpty(Value) then
  begin
    i := FItems.IndexOfName(sIndex);
//    if i = -1 then
//      FItems.Add(sIndex+'='+value) else
//      FItems[i] := sIndex+'='+value;
    if i = -1 then
    begin
      FItems.Add(sIndex+'='+value);
      FObjects.Add(TFilterItemsStatuses.Create(False));
    end else
      FItems[i] := sIndex+'='+value;
  end;
end;


function TFilterItems.GetIsActive(sIndex: string): Boolean;
var
  i: Integer;
begin
  Result := false;
  i := FItems.IndexOfName(sIndex);
  if i <> -1 then Result := TFilterItemsStatuses(FObjects[i]).Active;
end;

procedure TFilterItems.SetIsActive(sIndex: string; const Value: Boolean);
var
  i: Integer;
begin
  i := FItems.IndexOfName(sIndex);
  if i <> -1 then
    TFilterItemsStatuses(FObjects[i]).Active := Value;
end;



end.
