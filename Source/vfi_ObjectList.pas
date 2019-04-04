unit vfi_ObjectList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, IB_Components, TB2Item, TB2Dock, TB2Toolbar,
  ImgList, IB_ActionUpdate, ActnList, StdCtrls, PngImageList, ExtCtrls;

type
  TvfiObjectList = class(TForm)
    TBDock1: TTBDock;
    tbUpdate: TTBToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    IB_DataSource1: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    ActionList1: TActionList;
    IB_ActionEdit1: TIB_ActionEdit;
    IB_ActionDelete1: TIB_ActionDelete;
    IB_ActionAppend1: TIB_ActionAppend;
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
    TBItem5: TTBItem;
    procedure ActCloseExecute(Sender: TObject);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure ActClearSearchExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  vfiListing: TvfiListing;

implementation

{$R *.dfm}

procedure TvfiObjectList.ActCloseExecute(Sender: TObject);
begin
  close;
end;

procedure TvfiObjectList.IB_Grid1DblClick(Sender: TObject);
begin
  IB_ActionEdit1.Execute;
end;

procedure TvfiObjectList.ActClearSearchExecute(Sender: TObject);
begin
  SearchEdit.Clear;
end;

procedure TvfiObjectList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TvfiObjectList.SearchEditChange(Sender: TObject);
begin
  ActClearSearch.Enabled := SearchEdit.Text <> '';
end;

end.
