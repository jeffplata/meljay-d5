unit SearchEditU;

interface

uses
  StdCtrls, TB2Item, Classes, PngImageList;

type
  TMethodHolder = class
    procedure SearchEditKeypress(Sender: TObject; var Key: Char);
    procedure SearchEditKeyup(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchEditEnterKeyPressed(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  end;

  TSearchEdit = class(TComponent)
  private
    Edit: TEdit;
    tbiOpen: TTBCustomItem;
    tbiClearEdit: TTBCustomItem;
    FOnOpenClick: TNotifyEvent;
    FOnClearClick: TNotifyEvent;
    FOnEnterKeyPressed: TNotifyEvent;
    FAutoOpen: Boolean;
  published
    property OnEnterKeyPressed: TNotifyEvent read FOnEnterKeyPressed write FOnEnterKeyPressed;
  end;

var
  MethodHolder1: TMethodHolder;
  SearchEditList1: TList;
  LastKeyPressed: string;


function InsertSearchEdit(SearchEdit: TEdit; tbiOpen, tbiClear: TTBCustomItem;
  Images: TPngImageList; const AutoOpen: Boolean = True): TSearchEdit;
procedure RemoveSearchEdit(SearchEdit: TEdit);
function SearchEditPos( Item: TObject; List: TList): Integer;
function SearchEditPosOB( Item: TObject; List: TList): Integer;
function SearchEditPosCB( Item: TObject; List: TList): Integer;

implementation



//---------------


procedure TMethodHolder.ClearButtonClick(Sender: TObject);
var
  i: Integer;
begin
  i := SearchEditPosCB(Sender, SearchEditList1);
  if i <> -1 then begin
    TSearchEdit(SearchEditList1[i]).Edit.Text := '';
    if Assigned(TSearchEdit(SearchEditList1[i]).FOnClearClick) then
      TSearchEdit(SearchEditList1[i]).FOnClearClick(Sender);
  end;
  (Sender as TTBCustomItem).Enabled := False;
end;


procedure TMethodHolder.OpenButtonClick(Sender: TObject);
var
  i: Integer;
begin
  i := SearchEditPosOB(Sender, SearchEditList1);
  if i <> -1 then begin
    if Assigned(TSearchEdit(SearchEditList1[i]).FOnOpenClick) then
      TSearchEdit(SearchEditList1[i]).FOnOpenClick(Sender);
    TSearchEdit(SearchEditList1[i]).tbiClearEdit.Enabled :=
      (TSearchEdit(SearchEditList1[i]).Edit.Text <> '');
  end;
end;

procedure TMethodHolder.SearchEditEnterKeyPressed(Sender: TObject);
//var
//  i: integer;
begin
    //i := SearchEditPos(Sender,SearchEditList1);
    //if i <> -1 then
      //if Assigned(TSearchEdit(SearchEditList1[i]).FOnEnterKeyPressed) then
        //TSearchEdit(SearchEditList1[i]).FOnEnterKeyPressed(Sender);
  TSearchEdit(Sender).OnEnterKeyPressed(Sender);
end;

procedure TMethodHolder.SearchEditKeypress(Sender: TObject; var Key: Char);
var
  i: Integer;
begin
  i := SearchEditPos(Sender,SearchEditList1);
  if i = -1 then Exit;
  if key = #13 then begin
    Key := #0;
    if Assigned(TSearchEdit(SearchEditList1[i]).FOnEnterKeyPressed) then
      //SearchEditEnterKeyPressed(TSearchEdit(SearchEditList1[i]));
      TSearchEdit(SearchEditList1[i]).FOnEnterKeyPressed(SearchEditList1[i]);
  end else
  if (Key <#127) and (Key >#32) then
  begin
    LastKeyPressed := Key;
    if TSearchEdit(SearchEditList1[i]).FAutoOpen then
    begin
      TSearchEdit(SearchEditList1[i]).tbiOpen.Click;
      LastKeyPressed := '';
      Key := #0;
    end;
    end;
end;

procedure TMethodHolder.SearchEditKeyup(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
begin
    i := SearchEditPos(Sender,SearchEditList1);
    if i <> -1 then
      if TSearchEdit(SearchEditList1[i]).edit.text <> '' then
        TSearchEdit(SearchEditList1[i]).tbiClearEdit.Enabled := True;
end;

function InsertSearchEdit(SearchEdit: TEdit; tbiOpen, tbiClear: TTBCustomItem;
  Images: TPngImageList; const AutoOpen: Boolean = True): TSearchEdit;
var
  i: Integer;
  SearchEditItem: TSearchEdit;

begin
  i := SearchEditPos(SearchEdit, SearchEditList1);
  if i = -1 then begin

    SearchEditItem := TSearchEdit.Create(nil);
    try
      SearchEdit.Text := '';
      SearchEdit.OnKeyPress := MethodHolder1.SearcheditKeypress;
      SearchEdit.OnKeyUp := MethodHolder1.SearchEditKeyup;
      //SearchEditItem.FOnEnterKeyPressed :=  MethodHolder1.SearchEditEnterKeyPressed;
      SearchEditItem.Edit := SearchEdit;

      tbiOpen.Images := Images;
      tbiOpen.ImageIndex := 0;
      if Assigned(tbiOpen.OnClick) then
        SearchEditItem.FOnOpenClick := tbiOpen.OnClick;
      tbiOpen.OnClick := MethodHolder1.OpenButtonClick;

      SearchEditItem.tbiOpen := tbiOpen;

      tbiClear.Images := Images;
      tbiClear.ImageIndex := 1;
      if Assigned(tbiClear.OnClick) then
        SearchEditItem.FOnClearClick := tbiClear.OnClick;
      tbiClear.OnClick := MethodHolder1.ClearButtonClick;
      tbiClear.Enabled := false;
      SearchEditItem.tbiClearEdit := tbiClear;
      SearchEditItem.FAutoOpen := AutoOpen;

      SearchEditList1.Add(SearchEditItem);
    finally
    end;

  end;
  Result :=  SearchEditItem;
end;

procedure RemoveSearchEdit(SearchEdit: TEdit);
var
  i: Integer;
begin
  i := SearcheditPos(SearchEdit, SearchEditList1);
  if i <> -1 then
    SearchEditList1.Delete(i);
end;

function SearchEditPos(Item: TObject; List: TList): Integer;
begin
  Result := 0;
  while (Result < List.Count) and ( TSearchEdit(List.Items[Result]).Edit <> Item) do
    Inc(Result);
  if Result = List.Count then
    Result := -1;
end;


function SearchEditPosOB(Item: TObject; List: TList): Integer;
begin
  Result := 0;
  while (Result < List.Count) and ( TSearchEdit(List.Items[Result]).tbiOpen <> Item) do
    Inc(Result);
  if Result = List.Count then
    Result := -1;
end;


function SearchEditPosCB(Item: TObject; List: TList): Integer;
begin
  Result := 0;
  while (Result < List.Count) and ( TSearchEdit(List.Items[Result]).tbiClearEdit <> Item) do
    Inc(Result);
  if Result = List.Count then
    Result := -1;
end;



initialization
  MethodHolder1 := TMethodHolder.Create;
  SearchEditList1 := TList.Create;
  LastKeyPressed := '';

finalization
  MethodHolder1.Free;
  SearchEditList1.Free;

end.
