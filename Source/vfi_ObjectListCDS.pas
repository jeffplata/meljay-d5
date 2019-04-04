unit vfi_ObjectListCDS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Item, TB2Dock, TB2Toolbar,
  ImgList, ActnList, StdCtrls, PngImageList, ExtCtrls, DB,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid;

type

  TvfiObjectListCDS = class(TForm)
    TBDock1: TTBDock;
    tbUpdate: TTBToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    ActionList1: TActionList;
    ActClose: TAction;
    PngImageList1: TPngImageList;
    ActClearSearch: TAction;
    Panel1: TPanel;
    SearchEdit: TEdit;
    Label1: TLabel;
    TBSeparatorItem2: TTBSeparatorItem;
    TBItem4: TTBItem;
    TBFilter: TTBToolbar;
    TBControlItem1: TTBControlItem;
    TBControlItem2: TTBControlItem;
    tbiClearSearch: TTBItem;
    actAppend: TAction;
    actEdit: TAction;
    actDelete: TAction;
    DataSource1: TDataSource;
    NextDBGrid: TNextDBGrid;
    procedure ActCloseExecute(Sender: TObject);
    procedure ActClearSearchExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchEditChange(Sender: TObject);
    procedure NextDBGridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    //ConfigFile_Grid: String;
  public
    { Public declarations }
  end;

//var
//  vfiListing: TvfiListing;

implementation


{$R *.dfm}


//*************
//  program starts here

procedure TvfiObjectListCDS.ActCloseExecute(Sender: TObject);
begin
  close;
end;

procedure TvfiObjectListCDS.ActClearSearchExecute(Sender: TObject);
begin
  SearchEdit.Clear;
end;

procedure TvfiObjectListCDS.FormClose(Sender: TObject; var Action: TCloseAction);
var
  fn: string;
  dir: string;
begin
  Action := caFree;

  //NextDBGrid.SortedColumn.Sorted := false;
  dir := ExtractFilePath(ParamStr(0)) + 'Views\Grids\';
  ForceDirectories(dir);

  fn :=  dir + NextDBGrid.Owner.Name + '_' + NextDBGrid.Name;

  NextDBGrid.SaveToIni(fn + '.grs');
end;

procedure TvfiObjectListCDS.SearchEditChange(Sender: TObject);
begin
  ActClearSearch.Enabled := SearchEdit.Text <> '';
end;

procedure TvfiObjectListCDS.NextDBGridDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TvfiObjectListCDS.FormCreate(Sender: TObject);
var
  fn, dir : string;
  exedate, txtdate: Integer;
begin
  dir := ExtractFilePath(ParamStr(0)) + 'Views\Grids\';
  fn := dir + NextDBGrid.Owner.Name + '_' + NextDBGrid.Name;

  exedate := FileAge(Application.ExeName);
  txtdate := Fileage(fn + '_default.grs');

  if (not FileExists(fn + '_default.grs')) or (exedate > txtdate) then begin
    ForceDirectories(dir);
    NextDBGrid.SaveToIni(fn + '_default.grs');
    FileSetDate(fn + '_default.grs', exedate);
  end;

  if FileExists(fn + '.grs') then
    NextDBGrid.LoadFromIni(fn + '.grs');
end;

end.
