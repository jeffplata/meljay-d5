unit InvoiceEditCdsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls, Mask, DBCtrls,
  Buttons, PngSpeedButton, Grids, DBGrids;

type
  THackDBCombobox = class(TDBComboBox);

  TfmInvoiceEditCDS = class(TvfiSimpleEditCDS)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    sbtCustomer: TPngSpeedButton;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DataSource2: TDataSource;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBText1: TDBText;
    DBComboBox1: TDBComboBox;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    btnAddItem: TButton;
    btnRemoveItem: TButton;
    DBEdit1: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    sbtAddress: TPngSpeedButton;
    sbtSalesRep: TPngSpeedButton;
    btnCopyLastItem: TButton;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtCustomerClick(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit4Change(Sender: TObject);
    procedure DateTimePicker1CloseUp(Sender: TObject);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCopyLastItemClick(Sender: TObject);
  private
    procedure SelectCustomer(const keybuffer: string = '');
    procedure ShowTownMgr( const keybuffer: string = '');
    procedure SelectSalesRep( const keybuffer: string = '');
    procedure DBCombobox1Closeup( Sender: TObject );
    procedure SelectProduct(const keybuffer: string = '');
  public
    { Public declarations }
  end;
  
var
  fmInvoiceEditCDS: TfmInvoiceEditCDS;

implementation

uses InvoiceDM, CustomerDM, uAppSettings, ProductsDM, MainDM;

{$R *.dfm}

procedure TfmInvoiceEditCDS.FormCreate(Sender: TObject);
begin
  //DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
  THackDBCombobox(DBComboBox1).OnCloseUp := DBCombobox1Closeup;
  DBEdit1.Color := AppSettings.ReadOnlyFieldColor;
  DBEdit9.Color := AppSettings.ReadOnlyFieldColor;
  DBEdit10.Color := AppSettings.ReadOnlyFieldColor;
  DataSource1.DataSet := dmInvoice.cdsInv;
  DataSource2.DataSet := dmInvoice.cdsInv2;
//  LoadDBGridColumns(DBGrid1);
end;

procedure TfmInvoiceEditCDS.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := DBEdit4.Field.AsDateTime;
  DateTimePicker2.Date := DBEdit6.Field.AsDateTime;
  DBEdit2.SetFocus;
  btnCopyLastItem.Visible := not VarIsEmpty(dmInvoice.Copy_Detail_Buffer);
end;

procedure TfmInvoiceEditCDS.sbtCustomerClick(Sender: TObject);
begin
  if Sender = sbtCustomer then SelectCustomer else
  if Sender = sbtAddress then ShowTownMgr else
  if Sender = sbtSalesRep then SelectSalesRep;
end;

procedure TfmInvoiceEditCDS.DBEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key > #31) and (Key < #127) then
    if Sender = DBEdit2 then SelectCustomer(Key) else
    if Sender = DBEdit12 then ShowTownMgr(Key) else
    if Sender = DBEdit7 then SelectSalesRep(Key);
end;

procedure TfmInvoiceEditCDS.SelectCustomer(const keybuffer: string = '');
begin
  dmCustomer.CustomerKeybuffer := keybuffer;
  dmCustomer.actShowCustomerMgr.Execute;
  if not VarIsEmpty(dmCustomer.SelectedCustomer) then
    with dmInvoice do
    begin
      //we can also assign each variantarray value to a variant
      //value := dmProducts.SelectedProductType[1];   //value is type variant
      cdsInv.Edit;
      cdsInv['CLIENT_ID;ClientName;AGENT_ID;AgentName;TOWN_ID;TownProvince'] :=
        dmCustomer.SelectedCustomer;
    end;
end;

procedure TfmInvoiceEditCDS.DBEdit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    if Sender = DBEdit2 then SelectCustomer() else
    if Sender = DBEdit12 then ShowTownMgr() else
    if Sender = DBEdit7 then SelectSalesRep();
end;

procedure TfmInvoiceEditCDS.DBEdit4Change(Sender: TObject);
begin
  inherited;
  if not Self.Visible then Exit;
  if not (DBEdit4.DataSource.DataSet.State in [dsInsert,dsEdit]) then Exit;

  if Sender = DBEdit4 then
  begin
    DateTimePicker1.Date := DBEdit4.Field.AsDateTime;
    DBComboBox1Exit(DBComboBox1);
  end
  else if Sender = DBEdit6 then begin
    DateTimePicker2.Date := DBEdit6.Field.AsDateTime;
    DBComboBox1.Text := FloatToStr(DateTimePicker2.date - DateTimePicker1.date );
  end
end;

procedure TfmInvoiceEditCDS.DateTimePicker1CloseUp(Sender: TObject);
begin
  if sender = DateTimePicker1 then
    DBEdit4.Field.AsDateTime := DateTimePicker1.Date
  else if Sender = DateTimePicker2 then
    DBEdit6.Field.AsDateTime := DateTimePicker2.Date;
end;

procedure TfmInvoiceEditCDS.DBComboBox1Exit(Sender: TObject);
begin
  inherited;
  if not Self.Visible then Exit;

  if not (DBComboBox1.DataSource.DataSet.State in [dsInsert,dsEdit]) then Exit;

  with DataSource1.DataSet do
    if state in [dsInsert,dsEdit] then
    begin
      if DBComboBox1.Text = '' then
        FieldByName('TXN_DAYSDUE').AsInteger := 0
      else
        fieldbyname('TXN_DAYSDUE').AsInteger := StrToInt(DBComboBox1.text);
      FieldByName('TXN_DUEDATE').AsDateTime :=
        fieldbyname('TXN_DAYSDUE').AsInteger + fieldbyname('TXN_DATE').AsDateTime;
    end;

end;

procedure TfmInvoiceEditCDS.DBCombobox1Closeup(Sender: TObject);
begin
  DBComboBox1.Text := DBComboBox1.Items[DBComboBox1.itemindex];
  DBComboBox1Exit(Sender);
end;

procedure TfmInvoiceEditCDS.SelectProduct(const keybuffer: string = '');
begin
  TdmProducts.Open(dmuInvoices);
  dmProducts.ProductKeyBuffer := keybuffer;
  dmProducts.actShowProductMgr.Execute;
  if not VarIsEmpty(dmProducts.SelectedProduct) then begin
    dmInvoice.cdsInv2.Edit;
    dmInvoice.cdsInv2.FieldByName('PRODUCT_ID').AsInteger := dmProducts.SelectedProduct[0];
    dmInvoice.cdsInv2.FieldByName('PRODUCTNAME').AsString := dmProducts.SelectedProduct[1];
{    if VarIsNull(dmProducts.SelectedProduct[2]) then dmProducts.SelectedProduct[2] := 0;
    dmInvoice.cdsInv2.FieldByName('PRICE_UNIT').AsCurrency := dmProducts.SelectedProduct[2];
}    dmInvoice.cdsInv2.FieldByName('QTYOUT').FocusControl;
  end else
    dmInvoice.cdsInv2.FieldByName('ProductName').FocusControl;
end;

procedure TfmInvoiceEditCDS.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key >#31) and (Key< #127) then begin
    if DBGrid1.SelectedField.FieldName = 'ProductDesc' then
      with DBGrid1.DataSource.DataSet do
      begin
        Edit;
        SelectProduct(Key);
        Key := #0;
      end;
  end else if Key = #13 then
  begin
    if DBGrid1.Columns.Grid.SelectedIndex < DBGrid1.Columns.Count - 1 then
      DBGrid1.Columns[DBGrid1.Columns.grid.SelectedIndex + 1].Field.FocusControl
    else
    begin
      DBGrid1.DataSource.DataSet.Next;
      DBGrid1.Columns[0].field.FocusControl;
    end;
  end;
end;

procedure TfmInvoiceEditCDS.btnAddItemClick(Sender: TObject);
begin
  DataSource2.DataSet.Append;
  //todo: cancel append if product not selected
  SelectProduct('');
//  DataSource2.DataSet.fieldbyname('PRODUCT_ID').asinteger := SelectProduct('');
end;

procedure TfmInvoiceEditCDS.btnRemoveItemClick(Sender: TObject);
begin
  if not DataSource2.DataSet.Bof then
    DataSource2.DataSet.Delete;
end;

procedure TfmInvoiceEditCDS.ShowTownMgr(const keybuffer: string);
begin
  dmCustomer.SelectTownEx(dmInvoice.cdsInv, keybuffer);
  {
  dmCustomer.TownMgrKeyBuffer := keybuffer;
  dmCustomer.actShowTownMgr.Execute;
  if not VarIsEmpty(dmCustomer.SelectedTown) then
    with dmInvoice do
    begin
      //we can also assign each variantarray value to a variant
      //value := dmProducts.SelectedProductType[1];   //value is type variant
      cdsInv_Edit.Edit;
      cdsInv_Edit['TOWN_ID;TownProvince'] := dmCustomer.SelectedTown;
    end;
  }
end;

procedure TfmInvoiceEditCDS.SelectSalesRep(const keybuffer: string);
var
  selRecord: Variant;
begin
  selRecord := dmCustomer.SelectSalesRep(keybuffer);
  if not VarIsEmpty(selRecord) then
    with dmInvoice do
    begin
      cdsInv.Edit;
      cdsInv['AGENT_ID;AgentName'] := selRecord;
    end;
end;

procedure TfmInvoiceEditCDS.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
    SelectProduct;
end;

procedure TfmInvoiceEditCDS.btnCopyLastItemClick(Sender: TObject);
begin
  dmInvoice.CopyFromDetailBuffer;
end;

end.
