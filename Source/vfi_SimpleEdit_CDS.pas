unit vfi_SimpleEdit_CDS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB;

type
  TvfiSimpleEditCDS = class(TForm)
    PageControl1: TPageControl;
    btnOk: TButton;
    btnCancel: TButton;
    TabSheet1: TTabSheet;
    DataSource1: TDataSource;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  vfiSimpleEdit: TvfiSimpleEdit;

implementation

{$R *.dfm}

procedure TvfiSimpleEditCDS.btnOkClick(Sender: TObject);
begin
  //ok button
  if DataSource1.Dataset.State in [dsInsert,dsEdit] then
    DataSource1.Dataset.Post;
  ModalResult := mrOk;
end;

procedure TvfiSimpleEditCDS.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TvfiSimpleEditCDS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(DataSource1.DataSet) then
    if (DataSource1.DataSet.State in [dsInsert,dsEdit]) then
    begin
      DataSource1.DataSet.Cancel;
      ModalResult := mrCancel;
    end;
end;

end.
