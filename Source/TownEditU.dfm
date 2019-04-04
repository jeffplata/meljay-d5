inherited fmTownEdit: TfmTownEdit
  ActiveControl = DBEdit2
  Caption = 'Edit Town/City/Province'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Record ID'
      end
      object Label2: TLabel
        Left = 16
        Top = 44
        Width = 49
        Height = 13
        Caption = 'Town/City'
      end
      object Label3: TLabel
        Left = 16
        Top = 72
        Width = 41
        Height = 13
        Caption = 'Province'
      end
      object DBEdit1: TDBEdit
        Left = 88
        Top = 16
        Width = 205
        Height = 21
        TabStop = False
        DataField = 'TOWN_ID'
        DataSource = DataSource1
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 88
        Top = 44
        Width = 205
        Height = 21
        DataField = 'TOWN'
        DataSource = DataSource1
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 88
        Top = 72
        Width = 205
        Height = 21
        DataField = 'PROVINCE'
        DataSource = DataSource1
        TabOrder = 2
      end
    end
  end
end
