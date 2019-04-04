unit ProductTypesMgrU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_itemmanagerCDS, DB, ImgList, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar;

type
  TfmProductTypeMgr = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
    procedure AddActionExecute(Sender: TObject); override;
    procedure EditActionExecute(Sender: TObject); override;
    procedure DeleteActionExecute(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProductTypeMgr: TfmProductTypeMgr;

implementation

uses ProductsDM, Misc, MainDM;

{$R *.dfm}

procedure TfmProductTypeMgr.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmProducts.CDSLkProdType;
  if not DataSource1.DataSet.Active then
    DataSource1.DataSet.Open;
  AutoStretchDBGridColumns(DBGrid1,[0,1],[10,50]);
end;

procedure TfmProductTypeMgr.AddActionExecute(Sender: TObject);
var
  aType: string;
begin
  InputQuery('New Product Type','Type Name',aType);
  if aType<>'' then
  with dmProducts.CDSLkProdType do
  begin
    InsertRecord([-1,aType]);
    ApplyUpdates(0);
  end;
end;

procedure TfmProductTypeMgr.EditActionExecute(Sender: TObject);
var
  aType: string;
begin
  aType := dmProducts.CDSLkProdType['TYPE_NAME'];
  InputQuery('Edit Product Type','Type Name',aType);
  if aType<>'' then
    with dmProducts.CDSLkProdType do
    try
      Edit;
      SetFields([nil,aType]);
      Post;
      ApplyUpdates(0); 
    finally
      if State in [dsInsert,dsEdit] then
        Cancel;
    end;
end;

procedure TfmProductTypeMgr.DeleteActionExecute(Sender: TObject);
begin
  with dmProducts.CDSLkProdType do
  begin
    Delete;
    ApplyUpdates(0);
  end;
end;

end.
