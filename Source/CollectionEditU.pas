unit CollectionEditU;

interface

uses
  Windows, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, vfi_SimpleEdit_CDS, DB, StdCtrls, ComCtrls,
  DBCtrls, LabelMessage, NxColumns,
  NxCustomGrid, NxDBGrid, RzEdit, RzDBEdit, RzDBBnEd, NxDBColumns,
  NxScrollControl, NxCustomGridControl, ExtCtrls, Mask, ActnList;

type
  TfmCollectionsEdit = class(TvfiSimpleEditCDS)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    DBComboBox1: TDBComboBox;
    btnAddInvoices: TButton;
    DataSource2: TDataSource;
    Button1: TButton;
    LabelMessage1: TLabelMessage;
    DBRadioGroup1: TDBRadioGroup;
    Label4: TLabel;
    NextDBGrid1: TNextDBGrid;
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBNumberColumn;
    RzDBButtonEdit1: TRzDBButtonEdit;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    Label9: TLabel;
    RzDBButtonEdit2: TRzDBButtonEdit;
    ActionList1: TActionList;
    actCopyCell: TAction;
    NxDBTextColumn4: TNxDBTextColumn;
    procedure actCopyCellExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddInvoicesClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure RzDBButtonEdit1ButtonClick(Sender: TObject);
    procedure RzDBButtonEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzDBButtonEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzDBButtonEdit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzDBButtonEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure RzDBButtonEdit2ButtonClick(Sender: TObject);
  private
    UnpaidSavePoint: Integer;
    procedure ShowCustomerMgr(const keybuffer: string = '');
    procedure SelectCollector(const keybuffer: string = '');
  public
    { Public declarations }
  end;

var
  fmCollectionsEdit: TfmCollectionsEdit;

implementation

uses
  InvoiceDM, CustomerDM, uAppSettings, UnpaidInvSelectionU, MainDM, Clipbrd;

{$R *.dfm}

procedure TfmCollectionsEdit.actCopyCellExecute(Sender: TObject);
var
  g: TNextDBGrid;
begin
  g := NextDBGrid1;
  Clipboard.AsText := g.CellValue[g.SelectedColumn,g.SelectedRow];
end;

procedure TfmCollectionsEdit.FormShow(Sender: TObject);
begin
  inherited;
  RzDBButtonEdit1.SetFocus;
  UnpaidSavePoint := dmInvoice.cdsUnpaid.SavePoint;
end;

procedure TfmCollectionsEdit.ShowCustomerMgr(const keybuffer: string);
begin
  //if not Assigned(dmCustomer) then
    //TdmCustomer.Open(dmuCollections);
  TdmCustomer.OpenCustomers(dmuCollections);
  dmCustomer.CustomerKeybuffer := keybuffer;
  dmCustomer.actShowCustomerMgr.Execute;
  if not VarIsEmpty(dmCustomer.SelectedCustomer) then
    with dmInvoice do
    begin
      //we can also assign each variantarray value to a variant
      //value := dmProducts.SelectedProductType[1];   //value is type variant
      cdsCol.Edit;
      cdsCol['CLIENT_ID'  ] := dmCustomer.SelectedCustomer[0];
      cdsCol['ClientName']  := dmCustomer.SelectedCustomer[1];
      cdsCol['AGENT_ID'   ] := dmCustomer.SelectedCustomer[2];
      cdsCol2.Last;
      while not cdsCol2.Bof do cdsCol2.Delete;
    end;
end;

procedure TfmCollectionsEdit.FormCreate(Sender: TObject);
begin
  inherited;
  DBEdit8.Color := AppSettings.ReadOnlyFieldColor;
  DataSource1.DataSet := dmInvoice.cdsCol;
  DataSource2.DataSet := dmInvoice.cdsCol2;
  Self.Caption := Self.Caption + ' ['+
     DataSource1.DataSet.fieldbyname('COL_ID').Text +']';
end;

procedure TfmCollectionsEdit.btnAddInvoicesClick(Sender: TObject);
var
  col_amount: TField;
  sClientID: string;
  or_amount, inv_balance: Double;
  or_amt_applied, amt_to_apply : Double;
  unp_amount: TField;
begin
  sClientID := dmInvoice.cdsCol.fieldbyname('CLIENT_ID').AsString;
  if sClientID = '' then begin
    ShowMessage('Please select a customer for this collection.');
    dmInvoice.cdsCol.fieldbyname('ClientName').FocusControl;
    Exit;
  end;

  (*
  col_amount := dmInvoice.cdsCol.fieldbyname('COL_AMOUNT');
  if col_amount.AsFloat = 0 then begin
    LabelMessage1.ShowLabelMessage('Indicate Amount before selecting invoice.');
    col_amount.FocusControl;
    Exit;
  end else
  begin
    unp_amount := dmInvoice.cdsCol.FieldByName('UnappliedAmount');
    if unp_amount.AsFloat = 0 then begin
      LabelMessage1.ShowLabelMessage('Full Amount has been applied; increase amount as necessary.');
      col_amount.FocusControl;
      Exit;
    end;
  end;
  *)
  
  with dmInvoice.cdsUnpaid do
  begin
    filter := 'CLIENT_ID =  '+quotedstr(sClientID);
    filtered := True;
  end;

  if TfmUnpaidInvSelection.ShowForm = mrOk then
  begin
    // add selected invoice to details
    with dminvoice, dmInvoice.cdsCol2 do begin
      or_amount := cdsCol.fieldbyname('col_amount').AsFloat;
      inv_balance := cdsUnpaid.fieldbyname('UnpaidAmount').AsFloat;
      or_amt_applied := cdsCol.fieldbyname('col_amountapplied').AsFloat;
      Append;
      FieldByName('txn_number').AsString := cdsUnpaid.fieldbyname('txn_number').AsString;
      FieldByName('txn_date').AsDateTime := cdsUnpaid.fieldbyname('txn_date').AsDateTime;
      if or_amount < inv_balance then amt_to_apply := or_amount else amt_to_apply := inv_balance;
      FieldByName('col_detail_amtpaid').AsFloat := amt_to_apply;
      FieldByName('clientname').AsString := cdsCol['clientname'];
      try
        Post;
        cdsCol.FieldByName('col_amountapplied').AsFloat :=  or_amt_applied +
            FieldByName('col_detail_amtpaid').AsFloat;
      except
        Cancel;
      end;
    end;
  end;

  {

  TfmUnpaidInvSelection.ShowForm(
     dmInvoice.cdsCol_Edit.fieldByName('UnappliedAmount').AsFloat);
  }
end;

procedure TfmCollectionsEdit.btnOkClick(Sender: TObject);
//var
//  AmountApplied: Double;
begin
  if dmInvoice.cdsCol.FieldByName('COL_AMOUNT').AsFloat = 0 then begin
    LabelMessage1.ShowLabelMessage('Can''t save this document; ZERO amount.',True);
    ModalResult := mrNone;
    Exit;
  end;
  inherited;
  {
  with dmInvoice.cdsUnpaid do
  begin
    First;
    while not eof do
    begin
      AmountApplied := FieldByName('AmountApplied').AsFloat;
      if AmountApplied > 0 then
      begin
        Edit;
        FieldByName('TXN_AMOUNTPAID').AsFloat :=
          Fieldbyname('TXN_AMOUNTPAID').AsFloat + AmountApplied;
        FieldByName('AmountApplied').AsFloat := 0;
        Post;
      end;
      Next;
    end;
  end;
  }
end;

procedure TfmCollectionsEdit.Button1Click(Sender: TObject);
begin
  if not dminvoice.cdsCol2.Eof then
    dmInvoice.cdsCol2.Delete;
end;

procedure TfmCollectionsEdit.btnCancelClick(Sender: TObject);
begin
  dmInvoice.cdsUnpaid.SavePoint := UnpaidSavePoint;
  inherited;
end;

procedure TfmCollectionsEdit.RzDBButtonEdit1ButtonClick(Sender: TObject);
begin
  LabelMessage1.HideLabelMessage;
  ShowCustomerMgr();
end;

procedure TfmCollectionsEdit.RzDBButtonEdit1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    ShowCustomerMgr();
end;

procedure TfmCollectionsEdit.RzDBButtonEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key > #31) and (Key < #127) then
  begin
    ShowCustomerMgr(Key);
    Key := #0;
  end;
end;

procedure TfmCollectionsEdit.SelectCollector(const keybuffer: string);
var
  collector: Variant;
begin
  collector := dmCustomer.SelectCollector(keybuffer);
  if not VarIsEmpty(collector) then begin
    DataSource1.DataSet.FieldByName('COLLECTOR_ID').AsString := collector[0];
    DataSource1.DataSet.FieldByName('COLLECTORNAME').AsString := collector[1];
  end;
end;

procedure TfmCollectionsEdit.RzDBButtonEdit2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF Key = VK_F2 then SelectCollector();
end;

procedure TfmCollectionsEdit.RzDBButtonEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key>#32) and (Key < #127) then SelectCollector(Key);
end;

procedure TfmCollectionsEdit.RzDBButtonEdit2ButtonClick(Sender: TObject);
begin
  SelectCollector();
end;

end.
