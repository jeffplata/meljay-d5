unit DSFilterU;

interface

type
  TFilter = record
    FormatStr: string;
    Condition: string;
    Active: Boolean;
  end;

  TFilters = array of TFilter;

  function GetFilterString(var AFilter: array of TFilter): string;

implementation


//----------------------------------
function GetFilterString(var AFilter: array of TFilter): string;
var
  i: Integer;
  condStr : string;
const
  andStr = ' AND '#13#10;
begin
  Result := '';
  for i := Low(AFilter) to High(AFilter) do
  begin
    if AFilter[i].Active then
    begin
      if Result <> '' then
        condStr := andStr;
      Result := Result + condStr + '('+ AFilter[i].Condition + ')';
    end;
  end;
end;

end.
 