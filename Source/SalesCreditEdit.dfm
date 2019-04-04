inherited fmSalesCreditEdit: TfmSalesCreditEdit
  Left = 463
  Top = 166
  Width = 485
  Height = 385
  Caption = 'Edit Stock Withdrawal'
  Constraints.MinWidth = 477
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    Width = 464
    Height = 303
    inherited TabSheet1: TTabSheet
      object Label1: TLabel
        Left = 32
        Top = 40
        Width = 37
        Height = 13
        Caption = 'Number'
      end
      object Label2: TLabel
        Left = 160
        Top = 40
        Width = 23
        Height = 13
        Caption = 'Date'
      end
      object Label3: TLabel
        Left = 24
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Customer'
      end
      object Label4: TLabel
        Left = 296
        Top = 40
        Width = 37
        Height = 13
        Caption = 'Amount'
      end
      object DBGrid1: TDBGrid
        Left = 16
        Top = 64
        Width = 426
        Height = 169
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = DataSource2
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'SALES_DOC_NO'
            Title.Caption = 'Invoice'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRODUCTNAME'
            Title.Caption = 'Product'
            Width = 107
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QTY'
            Title.Caption = 'Qty'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRICE_UNIT'
            Title.Caption = 'Unit Price'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PriceTotal'
            Title.Caption = 'Price Total'
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sales_cr_id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sales_cr_lines_id'
            Visible = True
          end>
      end
      object DBEdit2: TDBEdit
        Left = 72
        Top = 36
        Width = 77
        Height = 21
        DataField = 'SALES_CR_NUMBER'
        DataSource = DataSource1
        TabOrder = 1
      end
      object DBEdit4: TDBEdit
        Left = 336
        Top = 36
        Width = 88
        Height = 21
        TabStop = False
        DataField = 'SALES_CR_AMOUNT'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object RzDBButtonEdit1: TRzDBButtonEdit
        Left = 72
        Top = 12
        Width = 213
        Height = 21
        DataSource = DataSource1
        DataField = 'ClientName'
        TabOrder = 0
        OnKeyPress = RzDBButtonEdit1KeyPress
        AltBtnWidth = 15
        ButtonWidth = 15
        OnButtonClick = RzDBButtonEdit1ButtonClick
      end
      object RzDBDateTimeEdit1: TRzDBDateTimeEdit
        Left = 188
        Top = 36
        Width = 97
        Height = 21
        DataSource = DataSource1
        DataField = 'SALES_CR_DATE'
        TabOrder = 2
        EditType = etDate
      end
      object btnSelect: TButton
        Left = 16
        Top = 236
        Width = 121
        Height = 21
        Caption = 'Select From Invoices'
        TabOrder = 4
        OnClick = btnSelectClick
      end
      object btnRemove: TButton
        Left = 140
        Top = 236
        Width = 57
        Height = 21
        Caption = 'Remove'
        TabOrder = 5
        OnClick = btnRemoveClick
      end
    end
  end
  inherited btnOk: TButton
    Left = 299
    Top = 317
  end
  inherited btnCancel: TButton
    Left = 379
    Top = 317
  end
  inherited DataSource1: TDataSource
    Top = 0
  end
  object DataSource2: TDataSource
    Left = 100
  end
end
