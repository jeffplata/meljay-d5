�
 TDMINVOICE 0<  TPF0
TdmInvoice	dmInvoiceOldCreateOrderOnCreateDataModuleCreateLeft� Top� HeightQWidth TClientDataSetcdsInv
Aggregates AggregatesActive	Params ProviderNamedspInv
BeforePostcdsInv_EditBeforePostOnNewRecordcdsInv_EditNewRecordOnPostErrorcdsInv_EditPostErrorLefthTop| TIntegerFieldcdsInvTXN_ID	FieldNameTXN_ID  TStringFieldcdsInvTXN_NUMBER	FieldName
TXN_NUMBERSize  
TDateFieldcdsInvTXN_DATE	FieldNameTXN_DATE  TStringFieldcdsInvTXN_PERIOD	FieldName
TXN_PERIODSize
  TSmallintFieldcdsInvTXN_DAYSDUE	FieldNameTXN_DAYSDUE  
TDateFieldcdsInvTXN_DUEDATE	FieldNameTXN_DUEDATE  TFMTBCDFieldcdsInvTXN_AMOUNT	FieldName
TXN_AMOUNTDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInvTXN_DOWNPAYMENT	FieldNameTXN_DOWNPAYMENTDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInvTXN_AMOUNTPAID	FieldNameTXN_AMOUNTPAIDDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInvSALESCREDIT	FieldNameSALESCREDITDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInvBALANCE	FieldNameBALANCEDisplayFormat,#0.00	PrecisionSize  TStringFieldcdsInvTXN_PARTICULARS	FieldNameTXN_PARTICULARSSize�   TStringFieldcdsInvTXN_TYPE_CID	FieldNameTXN_TYPE_CIDSize  TIntegerFieldcdsInvCLIENT_ID	FieldName	CLIENT_ID  TIntegerFieldcdsInvAGENT_ID	FieldNameAGENT_ID  TIntegerFieldcdsInvTOWN_ID	FieldNameTOWN_ID  TStringFieldcdsInvCLIENTNAME	FieldName
CLIENTNAMESize(  TStringFieldcdsInvAGENTNAME	FieldName	AGENTNAMESize(  TStringFieldcdsInvTOWNPROVINCE	FieldNameTOWNPROVINCESizeR  TAggregateFieldcdsInvSumInvoiceAmount	FieldNameSumInvoiceAmountVisible	Active	currency	
ExpressionSum(txn_amount)  TAggregateFieldcdsInvSumDownPayment	FieldName
SumBalanceVisible	Active	
ExpressionSum(Balance)   TDataSetProviderdspInvDataSet
sqlInvoiceOptionspoCascadeDeletespoCascadeUpdatespoAutoRefreshpoPropogateChanges OnUpdateDatadspInvUpdateDataBeforeUpdateRecorddspInvBeforeUpdateRecordOnGetTableNamedspInvGetTableNameLefthTopL  TDataSource	dsInvoiceDataSetcdsInvLefthTop�   TActionListActionList1Left Top TActionactShowInvoiceEditCaptionactShowInvoiceEdit	OnExecuteactShowInvoiceEditExecute  TActionactShowCollectionEditCaptionactShowCollectionEdit	OnExecuteactShowCollectionEditExecute  TActionactShowProductMgrCaptionactShowProductMgr  TActionactShowCustomerMgrCaption	Customers   TSQLDataSetSQLColCommandTextBselect * 
from sel_collection(null,null,null,null,null,null,null)MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1LeftTop TStringFieldSQLColCLIENTNAME	FieldName
CLIENTNAMEProviderFlags Size(  TFMTBCDFieldSQLColUNAPPLIEDAMOUNT	FieldNameUNAPPLIEDAMOUNTProviderFlags 	PrecisionSize   TIntegerFieldSQLColCOL_ID	FieldNameCOL_ID  TStringFieldSQLColCOL_NUMBER	FieldName
COL_NUMBERSize  
TDateFieldSQLColCOL_DATE	FieldNameCOL_DATE  TStringFieldSQLColCOL_TYPE	FieldNameCOL_TYPE	FixedChar	Size  TStringFieldSQLColCOL_REF	FieldNameCOL_REFSize  TFMTBCDFieldSQLColCOL_AMOUNT	FieldName
COL_AMOUNT	PrecisionSize  TFMTBCDFieldSQLColCOL_AMOUNTAPPLIED	FieldNameCOL_AMOUNTAPPLIED	PrecisionSize  TStringFieldSQLColCOL_DESCRIPTION	FieldNameCOL_DESCRIPTIONSize2  TIntegerFieldSQLColCLIENT_ID	FieldName	CLIENT_ID  TIntegerFieldSQLColAGENT_ID	FieldNameAGENT_ID  TStringFieldSQLColPMT_REF	FieldNamePMT_REFSize  TStringFieldSQLColPMT_TYPE	FieldNamePMT_TYPESize  TIntegerFieldSQLColCOLLECTOR_ID	FieldNameCOLLECTOR_ID  TStringFieldSQLColCOLLECTORNAME	FieldNameCOLLECTORNAMESize(   TDataSetProviderdspColDataSetSQLColOptionspoCascadeDeletespoCascadeUpdatespoPropogateChanges OnUpdateDatadspColUpdateDataBeforeUpdateRecorddspColBeforeUpdateRecordOnGetTableNamedspColGetTableNameLeftTopH  TClientDataSetcdsCol
Aggregates AggregatesActive	Params ProviderNamedspCol
BeforePostcdsCol_EditBeforePostOnNewRecordcdsCol_EditNewRecordLeftTop| TIntegerFieldcdsColCOL_ID	FieldNameCOL_IDRequired	Visible  TStringFieldcdsColCOL_TYPEDisplayLabelType	FieldNameCOL_TYPERequired		FixedChar	Size  TStringFieldcdsColCOL_NUMBERDisplayLabelNumber	FieldName
COL_NUMBERRequired	Size  
TDateFieldcdsColCOL_DATEDisplayLabelDate	FieldNameCOL_DATERequired	  TFMTBCDFieldcdsColCOL_AMOUNT	AlignmenttaLeftJustifyDisplayLabelAmount	FieldName
COL_AMOUNTRequired	DisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsColCOL_AMOUNTAPPLIEDDisplayLabelApplied	FieldNameCOL_AMOUNTAPPLIEDDisplayFormat,#0.00	PrecisionSize  TStringFieldcdsColCOL_DESCRIPTIONDisplayLabelDescription	FieldNameCOL_DESCRIPTIONSize2  TStringFieldcdsColPMT_REF	FieldNamePMT_REFSize  TIntegerFieldcdsColCLIENT_ID	FieldName	CLIENT_IDProviderFlags
pfInUpdate	pfInWherepfInKey Required	Visible  TIntegerFieldcdsColAGENT_ID	FieldNameAGENT_IDRequired	  TStringFieldcdsColPMT_TYPE	FieldNamePMT_TYPESize  TFloatFieldcdsColCOL_UNAPPLIEDAMTDisplayLabel	Unapplied	FieldKindfkCalculated	FieldNameCOL_UNAPPLIEDAMTDisplayFormat,#0.00;(,#0.00); 
Calculated	  TStringFieldcdsColClientNameDisplayLabelCustomerDisplayWidth(	FieldKindfkInternalCalc	FieldName
ClientNameSize(  TFMTBCDFieldcdsColUNAPPLIEDAMOUNTDisplayLabelUnapplied Amt	FieldNameUNAPPLIEDAMOUNTDisplayFormat#,##0.00	PrecisionSize   TIntegerFieldcdsColCOLLECTOR_ID	FieldNameCOLLECTOR_ID  TStringFieldcdsColCOLLECTORNAME	FieldNameCOLLECTORNAMESize(  TAggregateFieldcdsColSumAmount	FieldName	SumAmountVisible	Active	
ExpressionSum(COL_AMOUNT)  TAggregateFieldcdsColSumUnApplied	FieldNameSumUnAppliedVisible	Active	
ExpressionSum(UNAPPLIEDAMOUNT)   TPngImageListPngImageList1	PngImagesPngImage.Data
�  �PNG

   IHDR         ��a   *tEXtCreation Time Di 4 Mrz 2003 19:18:05 +0100�zh+   tIME       	s�.   	pHYs    ��~�  [IDATxڭ�mHSQ��ww[�ج�#�(4�-��2��(KF�jH�jH&�MS��0?e�(Bk,�����Y	�λ������rC?hu��y{�?�y�y(�c��8��?�RA �
��Ҋ�e�-���R����
�PK����Q"�(L�0��c�i���� w'��~K�Z���u;��S�� �֐�(Q�(�kZ���ub�9.�A,�Q���O@d�q,6�'Qxz5ǚd�`�"	��^c<O��6��v��~�R4H�j�"-�d.�ɏ���B�1�%�2��B�����6�ќ�}�?��!�KJFIbB���
����fT�� �m�;�h߶�ܝ�7���+����	�K��~x}��^�Gu8a��&t�Z_RSP٭h�����_2@`�~�Ĥ &��ˮ��+QA����u/��Z�p蒍$�1� sc���'`�y����0p+Ŧ��j������I��"�f�3�wlӓ���dS�gԚ�]��$m2�@/1%�LEȽC����P2@^r�x.Zή|��xO�U�'�߾���~J�1bX	˞����bzw����؈U�D "'�q��U�R�70u $�$    IEND�B`�Name	PngImage0
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Di 11 Okt 2005 12:16:46 +0100���   tIME       	s�.   	pHYs    ��~�  MIDATxڥ�O�q��8��h���^��K��aeݔۊ'ل�j������K�ăе�F��."i폐冉e�kH���?���hJ��V���7|?�7��~�g�}L$�f�yS�R}�V���`�!�f���xw( �L��<��b���~�0j��:T*�;N��ʁ�T*5[(26�mVE�;!�3�����g� �HD�����v+I�C�$��br�\��r�S��������W�ZArs�[�F��l����;�|Y�8���t�`Yt:��PTC����\.C�պ��x�M �`� �מ�,�3�6J�k��	 �?�5C�;~���d
���QT�0��	b$�5d2��4�L�{�E�
����<�݉��E�R9%���NO�>X�t�|0�vk�"mn���&n�/�/o��Ow�N?�����ss�J(�H�u��J�Fu��M��T����2��E�]��6G���N�r0�����!4���+M����P����ڍ�B(�c���^츊u'I��3����TJ�t4z���Ǵ����(�VIRvN�М�(���W.�b��~�? Cc* Ԓ    IEND�B`�Name	PngImage1
BackgroundclWindow  Left TopLBitmap
      TSQLDataSet	SQLUnpaidCommandText!SELECT * FROM SEL_UNPAID_INVOICESMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left�Top  TDataSetProvider	dspUnpaidDataSet	SQLUnpaidOnUpdateDatadspUnpaidUpdateDataLeft�TopH  TClientDataSet	cdsUnpaid
Aggregates Params ProviderName	dspUnpaidReadOnly	BeforeInsertcdsUnpaidBeforeInsert	AfterPostcdsUnpaidAfterPostOnCalcFieldscdsUnpaidCalcFieldsLeft�Top| TStringFieldcdsUnpaidTXN_NUMBERDisplayLabelNumber	FieldName
TXN_NUMBERRequired	Size  TStringFieldcdsUnpaidTXN_TYPE_CIDDisplayLabelType	FieldNameTXN_TYPE_CIDRequired	Size  
TDateFieldcdsUnpaidTXN_DATEDisplayLabelDate	FieldNameTXN_DATERequired	  TFMTBCDFieldcdsUnpaidTXN_AMOUNTDisplayLabelAmount	FieldName
TXN_AMOUNTRequired	DisplayFormat,#0.00 	PrecisionSize  TFMTBCDFieldcdsUnpaidTXN_AMOUNTPAIDDisplayLabelPaid	FieldNameTXN_AMOUNTPAIDRequired	DisplayFormat,#0.00 	PrecisionSize  TIntegerFieldcdsUnpaidCLIENT_ID	FieldName	CLIENT_IDRequired	  TIntegerFieldcdsUnpaidAGENT_ID	FieldNameAGENT_IDRequired	  TFloatFieldcdsUnpaidUnpaidAmountDisplayLabelBalance	FieldKindfkCalculated	FieldNameUnpaidAmountDisplayFormat,#0.00 
Calculated	  TFloatFieldcdsUnpaidAmountAppliedDisplayLabelAmount Applied	FieldKindfkInternalCalc	FieldNameAmountAppliedDisplayFormat,#0.00
EditFormat#,##0.00   TSQLDataSetSQLCol2CommandText#select * from sel_collection_detailMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1LeftLTop  TClientDataSetcdsCol2
Aggregates 	FieldDefsNameCOL_DETAIL_IDDataType	ftInteger NameCOL_IDDataType	ftInteger Name
TXN_NUMBERDataTypeftStringSize NameTXN_DATEDataTypeftDate NameCOL_DETAIL_AMTPAIDDataTypeftFMTBcd	PrecisionSize NameAFFIDAVIT_AMTDataTypeftFMTBcd	PrecisionSize NameDISCOUNTDataTypeftFMTBcd	PrecisionSize Name
CLIENTNAMEDataTypeftStringSize(  	IndexDefsNameCollectionInvNoFieldsCOL_ID;TXN_NUMBEROptionsixUnique GroupingLevel  	IndexNameCollectionInvNoParams ProviderNamedspCol2	StoreDefs		AfterPostcdsCol2_EditAfterPostAfterDeletecdsCol2_EditAfterPostOnNewRecordcdsCol2_EditNewRecordOnPostErrorcdsCol2_EditPostErrorLeftHTopx TIntegerFieldcdsCol2COL_DETAIL_ID	FieldNameCOL_DETAIL_IDProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TIntegerFieldcdsCol2COL_ID	FieldNameCOL_IDRequired	  TStringFieldcdsCol2TXN_NUMBERDisplayLabelNumber	FieldName
TXN_NUMBERRequired	Size  
TDateFieldcdsCol2TXN_DATEDisplayLabelDate	FieldNameTXN_DATE  TFMTBCDFieldcdsCol2COL_DETAIL_AMTPAIDDisplayLabelAmount Paid	FieldNameCOL_DETAIL_AMTPAIDDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsCol2AFFIDAVIT_AMTDisplayLabel	Affidavit	FieldNameAFFIDAVIT_AMT	PrecisionSize  TFMTBCDFieldcdsCol2DISCOUNTDisplayLabelDiscount	FieldNameDISCOUNT	PrecisionSize  TStringFieldcdsCol2CLIENTNAMEDisplayLabelClient Name	FieldName
CLIENTNAMESize(  TAggregateFieldcdsCol2SumAmtPaid	FieldName
SumAmtPaidVisible	Active	
ExpressionSum(COL_DETAIL_AMTPAID)GroupingLevel	IndexNameCollectionInvNo   TDataSetProviderdspCol2DataSetSQLCol2OptionspoPropogateChanges OnUpdateDatadspCol2UpdateDataBeforeUpdateRecorddspColBeforeUpdateRecordOnGetTableNamedspColGetTableNameLeftLTopH  TDataSourcedsColDataSetcdsColLeftTop�   TSQLDataSet
sqlInvoice
NoMetadata	CommandText=select * from sel_invoice(null,null,null,null,null,null,null)MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1LeftlTop TIntegerFieldsqlInvoiceTXN_ID	FieldNameTXN_ID  TStringFieldsqlInvoiceTXN_NUMBER	FieldName
TXN_NUMBERSize  
TDateFieldsqlInvoiceTXN_DATE	FieldNameTXN_DATE  TStringFieldsqlInvoiceTXN_PERIOD	FieldName
TXN_PERIODSize
  TSmallintFieldsqlInvoiceTXN_DAYSDUE	FieldNameTXN_DAYSDUE  
TDateFieldsqlInvoiceTXN_DUEDATE	FieldNameTXN_DUEDATE  TFMTBCDFieldsqlInvoiceTXN_AMOUNT	FieldName
TXN_AMOUNT	PrecisionSize  TFMTBCDFieldsqlInvoiceTXN_DOWNPAYMENT	FieldNameTXN_DOWNPAYMENT	PrecisionSize  TFMTBCDFieldsqlInvoiceTXN_AMOUNTPAID	FieldNameTXN_AMOUNTPAID	PrecisionSize  TFMTBCDFieldsqlInvoiceSALESCREDIT	FieldNameSALESCREDIT	PrecisionSize  TStringFieldsqlInvoiceTXN_PARTICULARS	FieldNameTXN_PARTICULARSSize�   TStringFieldsqlInvoiceTXN_TYPE_CID	FieldNameTXN_TYPE_CIDSize  TIntegerFieldsqlInvoiceCLIENT_ID	FieldName	CLIENT_ID  TIntegerFieldsqlInvoiceAGENT_ID	FieldNameAGENT_ID  TIntegerFieldsqlInvoiceTOWN_ID	FieldNameTOWN_ID  TStringFieldsqlInvoiceCLIENTNAME	FieldName
CLIENTNAMESize(  TStringFieldsqlInvoiceAGENTNAME	FieldName	AGENTNAMESize(  TStringFieldsqlInvoiceTOWNPROVINCE	FieldNameTOWNPROVINCESizeR  TFMTBCDFieldsqlInvoiceBALANCE	FieldNameBALANCE	PrecisionSize   TSQLDataSetsqlInvoiceLineCommandText!SELECT *
FROM SEL_INVOICE_DETAILMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left� Top TIntegerFieldsqlInvoiceLineTXN_DETAIL_ID	FieldNameTXN_DETAIL_ID  TIntegerFieldsqlInvoiceLineTXN_ID	FieldNameTXN_ID  TIntegerFieldsqlInvoiceLinePRODUCT_ID	FieldName
PRODUCT_ID  TStringFieldsqlInvoiceLinePRODUCTNAME	FieldNamePRODUCTNAMESize(  TFMTBCDFieldsqlInvoiceLineQTYIN	FieldNameQTYIN	PrecisionSize  TFMTBCDFieldsqlInvoiceLineQTYOUT	FieldNameQTYOUT	PrecisionSize  TFMTBCDFieldsqlInvoiceLineCOST_UNIT	FieldName	COST_UNIT	PrecisionSize  TFMTBCDFieldsqlInvoiceLineCOST_TOTAL	FieldName
COST_TOTAL	PrecisionSize  TFMTBCDFieldsqlInvoiceLinePRICE_UNIT	FieldName
PRICE_UNIT	PrecisionSize  TFMTBCDFieldsqlInvoiceLinePRICETOTAL	FieldName
PRICETOTAL	PrecisionSize   TDataSetProviderdspInvoiceLineDataSetsqlInvoiceLineOptionspoPropogateChanges OnUpdateDatadspInvoiceLineUpdateDataBeforeUpdateRecorddspInvBeforeUpdateRecordOnGetTableNamedspInvGetTableNameLeft� TopL  TClientDataSetcdsInv2
Aggregates 	FieldDefsNameTXN_DETAIL_IDDataType	ftInteger NameTXN_IDDataType	ftInteger Name
PRODUCT_IDDataType	ftInteger NamePRODUCTNAMEDataTypeftStringSize( NameQTYINDataTypeftFMTBcd	PrecisionSize NameQTYOUTDataTypeftFMTBcd	PrecisionSize Name	COST_UNITDataTypeftFMTBcd	PrecisionSize Name
COST_TOTALDataTypeftFMTBcd	PrecisionSize Name
PRICE_UNITDataTypeftFMTBcd	PrecisionSize Name
PRICETOTALDataTypeftFMTBcd	PrecisionSize  	IndexDefsNameTxnTxnDetailFieldsTXN_ID;TXN_DETAIL_IDGroupingLevel  	IndexNameTxnTxnDetailParams ProviderNamedspInvoiceLine	StoreDefs	
BeforePostcdsInv2BeforePost	AfterPostcdsInv2_EditAfterPostAfterDeletecdsInv2_EditAfterDeleteOnNewRecordcdsInv2_EditNewRecordLeft� Top| TIntegerFieldcdsInv2TXN_DETAIL_ID	FieldNameTXN_DETAIL_ID  TIntegerFieldcdsInv2TXN_ID	FieldNameTXN_ID  TIntegerFieldcdsInv2PRODUCT_IDDisplayLabelProdID	FieldName
PRODUCT_ID  TStringFieldcdsInv2PRODUCTNAMEDisplayLabelProduct Name	FieldNamePRODUCTNAMESize(  TFMTBCDFieldcdsInv2QTYIN	FieldNameQTYIN	PrecisionSize  TFMTBCDFieldcdsInv2QTYOUTDisplayLabelQty	FieldNameQTYOUT	PrecisionSize  TFMTBCDFieldcdsInv2COST_UNIT	FieldName	COST_UNITDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInv2COST_TOTAL	FieldName
COST_TOTALDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInv2PRICE_UNITDisplayLabel
Unit Price	FieldName
PRICE_UNITDisplayFormat,#0.00	PrecisionSize  TFMTBCDFieldcdsInv2PRICETOTALDisplayLabelTotal Price	FieldName
PRICETOTALDisplayFormat,#0.00	PrecisionSize  TAggregateFieldcdsInv2SumPriceTotal	FieldNameSumPriceTotalVisible	Active	currency	
ExpressionSum(PriceTotal)GroupingLevel	IndexNameTxnTxnDetail    