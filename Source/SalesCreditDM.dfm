object dmSalesCredit: TdmSalesCredit
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 253
  Top = 113
  Height = 343
  Width = 549
  object sqlSalesCr: TSQLDataSet
    CommandText = 'select * from SEL_SALES_CREDIT(null,null,null)'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmMain.SQLConnection1
    Left = 80
    Top = 16
  end
  object dspSalesCr: TDataSetProvider
    DataSet = sqlSalesCr
    Options = [poCascadeDeletes, poCascadeUpdates, poAutoRefresh, poPropogateChanges]
    OnUpdateData = dspSalesCrUpdateData
    BeforeUpdateRecord = dspSalesCrBeforeUpdateRecord
    OnGetTableName = dspSalesCrGetTableName
    Left = 80
    Top = 68
  end
  object cdsSalesCr: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSalesCr'
    OnNewRecord = cdsSalesCr_EditNewRecord
    Left = 80
    Top = 120
    object cdsSalesCrSALES_CR_ID: TIntegerField
      DisplayLabel = 'SalesCrID'
      FieldName = 'SALES_CR_ID'
    end
    object cdsSalesCrSALES_CR_NUMBER: TStringField
      DisplayLabel = 'Number'
      FieldName = 'SALES_CR_NUMBER'
      Size = 15
    end
    object cdsSalesCrSALES_CR_DATE: TDateField
      DisplayLabel = 'Date'
      FieldName = 'SALES_CR_DATE'
    end
    object cdsSalesCrSALES_CR_AMOUNT: TFMTBCDField
      DisplayLabel = 'Amount'
      FieldName = 'SALES_CR_AMOUNT'
      currency = True
      Precision = 20
      Size = 2
    end
    object cdsSalesCrCLIENT_ID: TIntegerField
      DisplayLabel = 'ClientID'
      FieldName = 'CLIENT_ID'
    end
    object cdsSalesCrCLIENTNAME: TStringField
      DisplayLabel = 'Client Name'
      FieldName = 'CLIENTNAME'
      Size = 40
    end
  end
  object dsSalesCr: TDataSource
    DataSet = cdsSalesCr
    Left = 80
    Top = 176
  end
  object cdsSalesCrLines: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'SALES_CR_LINES_ID'
        DataType = ftInteger
      end
      item
        Name = 'SALES_CR_ID'
        DataType = ftInteger
      end
      item
        Name = 'PRODUCT_ID'
        DataType = ftInteger
      end
      item
        Name = 'PRODUCTNAME'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'QTY'
        DataType = ftFMTBcd
        Precision = 20
        Size = 2
      end
      item
        Name = 'SALES_DOC_NO'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'COST_UNIT'
        DataType = ftFMTBcd
        Precision = 20
        Size = 2
      end
      item
        Name = 'COST_TOTAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 2
      end
      item
        Name = 'PRICE_UNIT'
        DataType = ftFMTBcd
        Precision = 20
        Size = 2
      end
      item
        Name = 'PRICETOTAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'IndSALESID'
        Fields = 'SALES_CR_ID;SALES_DOC_NO'
        Options = [ixUnique]
        GroupingLevel = 1
      end>
    IndexName = 'IndSALESID'
    Params = <>
    ProviderName = 'dspSalesCrLines'
    StoreDefs = True
    BeforePost = cdsSalesCrLinesBeforePost
    AfterPost = cdsSalesCrLinesAfterPost
    AfterDelete = cdsSalesCrLinesAfterDelete
    OnNewRecord = cdsSalesCrLinesNewRecord
    OnPostError = cdsSalesCrLinesPostError
    Left = 196
    Top = 120
    object cdsSalesCrLinesSALES_CR_LINES_ID: TIntegerField
      FieldName = 'SALES_CR_LINES_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object cdsSalesCrLinesSALES_CR_ID: TIntegerField
      FieldName = 'SALES_CR_ID'
      Required = True
      Visible = False
    end
    object cdsSalesCrLinesSALES_DOC_NO: TStringField
      DisplayLabel = 'Doc Number'
      DisplayWidth = 10
      FieldName = 'SALES_DOC_NO'
      Size = 15
    end
    object cdsSalesCrLinesPRODUCT_ID: TIntegerField
      FieldName = 'PRODUCT_ID'
      Required = True
      Visible = False
    end
    object cdsSalesCrLinesPRODUCTNAME: TStringField
      DisplayLabel = 'Product'
      FieldName = 'PRODUCTNAME'
      Size = 40
    end
    object cdsSalesCrLinesQTY: TFMTBCDField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'QTY'
      Precision = 20
      Size = 10
    end
    object cdsSalesCrLinesPRICE_UNIT: TFMTBCDField
      DisplayLabel = 'Unit Price'
      DisplayWidth = 10
      FieldName = 'PRICE_UNIT'
      currency = True
      Precision = 20
      Size = 10
    end
    object cdsSalesCrLinesPRICETOTAL: TFMTBCDField
      DisplayLabel = 'Total Price'
      FieldName = 'PRICETOTAL'
      currency = True
      Precision = 20
      Size = 2
    end
    object cdsSalesCrLinesSumPriceTotal: TAggregateField
      FieldName = 'SumPriceTotal'
      Visible = True
      Active = True
      currency = True
      Expression = 'Sum(PriceTotal)'
      GroupingLevel = 1
      IndexName = 'IndSALESID'
    end
  end
  object sqlSalesCrLines: TSQLDataSet
    CommandText = 'select * from SEL_SALES_CREDIT_LINES'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmMain.SQLConnection1
    Left = 196
    Top = 16
  end
  object ActionList1: TActionList
    Left = 16
    Top = 16
    object actShowSalesCreditEdit: TAction
      Caption = 'actShowSalesCreditEdit'
      OnExecute = actShowSalesCreditEditExecute
    end
  end
  object sqlCollectibles: TSQLDataSet
    CommandText = 
      'select  '#13#10'  TXN_NUMBER'#13#10', TXN_DATE'#13#10', PRODUCT_ID '#13#10', QTYOUT'#13#10', P' +
      'RICE_UNIT'#13#10', PRICE_TOTAL'#13#10', CLIENT_ID'#13#10#13#10'from TXN_DETAIL b'#13#10'join' +
      ' TXN a on a.TXN_ID=b.TXN_ID'#13#10'where'#13#10'  txn_type_cid = '#39'INV'#39' and'#13#10 +
      '  (((txn_amount - txn_amountpaid - txn_downpayment) > 0)) '#13#10'orde' +
      'r by'#13#10'  client_id, txn_date, txn_number'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmMain.SQLConnection1
    Left = 300
    Top = 16
  end
  object dspCollectibles: TDataSetProvider
    DataSet = sqlCollectibles
    Left = 300
    Top = 64
  end
  object cdsCollectibles: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCollectibles'
    Left = 300
    Top = 120
    object cdsCollectiblesTXN_NUMBER: TStringField
      DisplayLabel = 'Inv Number'
      DisplayWidth = 10
      FieldName = 'TXN_NUMBER'
      Required = True
      Size = 15
    end
    object cdsCollectiblesTXN_DATE: TDateField
      DisplayLabel = 'Date'
      FieldName = 'TXN_DATE'
      Required = True
    end
    object cdsCollectiblesPRODUCT_ID: TIntegerField
      FieldName = 'PRODUCT_ID'
      Required = True
      Visible = False
    end
    object cdsCollectiblesQTYOUT: TFMTBCDField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'QTYOUT'
      Precision = 20
      Size = 2
    end
    object cdsCollectiblesPRICE_UNIT: TFMTBCDField
      DisplayLabel = 'Unit Price'
      DisplayWidth = 10
      FieldName = 'PRICE_UNIT'
      currency = True
      Precision = 20
      Size = 2
    end
    object cdsCollectiblesPRICE_TOTAL: TFMTBCDField
      DisplayLabel = 'Total Price'
      DisplayWidth = 10
      FieldName = 'PRICE_TOTAL'
      currency = True
      Precision = 20
      Size = 2
    end
    object cdsCollectiblesCLIENT_ID: TIntegerField
      FieldName = 'CLIENT_ID'
      Required = True
      Visible = False
    end
    object cdsCollectiblesProductDesc: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ProductDesc'
      LookupDataSet = dmProducts.cdsProduct_Lkup
      LookupKeyFields = 'PRODUCT_ID'
      LookupResultField = 'PRODUCT_NAME'
      KeyFields = 'PRODUCT_ID'
      Size = 40
      Lookup = True
    end
  end
  object dspSalesCrLines: TDataSetProvider
    DataSet = sqlSalesCrLines
    Options = [poAutoRefresh, poPropogateChanges]
    OnUpdateData = dspSalesCrLinesUpdateData
    BeforeUpdateRecord = dspSalesCrBeforeUpdateRecord
    OnGetTableName = dspSalesCrLinesGetTableName
    Left = 196
    Top = 68
  end
end
