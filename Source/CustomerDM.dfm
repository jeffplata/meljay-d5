�
 TDMCUSTOMER 0�  TPF0�TdmCustomer
dmCustomerOldCreateOrder	OnCreateDataModuleCreateLeft� Top~Height�Width� TActionListActionList1LeftTop TActionactShowCustomerMgrCaptionactShowCustomerMgr	OnExecuteactShowCustomerMgrExecute  TActionactShowCustomerEditCdsCaptionEdit Customer...	OnExecuteactShowCustomerEditCdsExecute  TActionactShowCustomerGroupMgrCaptionactShowCustomerGroupMgr  TActionactShowSalesRepMgrCaptionactShowSalesRepMgr	OnExecuteactShowSalesRepMgrExecute  TActionactShowSalesRepEditorCaptionactShowSalesRepEditor	OnExecuteactShowSalesRepEditorExecute  TActionactShowAddressMgrCaptionactShowAddressMgr   TClientDataSetcdsCust
Aggregates FilterOptionsfoCaseInsensitive Params ProviderNamedspCustBeforeClosecdsCustBeforeClose
BeforePostcdsCust_EditBeforePostOnNewRecordcdsCust_EditNewRecordLeftXTop�   TSQLDataSetsdsCustCommandTextselect *
from sel_clientMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left\Top  TDataSetProviderdspCustDataSetsdsCustOptionspoPropogateChanges OnUpdateDatadspCustUpdateDataBeforeUpdateRecorddspCustBeforeUpdateRecordOnGetTableNamedspCustGetTableNameLeft\TopP  
TfrxReport
frxReport1Version4.7.5DataSetfrxDBCustomerDataSetNamefrxDBCustomerDotMatrixReportIniFile\Software\Fast ReportsPreviewOptions.ButtonspbPrintpbLoadpbSavepbExportpbZoompbFind	pbOutlinepbPageSetuppbToolspbEditpbNavigatorpbExportQuick PreviewOptions.Zoom       ��?PrintOptions.PrinterDefaultPrintOptions.PrintOnSheet ReportOptions.CreateDate X��6�@ReportOptions.LastChange X��6�@ScriptLanguagePascalScriptScriptText.Stringsbegin end. 
StoreInDFMLeftXTop   TfrxDBDatasetfrxDBCustomerUserNamefrxDBCustomerCloseDataSource	DataSet
cdsCustRptLeft� Top   TSQLDataSet
sqlCustRptMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left� Top   TDataSetProvider
dspCustRptDataSet
sqlCustRptLeftTop   TClientDataSet
cdsCustRpt
Aggregates Params ProviderName
dspCustRptLeft@Top   TClientDataSetcdsClientTypeLkupActive	
Aggregates Params Left<TopData
Q   M   ��              M NAME I    WIDTH  2 VALUE I    WIDTH  2    TStringFieldcdsClientTypeLkupNAME	FieldNameNAMESize2  TStringFieldcdsClientTypeLkupVALUE	FieldNameVALUESize2   TDataSourcedsClientTypeDataSetcdsClientTypeLkupLeft<TopL  TClientDataSet	cdsSRLkup
Aggregates FilterOptionsfoCaseInsensitive Params ProviderName	dspSRlkupBeforeClosecdsSRLkupBeforeCloseOnNewRecordcdsSRLkupNewRecordLeft�Top�  TIntegerFieldcdsSRLkupCLIENT_IDDisplayLabelSRID	FieldName	CLIENT_IDProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TStringFieldcdsSRLkupCLIENT_NAMEDisplayLabelSR Name	FieldNameCLIENT_NAMERequired	Size(  TStringFieldcdsSRLkupADDRESS	FieldNameADDRESSSize(  TIntegerFieldcdsSRLkupTOWN_ID	FieldNameTOWN_IDVisible  TStringFieldcdsSRLkupPHONE	FieldNamePHONEVisibleSize<  TIntegerFieldcdsSRLkupAGENT_ID	FieldNameAGENT_IDVisible  TStringFieldcdsSRLkupCLIENT_TYPE	FieldNameCLIENT_TYPERequired	Visible	FixedChar	Size  TStringFieldcdsSRLkupTOWNPROVINCE	FieldNameTOWNPROVINCESizeQ  TStringFieldcdsSRLkupCOMPLETEADDRESS	FieldNameCOMPLETEADDRESSSizey   TSQLDataSet	sqlSRLkupCommandText1select *
from sel_client
where client_type='SR'MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left�Top  TDataSetProvider	dspSRLkupDataSet	sqlSRLkupOptionspoPropogateChanges OnUpdateDatadspCustUpdateDataBeforeUpdateRecorddspSRLkupBeforeUpdateRecordOnGetTableNamedspCustGetTableNameLeft�TopP  TDataSourcedsSRLkupDataSet	cdsSRLkupLeft�Top�   TSQLDataSetsqlTownLkupCommandTextJselect 
TOWN_ID,
TOWN,
PROVINCE,
town_province TOWNPROVINCE
FROM TOWNMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left�Top  TDataSetProviderdspTownLkupDataSetsqlTownLkupOptionspoPropogateChanges OnUpdateDatadspTownLkupUpdateDataBeforeUpdateRecorddspTownLkupBeforeUpdateRecordLeft�TopP  TClientDataSetcdsTownLkup
Aggregates FilterOptionsfoCaseInsensitive Params ProviderNamedspTownLkupBeforeClosecdsTownLkupBeforeClose
BeforePostcdsTownLkupBeforePostOnNewRecordcdsTownLkupNewRecordLeft�Top�  TIntegerFieldcdsTownLkupTOWN_ID	AlignmenttaLeftJustifyDisplayLabelID	FieldNameTOWN_IDProviderFlags
pfInUpdate	pfInWherepfInKey Required	Visible  TStringFieldcdsTownLkupTOWNDisplayLabelMunicipality	FieldNameTOWNVisible  TStringFieldcdsTownLkupPROVINCEDisplayLabelProvince	FieldNamePROVINCEVisible  TStringFieldcdsTownLkupTOWNPROVINCE	FieldNameTOWNPROVINCESizeQ   TSQLDataSetsqlProvincesCommandText6select distinct PROVINCE from  TOWN
group by PROVINCEMaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left<Top�   TDataSetProviderdspProvincesDataSetsqlProvincesLeft<Top�   TClientDataSetcdsProvinces
Aggregates Params ProviderNamedspProvincesLeft<Top�   TSQLDataSetsqldCollectorLkup
AfterClosecdsCust_EditBeforePostCommandText1select *
from sel_client
where client_type='CO'MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left� Top  TDataSetProviderdspCollectorLkupDataSetsqldCollectorLkupOptionspoPropogateChanges OnUpdateDatadspCollectorLkupUpdateDataBeforeUpdateRecord"dspCollectorLkupBeforeUpdateRecordOnGetTableNamedspCollectorLkupGetTableNameLeft� TopP  TClientDataSetcdsCollectorLkup
Aggregates FilterOptionsfoCaseInsensitive Params ProviderNamedspCollectorLkupBeforeClosecdsCollectorLkupBeforeCloseLeft� Top�  TIntegerFieldcdsCollectorLkupCLIENT_ID	FieldName	CLIENT_ID  TStringFieldcdsCollectorLkupCLIENT_NAME	FieldNameCLIENT_NAMESize(  TStringFieldcdsCollectorLkupSTREET_ADDRESS	FieldNameSTREET_ADDRESSSize(  TStringFieldcdsCollectorLkupADDRESS	FieldNameADDRESSSize(  TIntegerFieldcdsCollectorLkupTOWN_ID	FieldNameTOWN_ID  TStringFieldcdsCollectorLkupPHONE	FieldNamePHONESize<  TIntegerFieldcdsCollectorLkupAGENT_ID	FieldNameAGENT_ID  TStringFieldcdsCollectorLkupCLIENT_TYPE	FieldNameCLIENT_TYPE	FixedChar	Size  TStringFieldcdsCollectorLkupCOMPLETEADDRESS	FieldNameCOMPLETEADDRESSSizey  TStringFieldcdsCollectorLkupTOWNPROVINCE	FieldNameTOWNPROVINCESizeQ  TStringFieldcdsCollectorLkupCLIENTTYPEDESC	FieldNameCLIENTTYPEDESCSize(  TStringFieldcdsCollectorLkupAGENTNAME	FieldName	AGENTNAME    