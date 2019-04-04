unit Misc_old;

interface

uses
  Windows, Forms, Messages, Classes,
  IB_Components, IB_Grid, DBGrids, Math, DB, {TableConfigU, }DBClient,
  NxDBGrid;
  
  procedure LockWindowUpdate;
  procedure UnlockWindowUpdate;
//  procedure IBQuickLoadNameValue( aSQL: string; Names: TStrings; Values: TStrings );
//  procedure IBGridLoadSettings( aGrid: TIB_Grid; aFile, aSection : string );
//  procedure IBGridSaveSettings( aGrid: TIB_Grid; aFile, aSection : string );
  procedure AutoStretchDBGridColumns(Grid: TDBGrid; Columns, MinWidths: Array of integer);
  procedure LoadGridColumns(AGrid: TDBGrid; const Acont, ATable: string);
  procedure SaveGridColumns(AGrid: TDBGrid; const Acont, ATable: string);
  procedure SaveDBGridColumns(ADBGrid: TDBGrid);
  procedure LoadDBGridColumns(ADBGrid: TDBGrid);
  function SortClientDataSet(ClientDataSet: TClientDataSet;
    const FieldName: String): Boolean;
  procedure NDBGSortColumn(Sender: TObject; ACol: Integer;
    Ascending: Boolean);
  function SortCDS(ClientDataSet: TClientDataSet;
    const FieldName: String; Ascending: Boolean): Boolean;

    
implementation

uses
  SysUtils;

procedure LockWindowUpdate;
begin
  SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 0, 0);
end;

procedure UnlockWindowUpdate;
begin
  SendMessage(Application.MainForm.ClientHandle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Application.MainForm.ClientHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_NOINTERNALPAINT);
end;

//procedure IBQuickLoadNameValue( aSQL: string; Names: TStrings; Values: TStrings );
//begin
//    with tib_cursor.Create(nil) do
//    try
//      Names.Clear;
//      Values.Clear;
//      sql.Add(aSQL);
//      first;
//      while not eof do
//        begin
//          Names.Add(fields[0].AsString);
//          Values.Add(fields[1].AsString);
//          Next;
//        end;
//    finally
//      free;
//    end;
//end;

//procedure ibGridLoadSettings( aGrid: TIB_Grid; aFile, aSection : string );
//var
//  list: TStrings;
//  i: Integer;
//begin
//  list := TStringList.Create;
//  try
//    with TBiggerIniFile.Create(aFile) do
//    try
//      ReadSectionValues(aSection,list);
//    finally
//      Free;
//    end;
//
//    if list.Count = 0 then
//      for i := 0 to aGrid.GridFieldCount -1 do
//        list.Append(aGrid.GridFields[i].FieldName);
//
//    aGrid.GridLinks.CommaText := list.CommaText;
//  finally
//    list.Free;
//  end;
//end;

//procedure IBGridSaveSettings( aGrid: TIB_Grid; aFile, aSection : string );
//begin
//  with TBiggerIniFile.Create(aFile) do
//  try
//    WriteSectionValues(aSection,aGrid.GridLinks);
//  finally
//    Free;
//  end;
//end;

procedure AutoStretchDBGridColumns(Grid: TDBGrid; Columns, MinWidths: Array of integer);
var
  x, i, ww: integer;
begin
  // Stretches TDBGrid columns
  // Columns contains columns to stretch
  // MinWidths contains columns minimum widhts
  // To stretch grids columns 1,2 and 5 automatically and set minimum widths to 80, 150 and 150 call
  // AutoStretchDBGridColumns(DBGrid1, [1,2,5], [80, 150, 150]);
  Assert(Length(Columns) = Length(MinWidths), 'Length(Columns) <> Length(MinWidths)');
  ww := 0;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if Grid.Columns[i].Visible then
      ww := ww + Grid.Columns[i].Width + 1; //** +1 for grid line width
  end;
  if dgIndicator in Grid.Options then
    ww := ww + IndicatorWidth;
  x := (Grid.ClientWidth - ww) div Length(Columns);
  for i := 0 to  High(Columns) do
    Grid.Columns[Columns[i]].Width := Max(Grid.Columns[Columns[i]].Width + x, MinWidths[i])-1;
end;

procedure LoadGridColumns(AGrid: TDBGrid; const Acont, ATable: string);
begin
  //fmTableConfig.LoadGridColumns(AGrid, Acont, ATable);
end;

procedure SaveGridColumns(AGrid: TDBGrid; const Acont, ATable: string);
begin
  //fmTableConfig.SaveGridColumns(AGrid, Acont, ATable);
end;

procedure LoadDBGridColumns(ADBGrid: TDBGrid);
var
  fn : string;
  exedate, txtdate: Integer;
begin
  fn := ExtractFilePath(ParamStr(0)) + 'Views\Grids\' + ADBGrid.Owner.Name +
         '_' + ADBGrid.Name;

  exedate := FileAge(Application.ExeName);
  txtdate := Fileage(fn + '_default.grs');

  if (not FileExists(fn + '_default.grs')) or (exedate > txtdate) then begin
    ADBGrid.Columns.SaveToFile(fn + '_default.grs');
    FileSetDate(fn + '_default.grs', exedate);
  end;

  if FileExists(fn + '.grs') then
    ADBGrid.Columns.LoadFromFile(fn + '.grs');
end;

procedure SaveDBGridColumns(ADBGrid: TDBGrid);
var
  fn: string;
begin
  fn := ExtractFilePath(ParamStr(0)) + 'Views\Grids\' + ADBGrid.Owner.Name +
         '_' + ADBGrid.Name;

  ADBGrid.Columns.SaveToFile(fn + '.grs');
end;

function SortClientDataSet(ClientDataSet: TClientDataSet;
  const FieldName: String): Boolean;
var
  i: Integer;
  NewIndexName: String;
  IndexOptions: TIndexOptions;
  Field: TField;
begin
Result := False;
Field := ClientDataSet.Fields.FindField(FieldName);
//If invalid field name, exit.
if Field = nil then Exit;
//if invalid field type, exit.
if (Field is TObjectField) or (Field is TBlobField) or
  (Field is TAggregateField) or (Field is TVariantField)
   or (Field is TBinaryField) then Exit;
//Get IndexDefs and IndexName using RTTI
//Ensure IndexDefs is up-to-date
ClientDataSet.IndexDefs.Update;
//If an ascending index is already in use,
//switch to a descending index
if ClientDataSet.IndexName = FieldName + '__IdxA'
then
  begin
    NewIndexName := FieldName + '__IdxD';
    IndexOptions := [ixDescending];
  end
else
  begin
    NewIndexName := FieldName + '__IdxA';
    IndexOptions := [];
  end;
//Look for existing index
for i := 0 to Pred(ClientDataSet.IndexDefs.Count) do
begin
  if ClientDataSet.IndexDefs[i].Name = NewIndexName then
    begin
      Result := True;
      Break
    end;  //if
end; // for
//If existing index not found, create one
if not Result then
    begin
      ClientDataSet.AddIndex(NewIndexName,
        FieldName, IndexOptions);
      Result := True;
    end; // if not
//Set the index
ClientDataSet.IndexName := NewIndexName;
end;


procedure NDBGSortColumn(Sender: TObject; ACol: Integer;
  Ascending: Boolean);
var
  fldname : string;
  nxdbg: TNextDBGrid;
begin
  nxdbg := TNextDBGrid(Sender);
  if not nxdbg.DataSource.DataSet.Active then Exit;
  fldname := nxdbg.Columns[ACol].FieldName;
  if fldname = '' then Exit;
  with TClientdataset(nxdbg.DataSource.DataSet) do
  begin
    SortCDS(TClientDataSet(nxdbg.DataSource.DataSet), fldname, Ascending);
  end;
end;

//-------------
function SortCDS(ClientDataSet: TClientDataSet;
  const FieldName: String; Ascending: Boolean): Boolean;
var
  i: Integer;
  NewIndexName: String;
  IndexOptions: TIndexOptions;
  Field: TField;
begin
  Result := False;
  Field := ClientDataSet.Fields.FindField(FieldName);
  //If invalid field name, exit.
  if Field = nil then Exit;
  //if invalid field type, exit.
  if (Field is TObjectField) or (Field is TBlobField) or
    (Field is TAggregateField) or (Field is TVariantField)
     or (Field is TBinaryField) then Exit;
  //Get IndexDefs and IndexName using RTTI
  //Ensure IndexDefs is up-to-date
  ClientDataSet.IndexDefs.Update;
  //If an ascending index is already in use,
  //switch to a descending index
  if Ascending
  then
    begin
      NewIndexName := FieldName + '__IdxA';
      IndexOptions := [];
    end
  else
    begin
      NewIndexName := FieldName + '__IdxD';
      IndexOptions := [ixDescending];
    end;
  //Look for existing index
  for i := 0 to Pred(ClientDataSet.IndexDefs.Count) do
  begin
    if ClientDataSet.IndexDefs[i].Name = NewIndexName then
      begin
        Result := True;
        Break
      end;  //if
  end; // for
  //If existing index not found, create one
  if not Result then
      begin
        ClientDataSet.AddIndex(NewIndexName,
          FieldName, IndexOptions);
        Result := True;
      end; // if not
  //Set the index
  ClientDataSet.IndexName := NewIndexName;
end;



end.
