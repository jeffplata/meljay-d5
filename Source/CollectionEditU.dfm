�
 TFMCOLLECTIONSEDIT 0�  TPF0�TfmCollectionsEditfmCollectionsEditLeft�Top{WidthkHeight�CaptionCollectionsConstraints.MinWidthkOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight � TLabelMessageLabelMessage1LeftTop�WidthKHeightAnchorsakLeftakBottom CaptionLabelMessage1Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontVisible  �TPageControlPageControl1WidthVHeightu �	TTabSheet	TabSheet1 TLabelLabel1LeftTopWidth7HeightCaptionCustomerFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TLabelLabel2LeftTop9Width:HeightCaption
Doc Number  TLabelLabel3LeftTopQWidthHeightCaptionDate  TLabelLabel5Left� TopQWidth5HeightCaptionDescription  TLabelLabel6LeftTopiWidth-HeightCaptionAmountFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TLabelLabel7Left� Top9Width-HeightCaptionPmt Type  TLabelLabel8Left� TopiWidth2HeightCaption
Unapplied Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsItalic 
ParentFont  TLabelLabel4Left�Top9Width2HeightCaption	Reference  TLabelLabel9LeftTop� Width*HeightCaption	CollectorFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFont  TDBEditDBEdit2LeftJTop9WidthyHeight	DataField
COL_NUMBER
DataSourceDataSource1TabOrder  TDBEditDBEdit4LeftJTopiWidthyHeight	DataField
COL_AMOUNT
DataSourceDataSource1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontTabOrder  TDBEditDBEdit6Left�Top9WidthoHeight	DataFieldPMT_REF
DataSourceDataSource1TabOrder  TDBEditDBEdit7Left"TopQWidthHeightConstraints.MinWidthy	DataFieldCOL_DESCRIPTION
DataSourceDataSource1TabOrder  TDBEditDBEdit8Left"TopiWidthkHeightTabStop	DataFieldUnappliedAmount
DataSourceDataSource1ReadOnly	TabOrder  TDBComboBoxDBComboBox1Left"Top9WidthkHeightStylecsDropDownList	DataFieldPMT_TYPE
DataSourceDataSource1
ItemHeightItems.StringsCashCheckOther TabOrder  TButtonbtnAddInvoicesLeftJTop2Width]HeightAnchorsakLeftakBottom CaptionSelect InvoicesTabOrder
OnClickbtnAddInvoicesClick  TButtonButton1Left� Top2Width]HeightAnchorsakLeftakBottom CaptionRemove InvoiceTabOrderOnClickButton1Click  TDBRadioGroupDBRadioGroup1Left"TopWidth� Height#CaptionRecord TypeColumns	DataFieldCOL_TYPE
DataSourceDataSource1Items.Strings
Cash/Check	AffidavitDiscount TabOrderValues.StringsCASAFFDIS   TNextDBGridNextDBGrid1LeftJTop� Width�Height� AnchorsakLeftakTopakRightakBottom OptionsgoHeadergoSecondClickEdit TabOrder	TabStop	
DataSourceDataSource2 TNxDBTextColumnNxDBTextColumn1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style Header.Caption
Inv NumberOptions
coCanClick
coCanInput	coCanSortcoPublicUsingcoShowTextFitHint 
ParentFontPosition SortTypestAlphabetic	FieldName
TXN_NUMBER  TNxDBTextColumnNxDBTextColumn2Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style Header.CaptionDateOptions
coCanClick
coCanInput	coCanSortcoPublicUsingcoShowTextFitHint 
ParentFontPositionSortTypestAlphabetic	FieldNameTXN_DATE  TNxDBNumberColumnNxDBTextColumn3DefaultValue0Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style Header.CaptionAmount CollectedOptions
coCanClick
coCanInput	coCanSort	coEditingcoEditorAutoSelectcoPublicUsingcoShowTextFitHint 
ParentFontPositionSortType	stNumeric	FieldNameCOL_DETAIL_AMTPAID
FormatMask,#0.00	Precision	Increment       ��?  TNxDBTextColumnNxDBTextColumn4DefaultWidth� Header.CaptionClient NameOptions
coCanClick
coCanInput	coCanSortcoPublicUsingcoShowTextFitHint PositionSortTypestAlphabeticWidth� 	FieldName
clientname   TRzDBButtonEditRzDBButtonEdit1LeftJTopWidth� Height
DataSourceDataSource1	DataField
ClientNameFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontTabOrder 
OnKeyPressRzDBButtonEdit1KeyPressOnKeyUpRzDBButtonEdit1KeyUpAltBtnWidthButtonWidthOnButtonClickRzDBButtonEdit1ButtonClick  TRzDBDateTimeEditRzDBDateTimeEdit1LeftJTopQWidthyHeight
DataSourceDataSource1	DataFieldCOL_DATETabOrderEditTypeetDate  TRzDBButtonEditRzDBButtonEdit2LeftJTop� Width� Height
DataSourceDataSource1	DataFieldCOLLECTORNAMETabOrder
OnKeyPressRzDBButtonEdit2KeyPressOnKeyUpRzDBButtonEdit2KeyUpAltBtnWidthButtonWidthOnButtonClickRzDBButtonEdit2ButtonClick    �TButtonbtnOkLeft�Top�  �TButton	btnCancelLeftTop�  TDataSourceDataSource2LeftdTop  TActionListActionList1Left Top�  TActionactCopyCellCaption	Copy CellShortCutC@	OnExecuteactCopyCellExecute    