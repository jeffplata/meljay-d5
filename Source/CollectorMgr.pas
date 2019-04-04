unit CollectorMgr;

interface

uses
  Windows, {Messages, }SysUtils, {Variants, }Classes, {Graphics,} Forms,
  Dialogs, vfi_itemmanagerCDS, DB, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar, ImgList, Controls;

type
  TfmCollectorMgr = class(TvfiItemManagerCDS)
    procedure AddActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure OpenAsEditor;
  end;

var
  fmCollectorMgr: TfmCollectorMgr;

implementation

uses
  CustomerDM, MainDM;

{$R *.dfm}

procedure TfmCollectorMgr.AddActionExecute(Sender: TObject);
begin
  DataSource1.DataSet.Append;
  dmCustomer.EditCollector;
end;

procedure TfmCollectorMgr.EditActionExecute(Sender: TObject);
begin
  dmCustomer.EditCollector;
end;

procedure TfmCollectorMgr.DeleteActionExecute(Sender: TObject);
var
  bm : Pointer;
begin
  with dmCustomer.cdsCollectorLkup do
  begin
    bm := GetBookmark;
    Delete;
    if ApplyUpdates(0) > 0 then
    begin
      CancelUpdates;
      GotoBookmark(bm);
    end;
    FreeBookmark(bm);
  end;
end;

class procedure TfmCollectorMgr.OpenAsEditor;
begin
  TdmCustomer.OpenCollectors(dmuCollectors);
  with TfmCollectorMgr.Create(nil,'CLIENT_NAME','') do
  try
    DataSource1.DataSet := dmCustomer.cdsCollectorLkup;
    ShowModal;
  finally
    FreeAndNil(fmCollectorMgr);
  end;
  TdmCustomer.Close(dmuCollectors);
end;

end.
