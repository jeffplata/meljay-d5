�
 TFMINVOICEEDITCDS 0`  TPF0�TfmInvoiceEditCDSfmInvoiceEditCDSLeftTop� WidthZHeight�CaptionInvoice EditOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight �TPageControlPageControl1WidthEHeightx �	TTabSheet	TabSheet1 TLabelLabel2LeftTopWidth.HeightCaptionCustomerFocusControlDBEdit2  TLabelLabel3LeftTopXWidth7HeightCaptionInvoice No.FocusControlDBEdit3  TLabelLabel4Left(Top(Width=HeightCaptionInvoice DateFocusControlDBEdit4  TPngSpeedButtonsbtCustomerLeft� TopWidthHeightCaption...OnClicksbtCustomerClick  TLabelLabel6Left(TopXWidth2HeightCaptionParticularsFocusControlDBEdit5  TLabelLabel8Left(Top@Width-HeightCaptionDue DateFocusControlDBComboBox1  TLabelLabel9LeftTop@Width/HeightCaption	Sales RepFocusControlDBEdit7  TDBTextDBText1Left�TopWidth=Height	AlignmenttaRightJustify	DataFieldTXN_ID
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFont  TLabelLabel1Left�TopDWidthHeightCaptiondaysFocusControl	btnCancel  TLabelLabel5LeftlTop� Width8HeightAnchorsakLeftakBottom Caption
Inv AmountFocusControl	btnCancel  TLabelLabel7LeftlTopWidth?HeightAnchorsakLeftakBottom CaptionAdvance PmtFocusControlDBEdit8  TLabelLabel10LeftlTop@Width%HeightAnchorsakLeftakBottom CaptionBalanceFocusControl	btnCancel  TLabelLabel11LeftlTop(Width,HeightAnchorsakLeftakBottom Caption	CollectedFocusControl	btnCancel  TLabelLabel12Left(TopWidthHeightCaptionPeriodFocusControlDBEdit11  TLabelLabel13LeftTop(Width'HeightCaptionAddressFocusControlDBEdit12  TPngSpeedButton
sbtAddressLeft� Top(WidthHeightCaption...OnClicksbtCustomerClick  TPngSpeedButtonsbtSalesRepLeft� Top@WidthHeightCaption...OnClicksbtCustomerClick  TDBEditDBEdit2LeftTTopWidthyHeight	DataField
ClientName
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontReadOnly	TabOrder 
OnKeyPressDBEdit2KeyPressOnKeyUpDBEdit2KeyUp  TDBEditDBEdit3LeftTTopXWidthyHeight	DataField
TXN_NUMBER
DataSourceDataSource1TabOrder  TDBEditDBEdit4LefthTop(WidtheHeight	DataFieldTXN_DATE
DataSourceDataSource1TabOrderOnChangeDBEdit4Change  TDBEditDBEdit6Left�Top@WidtheHeight	DataFieldTXN_DUEDATE
DataSourceDataSource1TabOrderOnChangeDBEdit4Change  TDBEditDBEdit5LefthTopXWidth� Height	DataFieldTXN_PARTICULARS
DataSourceDataSource1TabOrder  TDBEditDBEdit7LeftTTop@WidthyHeight	DataField	AgentName
DataSourceDataSource1ReadOnly	TabOrder
OnKeyPressDBEdit2KeyPressOnKeyUpDBEdit2KeyUp  TDBComboBoxDBComboBox1LefthTop@Width-Height	DataFieldTXN_DAYSDUE
DataSourceDataSource1
ItemHeightItems.Strings306090120 TabOrderOnExitDBComboBox1Exit  TDateTimePickerDateTimePicker1Left�Top(WidthHeightCalAlignmentdtaRightDate �2�T�@Time �2�T�@TabOrder	TabStop	OnCloseUpDateTimePicker1CloseUp  TDateTimePickerDateTimePicker2LeftTop@WidthHeightCalAlignmentdtaRightDate �2�T�@Time �2�T�@TabOrder
TabStop	OnCloseUpDateTimePicker1CloseUp  TButton
btnAddItemLeftTop� WidthKHeightAnchorsakLeftakBottom CaptionAdd itemTabOrderOnClickbtnAddItemClick  TButtonbtnRemoveItemLeft\Top� WidthKHeightAnchorsakLeftakBottom CaptionRemove itemTabOrderOnClickbtnRemoveItemClick  TDBEditDBEdit1Left�Top� WidthyHeightTabStopAnchorsakLeftakBottom 	DataField
TXN_AMOUNT
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontReadOnly	TabOrder  TDBEditDBEdit8Left�TopWidthyHeightAnchorsakLeftakBottom BiDiModebdLeftToRight	DataFieldTXN_DOWNPAYMENT
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold ParentBiDiMode
ParentFontTabOrder  TDBEditDBEdit9Left�Top%WidthyHeightTabStopAnchorsakLeftakBottom 	DataFieldSalesCredit
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontReadOnly	TabOrder  TDBEditDBEdit10Left�Top=WidthyHeightTabStopAnchorsakLeftakBottom 	DataFieldBalance
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontReadOnly	TabOrder  TDBEditDBEdit11LefthTopWidthyHeight	DataField
TXN_PERIOD
DataSourceDataSource1TabOrder  TDBEditDBEdit12LeftTTop(WidthyHeight	DataFieldTownProvince
DataSourceDataSource1ReadOnly	TabOrder
OnKeyPressDBEdit2KeyPressOnKeyUpDBEdit2KeyUp  TButtonbtnCopyLastItemLeftTopWidthUHeightAnchorsakLeftakBottom CaptionCopy Last ItemTabOrderOnClickbtnCopyLastItemClick  TDBGridDBGrid1LeftToppWidthHeight� 
DataSourceDataSource2TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameTahomaTitleFont.Style 
OnKeyPressDBGrid1KeyPressOnKeyUpDBGrid1KeyUpColumnsExpanded	FieldName
PRODUCT_IDWidth2Visible	 Expanded	FieldNamePRODUCTNAMEWidth}Visible	 Expanded	FieldNameQTYOUTWidth2Visible	 Expanded	FieldName
PRICE_UNITWidthKVisible	 Expanded	FieldName
PRICETOTALWidthKVisible	      �TButtonbtnOkLeft�Top�  �TButton	btnCancelLeft�Top�  �TDataSourceDataSource1LeftLTop  TDataSourceDataSource2DataSetdmInvoice.cdsInv2LeftpTop   