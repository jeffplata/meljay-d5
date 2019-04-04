object dmTableID: TdmTableID
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 274
  Top = 207
  Height = 163
  Width = 265
  object UIBDataSet1: TUIBDataSet
    SQL.Strings = (
      'select * from HIGHGEN_GETALL')
    Left = 128
    Top = 20
  end
  object TableIDmt: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TBL_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'HIGH_VALUE'
        DataType = ftInteger
      end
      item
        Name = 'NEXT_HIGH_VALUE'
        DataType = ftInteger
      end
      item
        Name = 'LAST_LOW'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    StoreDefs = True
    Left = 40
    Top = 16
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = UIBDataSet1
    Left = 36
    Top = 76
  end
end
