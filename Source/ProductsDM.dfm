�
 TDMPRODUCTS 0Z  TPF0TdmProducts
dmProductsOldCreateOrderOnCreateDataModuleCreate	OnDestroyDataModuleDestroyLeft?TopvHeight]WidthU TSQLDataSet
SQLProductCommandText^SELECT PRODUCT_ID
     , PRODUCT_NAME
     , PRODUCT_TYPE_ID
     , PRICE
FROM PRODUCT P
MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1LeftlTop  TDataSetProvider
dspProductDataSet
SQLProductOptionspoPropogateChanges BeforeUpdateRecorddspProductBeforeUpdateRecordOnGetTableNamedspProductGetTableNameLeftlTopH  TClientDataSet
cdsProduct
Aggregates FilterOptionsfoCaseInsensitive Params ProviderName
dspProduct
BeforeOpencdsProductBeforeOpenOnCalcFieldscdsProductCalcFieldsOnNewRecordcdsProductNewRecordLeftlTopx TIntegerFieldcdsProductPRODUCT_IDDisplayLabel	ProductID	FieldName
PRODUCT_IDRequired	  TStringFieldcdsProductPRODUCT_NAMEDisplayLabelDescription	FieldNamePRODUCT_NAMERequired	Size(  TIntegerFieldcdsProductPRODUCT_TYPE_IDDisplayLabelTypeIID	FieldNamePRODUCT_TYPE_IDRequired	Visible  TFMTBCDFieldcdsProductPRICE	FieldNamePRICEVisible	PrecisionSize  TStringFieldcdsProductProductType	FieldKindfkInternalCalc	FieldNameProductType   TSQLDataSetSQLdsProdTypeCommandText5select PRODUCT_TYPE_ID, TYPE_NAME 
from PRODUCT_TYPEMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left� Top  TDataSetProviderDSPProdtypeDataSetSQLdsProdTypeOptionspoPropogateChanges BeforeUpdateRecordDSPProdtypeBeforeUpdateRecordOnGetTableNameDSPProdtypeGetTableNameLeft� TopH  TClientDataSetCDSLkProdType
Aggregates Params ProviderNameDSPProdtypeLeft� Topx TIntegerFieldCDSLkProdTypePRODUCT_TYPE_IDDisplayLabelID	FieldNamePRODUCT_TYPE_IDProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TStringFieldCDSLkProdTypeTYPE_NAMEDisplayLabelType Description	FieldName	TYPE_NAMERequired	Size(   TActionListActionList1LeftTopx TActionactShowProductTypeMgrCaptionEdit Product Types	OnExecuteactShowProductTypeMgrExecute  TActionactShowProductEditCaptionEdit Product	OnExecuteactShowProductEditExecute  TActionactShowProductMgrCaptionactShowProductMgr	OnExecuteactShowProductMgrExecute   TClientDataSetcdsProduct_Edit
Aggregates Params ProviderName
dspProductOnNewRecordcdsProductNewRecordLeftlTop�  TIntegerFieldcdsProduct_EditPRODUCT_IDDisplayLabel	ProductID	FieldName
PRODUCT_IDRequired	  TStringFieldcdsProduct_EditPRODUCT_NAMEDisplayLabelDescription	FieldNamePRODUCT_NAMERequired	Size(  TIntegerFieldcdsProduct_EditPRODUCT_TYPE_IDDisplayLabelTypeIID	FieldNamePRODUCT_TYPE_IDRequired	Visible  TFMTBCDFieldcdsProduct_EditPRICE	FieldNamePRICEVisible	PrecisionSize  TStringFieldcdsProduct_EditProductType	FieldKindfkInternalCalc	FieldNameProductType   TClientDataSetcdsProduct_Lkup
Aggregates FilterOptionsfoCaseInsensitive Params ProviderName
dspProductLeftlTop�  TIntegerFieldIntegerField1DisplayLabel	ProductID	FieldName
PRODUCT_IDRequired	  TStringFieldStringField1DisplayLabelDescription	FieldNamePRODUCT_NAMERequired	Size(  TIntegerFieldIntegerField2DisplayLabelTypeIID	FieldNamePRODUCT_TYPE_IDRequired	Visible  TFMTBCDFieldcdsProduct_LkupPRICE	FieldNamePRICEVisible	PrecisionSize  TStringFieldStringField2	FieldKindfkInternalCalc	FieldNameProductType    