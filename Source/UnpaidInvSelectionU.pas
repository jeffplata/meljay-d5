unit UnpaidInvSelectionU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NxScrollControl, NxCustomGridControl, NxCustomGrid,
  NxDBGrid, DB, InvoiceDM, NxColumns, NxDBColumns;

type
  TfmUnpaidInvSelection = class(TForm)
    NextDBGrid1: TNextDBGrid;
    btnOk: TButton;
    btnCancel: TButton;
    DataSource1: TDataSource;
    NxDBTextColumn1: TNxDBTextColumn;
    NxDBTextColumn2: TNxDBTextColumn;
    NxDBTextColumn3: TNxDBTextColumn;
    NxDBTextColumn4: TNxDBTextColumn;
    NxDBTextColumn5: TNxDBTextColumn;
    NxDBTextColumn6: TNxDBTextColumn;
    NxDBTextColumn7: TNxDBTextColumn;
    Label2: TLabel;
    Label3: TLabel;
    btnRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    //procedure NextDBGrid1CellDblClick(Sender: TObject; ACol,
    //  ARow: Integer);
    //procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    //FORAmount         : Double;
    FUnappliedORAmount: Double;
    //LineTempID        : Integer;
    SavePoint         : Integer;
  public
    //class procedure ShowForm( ORAmount: Double ); overload;
    class function ShowForm: Integer; overload;
  end;

var
  fmUnpaidInvSelection: TfmUnpaidInvSelection;

implementation

uses
  DBClient;

{$R *.dfm}

procedure TfmUnpaidInvSelection.FormCreate(Sender: TObject);
begin

end;

{
procedure TfmUnpaidInvSelection.NextDBGrid1CellDblClick(Sender: TObject;
  ACol, ARow: Integer);
var
  InvAmount : Double;
  InvAmountPaid: Double;
  AmountApplied : Double;
  AmtToApply : Double;
  msgFullyPaid: string;
begin

  msgFullyPaid := 'Invoice is fully paid. To remove applied payments, ' +#13#10
    +'delete entries from Collection Details.';
  InvAmount := dmInvoice.cdsUnpaid.fieldByName('TXN_AMOUNT').AsFloat;
  InvAmountPaid := dmInvoice.cdsUnpaid.fieldByName('TXN_AMOUNTPAID').AsFloat;

  if InvAmountPaid >= InvAmount then
  begin
    MessageDlg(msgFullyPaid, mtInformation, [mbOK], 0);
    Exit;
  end;

  AmountApplied := dmInvoice.cdsUnpaid.fieldbyname('AmountApplied').AsFloat;

  FUnappliedORAmount := FUnappliedORAmount + AmountApplied;
  if AmountApplied > 0 then
    AmtToApply := 0
  else
    AmtToApply :=  InvAmount - InvAmountPaid;
  if AmtToApply > FUnappliedORAmount then
    AmtToApply := FUnappliedORAmount;

  dmInvoice.cdsUnpaid.Edit;
  dmInvoice.cdsUnpaid.FieldByName('AmountApplied').AsFloat := AmtToApply;
  dmInvoice.cdsUnpaid.Post;
  FUnappliedORAmount := FUnappliedORAmount - AmtToApply;

  Label3.Caption := Format('%2.2n',[FUnappliedORAmount]);

end;
 }
      {
procedure TfmUnpaidInvSelection.btnOkClick(Sender: TObject);
var
  bm: string;
  TotalAmtApplied: Double;
  UnpaidTxnNumber: string;
  UnpaidAmtPaid: Double;
  UnpaidDate: TDateTime;
begin



  with DataSource1.DataSet do
  begin
    bm := Bookmark;
    try
      //clear out changes in collection detail
      dmInvoice.cdsCol2_Edit.CancelUpdates;
    finally
      TotalAmtApplied := FORAmount - FUnappliedORAmount;
      Bookmark := bm;
      if TotalAmtApplied > FORAmount then
      begin
        ShowMessage('Over payment.');
        ModalResult := mrNone;
      end else
      begin
        First;
        while not Eof do
        begin
          UnpaidTxnNumber :=  FieldbyName('TXN_NUMBER').AsString;
          UnpaidAmtPaid :=    Fieldbyname('AmountApplied').AsFloat;
          UnpaidDate :=       fieldbyname('TXN_DATE').AsDateTime;
          if (UnpaidAmtPaid <> 0) and
             (not dmInvoice.cdsCol2_Edit.Locate('TXN_NUMBER', UnpaidTxnNumber,[])) then
            begin
              with dmInvoice.cdsCol2_Edit do begin
                Append;
                Dec(LineTempID);
                FieldByName('COL_DETAIL_ID').AsInteger :=    LineTempID;
                FieldByName('TXN_NUMBER').AsString :=        UnpaidTxnNumber;
                FieldByName('COL_DETAIL_AMTPAID').AsFloat := UnpaidAmtPaid;
                FieldByName('TXN_DATE').AsDateTime :=        UnpaidDate;
                Post;
              end;
            end;
          Next;
        end;
      end;
      with dmInvoice.cdsCol_Edit do
        FieldByName('COL_AMOUNTAPPLIED').AsFloat := TotalAmtApplied;
    end;
  end;

end;

}

procedure TfmUnpaidInvSelection.btnCancelClick(Sender: TObject);
begin
  dmInvoice.cdsUnpaid.SavePoint := SavePoint;
end;

{
class procedure TfmUnpaidInvSelection.ShowForm(ORAmount: Double);
begin
  if not Assigned(fmUnpaidInvSelection) then
    fmUnpaidInvSelection := TfmUnpaidInvSelection.Create(nil);
  with dmInvoice.cdsCol_Edit do
  begin
    fmUnpaidInvSelection.FORAmount := fieldbyname('COL_AMOUNT').AsFloat;
//    fmUnpaidInvSelection.FUnappliedORAmount := fieldbyname('COL_UNAPPLIEDAMT').AsFloat;
    fmUnpaidInvSelection.FUnappliedORAmount := ORAmount;
  end;
  fmUnpaidInvSelection.ShowModal;
end;
}

procedure TfmUnpaidInvSelection.FormShow(Sender: TObject);
begin
  Caption := 'Unpaid Invoices of '+ dmInvoice.cdsCol['clientname'];
  Label3.Caption := Format('%2.2n',[FUnappliedORAmount]);
  SavePoint := dmInvoice.cdsUnpaid.SavePoint;
end;

class function TfmUnpaidInvSelection.ShowForm: Integer;
begin
  if not Assigned(fmUnpaidInvSelection) then
    fmUnpaidInvSelection := TfmUnpaidInvSelection.Create(nil);
  Result := fmUnpaidInvSelection.ShowModal;
end;

procedure TfmUnpaidInvSelection.btnRefreshClick(Sender: TObject);
begin
  dmInvoice.cdsUnpaid.Refresh;
end;

end.
