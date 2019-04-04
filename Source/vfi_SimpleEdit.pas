unit vfi_SimpleEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IB_Components;

type
  TvfiSimpleEdit = class(TForm)
    PageControl1: TPageControl;
    btnOk: TButton;
    btnCancel: TButton;
    TabSheet1: TTabSheet;
    IB_DataSource1: TIB_DataSource;
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

procedure TvfiSimpleEdit.btnOkClick(Sender: TObject);
begin
  //ok button
  if IB_DataSource1.Dataset.State in [dssInsert,dssEdit] then
    IB_DataSource1.Dataset.Post;
  ModalResult := mrOk;
end;

procedure TvfiSimpleEdit.btnCancelClick(Sender: TObject);
begin
  //cancel button
  if IB_DataSource1.Dataset.State in [dssInsert,dssEdit] then
    IB_DataSource1.Dataset.Cancel;
  ModalResult := mrCancel;
end;

procedure TvfiSimpleEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if IB_DataSource1.Dataset.State in [dssInsert,dssEdit] then
    IB_DataSource1.Dataset.Cancel;
//  ModalResult := mrCancel;
end;

end.
