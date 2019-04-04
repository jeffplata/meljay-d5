unit ProductsDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, DBClient, Provider,
  Windows, ActnList, Forms, MainDM, FMTBcd, Variants;

type

  TdmProducts = class(TDataModule)
    SQLProduct: TSQLDataSet;
    dspProduct: TDataSetProvider;
    cdsProduct: TClientDataSet;
    SQLdsProdType: TSQLDataSet;
    DSPProdtype: TDataSetProvider;
    CDSLkProdType: TClientDataSet;
    ActionList1: TActionList;
    actShowProductTypeMgr: TAction;
    CDSLkProdTypePRODUCT_TYPE_ID: TIntegerField;
    CDSLkProdTypeTYPE_NAME: TStringField;
    cdsProduct_Edit: TClientDataSet;
    actShowProductEdit: TAction;
    cdsProductPRODUCT_ID: TIntegerField;
    cdsProductPRODUCT_NAME: TStringField;
    cdsProductPRODUCT_TYPE_ID: TIntegerField;
    cdsProduct_EditPRODUCT_ID: TIntegerField;
    cdsProduct_EditPRODUCT_NAME: TStringField;
    cdsProduct_EditPRODUCT_TYPE_ID: TIntegerField;
    cdsProductProductType: TStringField;
    cdsProduct_EditProductType: TStringField;
    cdsProduct_Lkup: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    actShowProductMgr: TAction;
    cdsProductPRICE: TFMTBCDField;
    cdsProduct_EditPRICE: TFMTBCDField;
    cdsProduct_LkupPRICE: TFMTBCDField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsProductNewRecord(DataSet: TDataSet);
    procedure dspProductGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: String);
    procedure actShowProductTypeMgrExecute(Sender: TObject);
    procedure actShowProductEditExecute(Sender: TObject);
    procedure cdsProductCalcFields(DataSet: TDataSet);
    procedure cdsProductBeforeOpen(DataSet: TDataSet);
    procedure dspProductBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure actShowProductMgrExecute(Sender: TObject);
    procedure DSPProdtypeGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure DSPProdtypeBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
  private
    InsertingProduct: Boolean;
    DMUsers: TDMUsers;
    ProductFormOked: Boolean;
  public
    SelectedProductType: Variant;
    SelectedProduct: Variant;
    ProductKeyBuffer: string;
    class procedure Open(dmUser: TDMUser);
    class procedure Close(dmUser: TDMUser);
    procedure OpenProductsCds;
    function ShowProductEdit(const pMode: Integer = -1): Boolean;
    function SelectProduct( const keybuffer: string = ''): Variant;
  end;

var
  dmProducts: TdmProducts;

implementation

uses Dialogs, ProductTypesMgrU, Controls, Misc, ProductEditCdsU, ProductMgr;

{$R *.dfm}

{ TdmProducts }

class procedure TdmProducts.Close(dmUser: TDMUser);
begin
  if Assigned(dmProducts) then
  begin
    if dmUser in dmProducts.DMUsers then
      dmProducts.DMUsers := dmProducts.DMUsers - [dmUser];
    if dmProducts.DMUsers = [] then begin
      FreeAndNil(fmProductMgr);
      FreeAndNil(fmProductEditCDS);
      FreeAndNil(dmProducts);
    end;
  end;
end;

class procedure TdmProducts.Open(dmUser: TDMUser);
begin
  if not Assigned(dmProducts) then
    dmProducts := TdmProducts.Create(Application);

  if not (dmUser in dmProducts.DMUsers) then
    dmProducts.DMUsers := dmProducts.DMUsers + [dmUser];
end;

procedure TdmProducts.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fmProductTypeMgr);
end;

procedure TdmProducts.OpenProductsCds;
var
  oldIndexName: string;
begin
  oldIndexName := cdsProduct.IndexName;
  cdsProduct.IndexName := '';

  cdsProduct.Close;
  cdsProduct.Open;

  if oldIndexName <> '' then
  begin
    SortCDS( cdsProduct,
             Copy(oldIndexName,1,Length(oldIndexName)-6),
             Copy(oldIndexName,Length(oldIndexName),1) = 'A'
             );
  end;

  cdsProduct_Edit.Close;
  cdsProduct_Edit.CloneCursor(cdsProduct, False, True);

  cdsProduct_Edit.FieldByName('PRODUCT_ID').OnGetText := dmMain.IDGetText;

  cdsProduct_Lkup.Close;
  cdsProduct_Lkup.CloneCursor(cdsProduct, False, True);
end;

procedure TdmProducts.cdsProductNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('PRODUCT_ID').Value := -1;
  DataSet.FieldByName('PRODUCT_TYPE_ID').Value := 0;
  InsertingProduct := True;
end;

procedure TdmProducts.dspProductGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'PRODUCT';
end;

procedure TdmProducts.actShowProductTypeMgrExecute(Sender: TObject);
begin
  if not Assigned(fmProductTypeMgr) then
    fmProductTypeMgr := TfmProductTypeMgr.Create(nil,'TYPE_NAME','PRODUCT_TYPE_ID;TYPE_NAME');
  if fmProductTypeMgr.ShowModal = mrOk then
    SelectedProductType := fmProductTypeMgr.SelectedFieldValues;
end;

procedure TdmProducts.actShowProductEditExecute(Sender: TObject);
begin
  if not Assigned(fmProductEditCDS) then
    fmProductEditCDS := TfmProductEditCDS.Create(Self);
  ProductFormOked := (fmProductEditCDS.ShowModal = mrOk);
  with cdsProduct_Edit do
    if ProductFormOked then
    begin
      if ChangeCount > 0 then
          ApplyUpdates(0);
    end
    else
      CancelUpdates;
  InsertingProduct := False;
end;

procedure TdmProducts.cdsProductCalcFields(DataSet: TDataSet);
begin
  with TClientDataSet(DataSet) do
    if Active and ( State = dsInternalCalc ) then begin
      FieldByName('ProductType').AsString := CDSLkProdType.Lookup('PRODUCT_TYPE_ID',
        FieldbyName('PRODUCT_TYPE_ID').AsString,'TYPE_NAME');
    end;
end;

procedure TdmProducts.cdsProductBeforeOpen(DataSet: TDataSet);
begin
  if not CDSLkProdType.Active then
    CDSLkProdType.Open;
end;

function TdmProducts.ShowProductEdit(const pMode: Integer = -1): Boolean;
var
  editAllowed: Boolean;
  cds, cdsEd: TClientDataSet;
  fid, fidvalue: string;
  act: TAction;
  pFormOked: ^Boolean;
begin
  //---- change these vars
  cds       := cdsProduct;
  cdsEd     := cdsProduct_Edit;
  fid       := 'PRODUCT_ID';
  fidvalue  := cds.fieldbyname(fid).AsString;
  act       := actShowProductEdit;
  pFormOked := @ProductFormOked;
  //----------------------------

  editAllowed := True;
  if pMode = -1 then
    raise Exception.Create('Indicate the following mode:'#13#10'1 = Insert; 2 = Edit');
  if pMode = 1 then
    cdsEd.Append
  else
    begin
      if (cds.Bof and cds.Eof) then
        editAllowed := False else
        cdsEd.Locate(fid,fidvalue,[]);
    end;
  if editAllowed then
    act.Execute;
  Result := editAllowed and pFormOked^;
  if Result and (pMode = 1) then
    cds.Locate(fid,cdsEd[fid],[]);
end;

procedure TdmProducts.dspProductBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('PRODUCT_ID').NewValue < 0) then
     begin
       with cdsProduct_Edit do begin
         Edit;
         FieldByName('PRODUCT_ID').AsInteger := dmMain.GetNextPK;
         Post;
         DeltaDS.FieldByName('PRODUCT_ID').NewValue :=
           FieldByName('PRODUCT_ID').AsInteger;
       end;
     end
end;

procedure TdmProducts.DataModuleCreate(Sender: TObject);
begin
  cdsProduct.OnReconcileError      := dmMain.cdsGenReconcileError;
  cdsProduct_Edit.OnReconcileError := dmMain.cdsGenReconcileError;
  cdsProduct.OnReconcileError      := dmMain.cdsGenReconcileError;
  OpenProductsCds;
end;

procedure TdmProducts.actShowProductMgrExecute(Sender: TObject);
begin
  if not Assigned(fmProductMgr) then
    fmProductMgr := TfmProductMgr.Create(nil,'PRODUCT_NAME','PRODUCT_ID;PRODUCT_NAME');
  fmProductMgr.KeyBuffer := dmProducts.ProductKeyBuffer;
  fmProductMgr.ShowModal;
  dmProducts.ProductKeyBuffer := '';
  SelectedProduct := fmProductMgr.SelectedFieldValues;
end;

function TdmProducts.SelectProduct(const keybuffer: string): Variant;
begin
  Result := Unassigned;
  ProductKeyBuffer := keybuffer;
  actShowProductMgr.Execute;
  Result := SelectedProduct;
end;

procedure TdmProducts.DSPProdtypeGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  TableName := 'PRODUCT_TYPE';
end;

procedure TdmProducts.DSPProdtypeBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if (UpdateKind = ukInsert) and
     (DeltaDS.FieldByName('PRODUCT_TYPE_ID').NewValue < 0) then
     begin
       with CDSLkProdType do begin
         Edit;
         FieldByName('PRODUCT_TYPE_ID').AsInteger := dmMain.GetNextPK;
         Post;
         DeltaDS.FieldByName('PRODUCT_ID').NewValue :=
           FieldByName('PRODUCT_TYPE_ID').AsInteger;
       end;
     end
end;

end.
