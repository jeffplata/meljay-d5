unit ProductsCdsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_ObjectListCDS, DB, ImgList, PngImageList, ActnList,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxDBGrid, ExtCtrls,
  StdCtrls, TB2Item, TB2Dock, TB2Toolbar, NxColumns, NxDBColumns;

type
  TfmProductsCds = class(TvfiObjectListCDS)
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure NextDBGridSortColumn(Sender: TObject; ACol: Integer;
      Ascending: Boolean);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure ShowForm;
  end;

var
  fmProductsCds: TfmProductsCds;

implementation

uses
  Misc, ProductsDM, MainDM, DBClient;

{$R *.dfm}

{ TfmProductsCds }

class procedure TfmProductsCds.ShowForm;
begin
  LockWindowUpdate;
  try
    if not Assigned(fmProductsCds) then
    begin
      TdmProducts.Open(dmuProducts);
      fmProductsCds := TfmProductsCds.Create(nil);
    end;
    fmProductsCds.Show;
  finally
    UnlockWindowUpdate;
  end;
end;

procedure TfmProductsCds.FormCreate(Sender: TObject);
begin
  dmProducts.OpenProductsCds;
  DataSource1.DataSet := dmProducts.cdsProduct;
  inherited;
end;

procedure TfmProductsCds.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TdmProducts.Close(dmuProducts);
  inherited;

end;

procedure TfmProductsCds.FormDestroy(Sender: TObject);
begin
  inherited;
  fmProductsCds := nil;
end;

procedure TfmProductsCds.NextDBGridSortColumn(Sender: TObject;
  ACol: Integer; Ascending: Boolean);
begin
   NDBGSortColumn(Sender,ACol,Ascending);
end;

procedure TfmProductsCds.actAppendExecute(Sender: TObject);
begin
  dmProducts.ShowProductEdit(1);

end;

procedure TfmProductsCds.actEditExecute(Sender: TObject);
begin
  dmProducts.ShowProductEdit(2);

end;

procedure TfmProductsCds.SearchEditChange(Sender: TObject);
begin
  inherited;
  if SearchEdit.Text <> '' then begin
    DataSource1.DataSet.Filter := 'PRODUCT_NAME like '+
      QuotedStr('%'+SearchEdit.Text+'%');
    DataSource1.DataSet.Filtered := True;
  end
  else
    DataSource1.DataSet.Filtered := False;
end;

procedure TfmProductsCds.actDeleteExecute(Sender: TObject);
var
  bm: string;
begin
  if MessageBox(Handle, PChar('Delete this product?'), 'Warning', MB_YESNO +
     MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES then
    Exit;

  with TClientDataSet(DataSource1.DataSet) do
  begin
    DisableControls;
    bm := Bookmark;
    Delete;
    if ApplyUpdates(0) > 0 then
    begin
      UndoLastChange(True);
      Bookmark := bm;
    end;
    EnableControls;
  end;
end;

end.
