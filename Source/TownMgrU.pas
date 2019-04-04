unit TownMgrU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_itemmanagerCDS, DB, ImgList, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar;

type
  TfmTownMgr = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
    procedure AddActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
  private
    procedure ShowEditor(isNew:Boolean);
  public
    class procedure OpenAsEditor;
  end;

var
  fmTownMgr: TfmTownMgr;

implementation

uses
  Misc, CustomerDM, TownEditU, MainDM;

{$R *.dfm}

procedure TfmTownMgr.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmCustomer.cdsTownLkup;
//  with DataSource1.DataSet do
//    if not Active then Open;
  AutoStretchDBGridColumns(DBGrid1,[0,1,2],[45,50,50]);
end;

procedure TfmTownMgr.AddActionExecute(Sender: TObject);
begin
  ShowEditor(True);
end;

procedure TfmTownMgr.EditActionExecute(Sender: TObject);
begin
  ShowEditor(False);
end;

procedure TfmTownMgr.ShowEditor(isNew:Boolean);
begin
  with TfmTownEdit.Create(nil) do
  try
    with dmCustomer.cdsTownLkup do begin
      if isNew then begin
        Append;
        FieldByName('TOWN').AsString := SearchEdt.Text;
      end;
      if ShowModal=mrOk then begin
        if ChangeCount > 0 then
          ApplyUpdates(0);
      end else
        CancelUpdates;
    end;
  finally
    free;
  end;
end;

procedure TfmTownMgr.DeleteActionExecute(Sender: TObject);
var
  bm: string;
begin
  with dmCustomer.cdsTownLkup do begin
    DisableControls;
    bm := Bookmark;
    Delete;
    if ApplyUpdates(0) > 0 then
      Bookmark := bm;
    EnableControls;
  end;
end;

class procedure TfmTownMgr.OpenAsEditor;
begin
  TdmCustomer.OpenTowns(dmuTowns);
  with TfmTownMgr.Create(nil,'TownProvince','') do
  try
    ShowModal;
  finally
    Free;
  end;
  TdmCustomer.Close(dmuTowns);
end;

end.
