unit TableConfigU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxDBGrid, NxColumns, NxDBColumns, DBClient, DBCtrls, Mask,
  DBGrids;

type
  TfmTableConfig = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    NextDBGrid1: TNextDBGrid;
    Label3: TLabel;
    DataSource1: TDataSource;
    btnClose: TButton;
    btnSave: TButton;
    btnRevert: TButton;
    btnRefresh: TButton;
    GroupBox1: TGroupBox;
    DataSource2: TDataSource;
    NextDBGrid2: TNextDBGrid;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    NxDBCheckBoxColumn1: TNxDBCheckBoxColumn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    btnApply: TButton;
    cdsTables: TClientDataSet;
    cdsTablesContainer: TStringField;
    cdsTablesTable: TStringField;
    dsTables: TDataSource;
    cdsProps: TClientDataSet;
    cdsPropsFieldName: TStringField;
    cdsPropsCaption: TStringField;
    cdsPropsFieldWidth: TIntegerField;
    cdsPropsVisible: TBooleanField;
    cdsPropsTable: TStringField;
    cdsPropsColWidth: TIntegerField;
    NxDBTextColumn5: TNxDBTextColumn;
    cdsContainers: TClientDataSet;
    cdsContainersContainer: TStringField;
    DataSource3: TDataSource;
    cdsContainersTablesDS: TDataSetField;
    cdsTablesPropsDS: TDataSetField;
    DBLookupComboBox1: TDBLookupComboBox;
    NxDBTextColumn6: TNxDBTextColumn;
    cdsPropsPosition: TIntegerField;
    ComboBox1: TComboBox;
    Label6: TLabel;
    lblCont: TLabel;
    lblTable: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    fn: string;
  public
    procedure SaveCDS( fn: String );
    procedure RevertCDS( cds: TClientDataSet );
    procedure LoadCDSDataFromFile( cds: TClientDataSet; fn: string );
    procedure LoadFromRepo( ACont: String; ATable: string );
    procedure SaveToRepo( ACont: String; ATable: string );
    procedure Open;
    procedure LoadGridColumns( AGrid: TDBGrid; const ACont, ATable: string );
    procedure SaveGridColumns( AGrid: TDBGrid; const ACont, ATable: string );
  end;

var
  fmTableConfig: TfmTableConfig;

implementation

uses MainDM, uAppSettings;

{$R *.dfm}

procedure TfmTableConfig.FormCreate(Sender: TObject);
begin
  fn := 'TableConfig.xml';

  with cdsContainers do
    if not Active then begin
      CreateDataSet;
      if FileExists(fn) then
        LoadFromFile(fn);
      Open;
      cdsTables.Open;
      cdsProps.Open;
    end;

  cdsContainers.LogChanges := False;
  cdsTables.LogChanges := false;
  cdsProps.LogChanges := false;

end;

procedure TfmTableConfig.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfmTableConfig.btnSaveClick(Sender: TObject);
begin
  SaveCDS(fn);
end;

procedure TfmTableConfig.btnRevertClick(Sender: TObject);
begin
  RevertCDS( cdsContainers );
end;

procedure TfmTableConfig.SaveCDS(fn: String);
begin
  with cdsContainers do begin
    //MergeChangeLog;
    SaveToFile(fn, dfXMLUTF8);
  end;
end;

procedure TfmTableConfig.RevertCDS(cds: TClientDataSet);
begin
  cds.CancelUpdates;
end;

procedure TfmTableConfig.btnRefreshClick(Sender: TObject);
begin
//  ReadCDSData;
end;

procedure TfmTableConfig.LoadCDSDataFromFile(cds: TClientDataSet; fn: string);
var
  sl: TStringList;
begin
  cds.LoadFromFile(fn);
  with DataSource1.DataSet do
  begin
    sl := TStringList.Create;
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    Open;
    First;
    DisableControls;
    try
      while not Eof do
      begin
        sl.Add(Fieldbyname('Container').AsString);
        Next;
      end;
    finally
      EnableControls;
    end;
    sl.Free;
    First;
  end;
end;

procedure TfmTableConfig.LoadFromRepo( ACont: String; ATable: string );
var
  i : Integer;
  TargetCDS: TClientDataSet;
begin
  try    
    with Application.FindComponent(ACont) do
      TargetCDS := (FindComponent(ATable) as TClientDataSet);
    if cdsContainers.Locate('Container',ACont,[]) then
      if cdsTables.Locate('Table',ATable,[]) then
        with TargetCDS do begin
          cdsProps.First;
          while not cdsProps.Eof do begin
            for i := 0 to FieldCount-1 do
              if UpperCase(cdsProps.FieldByName('Name').AsString) =
                 UpperCase(TargetCDS.Fields[i].FieldName) then
                begin
                  TargetCDS.Fields[i].DisplayLabel := cdsProps.FieldByName('Caption').AsString;
                  TargetCDS.Fields[i].DisplayWidth := cdsProps.FieldByName('Width').AsInteger;
                  TargetCDS.Fields[i].Visible      := cdsProps.FieldByName('Visible').AsBoolean;
                end;
            cdsProps.Next;
          end;
        end;
  except
    raise exception.Create('Dataset not available.');
  end;
end;

procedure TfmTableConfig.Open;
begin
  cdsContainers.Open;
  cdsTables.Open;
  cdsProps.Open;
end;

procedure TfmTableConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfmTableConfig.SaveToRepo(ACont, ATable: string);
var
  i : Integer;
  TargetCDS: TClientDataSet;
  RepoDS: TDataSet;
begin
  try
    with Application.FindComponent(ACont) do
      TargetCDS := (FindComponent(ATable) as TClientDataSet);
    RepoDS := cdsProps;
    with TargetCDS do begin
      RepoDS.Filter := '(Container = '+QuotedStr(ACont)+ ') and (Table = '+
        QuotedStr(ATable) +')';
      RepoDS.First;
      while not RepoDS.Eof do begin
        for i := 0 to FieldCount-1 do
          if UpperCase(RepoDS.FieldByName('Name').AsString) =
             UpperCase(TargetCDS.Fields[i].FieldName) then
            begin
              RepoDS.Edit;
              RepoDS.FieldByName('Caption').AsString  := TargetCDS.Fields[i].DisplayLabel;
              RepoDS.FieldByName('Width').AsInteger   := TargetCDS.Fields[i].DisplayWidth;
              RepoDS.FieldByName('Visible').AsBoolean := TargetCDS.Fields[i].Visible;
            end;
        RepoDS.Next;
      end;
    end;
  except
    raise exception.Create('Dataset not available.');
  end;
end;

procedure TfmTableConfig.LoadGridColumns( AGrid: TDBGrid;
    const ACont, ATable: string );
var
  i: Integer;
begin
//  for i := 0 to AGrid.Columns.Count - 1 do
//    AGrid.Columns[i].Visible := False;
  AGrid.Columns.Clear;

  if cdsContainers.Locate('Container',ACont,[]) then
    if cdsTables.Locate('Table',ATable,[]) then begin
      cdsProps.First;
      i := 0;
      while not cdsProps.Eof do begin
        AGrid.Columns.Add;
        AGrid.Columns[i].FieldName := cdsProps.FieldByName('Name').AsString;
        if cdsProps.FieldByName('GridWidth').AsInteger > 0 then
          AGrid.Columns[i].Width := cdsProps.FieldByName('GridWidth').AsInteger;
        AGrid.Columns[i].Title.Caption := cdsProps.FieldByName('Caption').AsString;
        AGrid.Columns[i].Visible := cdsProps.FieldByName('Visible').AsBoolean;
        cdsProps.Next;
        Inc(i);
      end;
//      while not cdsProps.Eof do begin
//        for i := 0 to AGrid.Columns.Count - 1 do
//          if cdsProps.FieldByName('Name').AsString = AGrid.Columns[i].FieldName then
//          begin
//            if cdsProps.FieldByName('GridWidth').AsInteger > 0 then
//              AGrid.Columns[i].Width := cdsProps.FieldByName('GridWidth').AsInteger;
//            AGrid.Columns[i].Title.Caption := cdsProps.FieldByName('Caption').AsString;
//            AGrid.Columns[i].Visible := cdsProps.FieldByName('Visible').AsBoolean;
//          end;
//        cdsProps.Next;
//      end;
    end;
end;

procedure TfmTableConfig.SaveGridColumns(AGrid: TDBGrid; const ACont,
  ATable: string);
var
  i : Integer;
begin
  if not cdsContainers.Locate('Container',ACont,[]) then
  begin
    cdsContainers.AppendRecord([ACont]);
  end;
  if not cdsTables.Locate('Table',ATable,[]) then
  begin
    cdsTables.Append;
    cdsTables.FieldByName('Table').AsString := ATable;
    cdsTables.Post;
  end;
  with AGrid do
    for i := 0 to Columns.Count - 1 do
      if not cdsProps.Locate('Name',Columns[i].FieldName,[]) then
      begin
        cdsProps.Append;
        cdsProps.FieldByName('Name').AsString := Columns[i].FieldName;
        cdsProps.FieldByName('Caption').AsString := Columns[i].Title.Caption;
        cdsProps.FieldByName('Width').AsInteger := Columns[i].Field.DisplayWidth;
        cdsProps.FieldByName('Gridwidth').AsInteger := Columns[i].Width;
        cdsProps.FieldByName('Visible').AsBoolean := Columns[i].Visible;
        cdsProps.FieldByName('Position').AsInteger := i;
        cdsProps.Post;
      end else
      begin
        cdsProps.Edit;
        cdsProps.FieldByName('Gridwidth').AsInteger := Columns[i].Width;
        cdsProps.FieldByName('Position').AsInteger := i;
        cdsProps.Post;
      end;

end;

procedure TfmTableConfig.FormShow(Sender: TObject);
var
  i: Integer;
  ACont, ATable: string;
begin
  if not assigned(AppSettings.FormForTableConfig) then
    Exit;

  //look for dbgrids
  //todo: look also for dbgrid-likes 
  ComboBox1.Clear;
  with AppSettings.FormForTableConfig do
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TDBGrid) then
        ComboBox1.Items.AddObject(Components[i].Name,Components[i]);
  if ComboBox1.Items.Count > 0
    then ComboBox1.ItemIndex := 0;

  lblCont.Caption := AppSettings.FormForTableConfig.Name;
  i := ComboBox1.ItemIndex;
  lblTable.Caption := TDBGrid(ComboBox1.Items.Objects[i]).DataSource.DataSet.Name;

  //position record pointers
  ACont := lblCont.Caption;
  ATable := lblTable.Caption;
  if cdsContainers.Locate('Container',ACont,[]) then
     cdsTables.Locate('Table',ATable,[]);
end;

end.
