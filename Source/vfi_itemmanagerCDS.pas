unit vfi_itemmanagerCDS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TB2Item, TB2Dock, TB2Toolbar, ActnList, ImgList,
  PngImageList, Grids, StdCtrls, 
  DBGrids, DB;

type

  TDBGridHack = class(TCustomGrid);

  TvfiItemManagerCDS = class(TForm)
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    SelectTBtn: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    AddTBtn: TTBItem;
    EditTBtn: TTBItem;
    DeleteTBtn: TTBItem;
    TBSeparatorItem2: TTBSeparatorItem;
    ClearSearchTBtn: TTBItem;
    ActionList1: TActionList;
    SelectAction: TAction;
    AddAction: TAction;
    EditAction: TAction;
    DeleteAction: TAction;
    ClearSearchEdAction: TAction;
    PngImageList1: TPngImageList;
    Button1: TButton;
    SearchEdt: TEdit;
    TBControlItem1: TTBControlItem;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure SelectActionExecute(Sender: TObject);
    procedure AddActionExecute(Sender: TObject); virtual;
    procedure EditActionExecute(Sender: TObject); virtual;
    procedure DeleteActionExecute(Sender: TObject); virtual;
    procedure ClearSearchEdActionExecute(Sender: TObject);
    procedure SearchEdtKeyPress(Sender: TObject; var Key: Char);
    procedure SearchEdtKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SearchEdtChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    FPicklistMode : Boolean;
    FKeyBuffer : String;
    FSearchField: String;
    FReturnFields: String;
    FSelectedFieldValues : Variant;
    procedure SetPicklistMode(AValue: Boolean);
  public
    property PicklistMode: Boolean read FPicklistMode write SetPicklistMode;
    property KeyBuffer: string read FKeyBuffer write FKeyBuffer;
    property SelectedFieldValues: Variant read FSelectedFieldValues;
    constructor Create( AOwner: TComponent;
      const SearchField: string; const ReturnFields: string);
  end;

implementation



{$R *.dfm}

procedure TvfiItemManagerCDS.SelectActionExecute(Sender: TObject);
begin
  //select
  //ShowMessage('SelectAction not assigned; assign values to ItemID and ItemDescription');
  FSelectedFieldValues := DataSource1.DataSet.FieldValues[FReturnFields];
  ModalResult := mrOk;
end;

procedure TvfiItemManagerCDS.AddActionExecute(Sender: TObject);
begin
  // add
  showmessage('add method not defined');
end;

procedure TvfiItemManagerCDS.EditActionExecute(Sender: TObject);
begin
  //edit
  showmessage('edit method not defined');
end;

procedure TvfiItemManagerCDS.DBGrid1DblClick(Sender: TObject);
begin
  if PicklistMode then
    SelectAction.Execute
  else
    EditAction.Execute;
end;

procedure TvfiItemManagerCDS.DeleteActionExecute(Sender: TObject);
begin
  //delete
  showmessage('delete method not defined');
end;

procedure TvfiItemManagerCDS.ClearSearchEdActionExecute(Sender: TObject);
begin
  //clear search
  ClearSearchTBtn.Enabled := False;
  SearchEdt.Text := '';
  SearchEdt.SetFocus;
  DataSource1.DataSet.First;
  //SearchEdt.DataSource.Dataset.ClearSearchingLinks;
end;

constructor TvfiItemManagerCDS.Create(AOwner: TComponent;
  const SearchField, ReturnFields: string);
begin
  inherited Create(AOwner);
  FReturnFields := ReturnFields;
  FSearchField := SearchField;
  FPicklistMode := ReturnFields <> '';
end;

procedure TvfiItemManagerCDS.SearchEdtChange(Sender: TObject);
begin
  if SearchEdt.Text <> '' then
    DataSource1.DataSet.Filter := FSearchField + ' LIKE ' +QuotedStr('%'+SearchEdt.Text+'%');
  ClearSearchEdAction.Enabled := SearchEdt.Text <> '';
  with DataSource1.DataSet do begin
    Filtered := ClearSearchEdAction.Enabled;
    //SelectAction.Enabled := not DataSource1.DataSet.Bof;{(not FieldByName(FSearchField).isnull) and  }
      //(FieldByName(FSearchField).AsString <> '');
  end;
end;

procedure TvfiItemManagerCDS.SearchEdtKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = Chr(13)) and (FPicklistMode) then
  begin
    key := #0;
    SelectAction.Execute;
  end
end;

procedure TvfiItemManagerCDS.SearchEdtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ClearSearchTBtn.Enabled :=  SearchEdt.Text <> '';
  case Key of
    VK_UP :    DataSource1.DataSet.Prior;
    VK_DOWN :  DataSource1.DataSet.Next;
    VK_NEXT :  DataSource1.DataSet.MoveBy(TDBGridHack(DBGrid1).VisibleRowCount-1);
    VK_PRIOR:  DataSource1.DataSet.MoveBy(-TDBGridHack(DBGrid1).VisibleRowCount-1);
    //VK_ESCAPE: Close;
  end;

end;

procedure TvfiItemManagerCDS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //IMPORTANT
  if DataSource1.DataSet <> nil then
    DataSource1.DataSet.Filtered := False;
end;

procedure TvfiItemManagerCDS.FormCreate(Sender: TObject);
begin
  Button1.Left := -200;
  //PicklistMode := True;
end;

procedure TvfiItemManagerCDS.SetPicklistMode(AValue: Boolean);
begin
  if AValue then
    Assert(FReturnFields<>'','[ITEMMGR] Return fields not set.');
  FPicklistMode := AValue;
  SelectAction.Enabled := FPicklistMode;
end;

procedure TvfiItemManagerCDS.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TvfiItemManagerCDS.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
  FSelectedFieldValues := Unassigned;
  SearchEdt.SetFocus;
  if FKeyBuffer <> '' then
  begin
    SearchEdt.Text := FKeyBuffer;
    SearchEdt.SelStart := Length(FKeyBuffer);
  FKeyBuffer := '';       

  end
  else begin
    SearchEdt.Text := '';
  end;
end;

procedure TvfiItemManagerCDS.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  if Assigned(DataSource1.DataSet) and (DataSource1.DataSet.Active)  then
    with DataSource1.DataSet do begin
      SelectAction.Enabled := (not (Bof and Eof)) and PicklistMode;
      DeleteAction.Enabled := not (Bof and Eof);
      EditAction.Enabled   := not (bof and Eof);
    end;
end;

end.
