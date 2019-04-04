unit SalesRepMgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_itemmanagerCDS, DB, ImgList, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar;

type
  TfmSalesRepMgr = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
    procedure AddActionExecute(Sender: TObject); override;
    procedure EditActionExecute(Sender: TObject); override;
    procedure DeleteActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSalesRepMgr: TfmSalesRepMgr;

implementation

uses CustomerDM, Misc, MainDM;

{$R *.dfm}

procedure TfmSalesRepMgr.FormCreate(Sender: TObject);
begin
  inherited;
//  DataSource1.DataSet := dmCustomer.cdsSRLkup;
//  with DataSource1.DataSet do
//    if not Active then Open;
//  AutoStretchDBGridColumns(DBGrid1,[0,1],[50,40]);
  DataSource1.DataSet := dmCustomer.cdsSRLkup;
  dmCustomer.OpenSalesReps(dmuSalesReps);
  AutoStretchDBGridColumns(DBGrid1,[0,1],[50,40]);
end;

procedure TfmSalesRepMgr.AddActionExecute(Sender: TObject);
begin
//  dmCustomer.SalesRepEditMode := 1;   //append mode
//  dmCustomer.actShowSalesRepEditor.Execute;
  dmCustomer.EditSalesRep(True,SearchEdt.Text);
end;

procedure TfmSalesRepMgr.EditActionExecute(Sender: TObject);
begin
//  dmCustomer.SalesRepEditMode := 2;   //edit mode
//  dmCustomer.actShowSalesRepEditor.Execute;
  dmCustomer.EditSalesRep;
end;

procedure TfmSalesRepMgr.DeleteActionExecute(Sender: TObject);
var
  bm: string;
begin
  with dmCustomer.cdsSRLkup do
  begin
    DisableControls;
    bm := Bookmark;
    Delete;
    if ApplyUpdates(0) > 0 then
      Bookmark := bm;
    EnableControls;
  end;
end;

end.
