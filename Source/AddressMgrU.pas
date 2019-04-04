unit AddressMgrU;

interface

uses
  Windows, {Messages, SysUtils, Variants, }Classes, {Graphics, Controls, }Forms,
  {Dialogs, }vfi_itemmanagerCDS, DB, ImgList, PngImageList, ActnList,
  StdCtrls, Grids, DBGrids, TB2Item, TB2Dock, TB2Toolbar, Controls;

type
  TfmAddressMgr = class(TvfiItemManagerCDS)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAddressMgr: TfmAddressMgr;

implementation

//uses
//  CustomerDM;

{$R *.dfm}

procedure TfmAddressMgr.FormCreate(Sender: TObject);
begin
  inherited;
  //DataSource1.DataSet := dmCustomer.cdsAddressLkUp;
  with DataSource1.DataSet do
    if not Active then Open;
end;

end.
