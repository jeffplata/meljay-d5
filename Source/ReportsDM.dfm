�
 TDMREPORTS 0�  TPF0
TdmReports	dmReportsOldCreateOrderOnCreateDataModuleCreateLeft� Top� Height1Width 
TfrxReport
frxReport1Version4.7.5DataSetfrxDBDataset1DataSetNamefrxReportMasterDotMatrixReportIniFile\Software\Fast ReportsPreviewOptions.ButtonspbPrintpbLoadpbSavepbExportpbZoompbFind	pbOutlinepbPageSetuppbToolspbEditpbNavigatorpbExportQuick PreviewOptions.Zoom       ��?PrintOptions.PrinterDefaultPrintOptions.PrintOnSheet ReportOptions.CreateDate �$jh:a�@ReportOptions.LastChange `��4b�@ScriptLanguagePascalScriptScriptText.Strings begin end. 
StoreInDFMLeft!Top  TfrxDBDatasetfrxDBDataset1UserNamefrxReportMasterCloseDataSource	DataSetClientDataSet1Left_Top  TSQLDataSetSQLDataSet1CommandText�select
 TXN_NUMBER
, TXN_DATE
, TXN_DAYSDUE
, TXN_DUEDATE
, TXN_AMOUNT
, TXN_AMOUNTPAID
, T.CLIENT_ID
, (SELECT CLIENT_NAME  from CLIENT C
   where C.CLIENT_ID=T.CLIENT_ID) AS CLIENT_NAME
from TXN T
where (TXN_AMOUNT-TXN_AMOUNTPAID) > 0MaxBlobSize�Params SQLConnectiondmMain.SQLConnection1Left!TopK  TDataSetProviderDataSetProvider1DataSetSQLDataSet1OptionspoRetainServerOrder Left!Topw  TClientDataSetClientDataSet1
Aggregates Params ProviderNameDataSetProvider1Left!Top�   TfrxXLSExportfrxXLSExport1UseFileCache	ShowProgress	OverwritePrompt	ExportEMF	AsText
Background	
FastExport	
PageBreaks	
EmptyLines	SuppressPageHeadersFootersLeft� Top   