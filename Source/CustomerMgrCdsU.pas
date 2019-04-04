unit CustomerMgrCdsU;

interface

uses
  Windows, Classes, Forms,
  vfi_itemmanagerCDS, DB, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar, ImgList, Controls;

type
  TfmCustomerMgrCds = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
    procedure AddActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCustomerMgrCds: TfmCustomerMgrCds;

implementation

uses CustomerDM;

{$R *.dfm}

procedure TfmCustomerMgrCds.FormCreate(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmCustomer.cdsCust;
  //AutoStretchDBGridColumns(DBGrid1,[0,1,2],[40,40,40]);
end;

procedure TfmCustomerMgrCds.AddActionExecute(Sender: TObject);
begin
  with dmCustomer do begin
    DataSource1.DataSet.Append;
    DataSource1.DataSet.FieldByName('CLIENT_NAME').AsString := SearchEdt.Text;
    actShowCustomerEditCds.Execute;
  end;
end;

procedure TfmCustomerMgrCds.EditActionExecute(Sender: TObject);
begin
   dmCustomer.actShowCustomerEditCds.Execute;
end;

procedure TfmCustomerMgrCds.DeleteActionExecute(Sender: TObject);
var
  bm: string;
begin
  with dmCustomer.cdsCust{Lkup} do
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
