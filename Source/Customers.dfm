inherited lstCustomers: TlstCustomers
  Width = 658
  Caption = 'Customers'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TBDock1: TTBDock
    Width = 650
    Height = 139
    object TBToolbar1: TTBToolbar
      Left = 0
      Top = 26
      Caption = 'TBToolbar1'
      DockPos = 8
      DockRow = 3
      FullSize = True
      TabOrder = 1
      object TBControlItem15: TTBControlItem
        Control = PageControl1
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 593
        Height = 109
        ActivePage = TabSheet1
        TabOrder = 0
        TabStop = False
        object TabSheet1: TTabSheet
          Caption = 'Filter'
          object Label7: TLabel
            Left = 4
            Top = 4
            Width = 58
            Height = 13
            AutoSize = False
            Caption = 'Name'
          end
          object Label9: TLabel
            Left = 4
            Top = 28
            Width = 58
            Height = 13
            AutoSize = False
            Caption = 'Address'
          end
          object Label10: TLabel
            Left = 4
            Top = 52
            Width = 49
            Height = 13
            Caption = 'Sales Rep'
          end
          object sbClearName: TMyPngSpeedButton
            Left = 192
            Top = 4
            Width = 23
            Height = 22
            OnClick = sbClearNameClick
            MyNoCaptionOnRun = True
          end
          object sbClearAdd: TMyPngSpeedButton
            Left = 192
            Top = 28
            Width = 23
            Height = 22
            OnClick = sbClearNameClick
            MyNoCaptionOnRun = True
          end
          object sbClearSalesRep: TMyPngSpeedButton
            Left = 192
            Top = 52
            Width = 23
            Height = 22
            OnClick = sbClearNameClick
            MyNoCaptionOnRun = True
          end
          object sbApply: TMyPngSpeedButton
            Left = 484
            Top = 4
            Width = 97
            Height = 22
            Caption = 'Apply Filter'
            OnClick = sbApplyClick
            MyNoCaptionOnRun = False
          end
          object sbReset: TMyPngSpeedButton
            Left = 484
            Top = 28
            Width = 97
            Height = 22
            Caption = 'Reset Filter'
            OnClick = sbResetClick
            MyNoCaptionOnRun = False
          end
          object Label1: TLabel
            Left = 224
            Top = 52
            Width = 35
            Height = 13
            Caption = 'Results'
          end
          object RzEdit1: TRzEdit
            Left = 68
            Top = 4
            Width = 121
            Height = 21
            TabOrder = 0
            OnKeyPress = RzEdit1KeyPress
          end
          object RzEdit2: TRzEdit
            Left = 68
            Top = 28
            Width = 121
            Height = 21
            TabOrder = 1
            OnKeyPress = RzEdit1KeyPress
          end
          object RzButtonEdit1: TRzButtonEdit
            Left = 68
            Top = 52
            Width = 121
            Height = 21
            TabOrder = 2
            OnKeyPress = RzEdit1KeyPress
            AltBtnWidth = 15
            ButtonWidth = 15
          end
          object RzSpinEdit1: TRzSpinEdit
            Left = 268
            Top = 52
            Width = 69
            Height = 21
            Increment = 500.000000000000000000
            Max = 10000000.000000000000000000
            Min = 500.000000000000000000
            Value = 500.000000000000000000
            TabOrder = 3
            OnChange = RzSpinEdit1Change
          end
        end
      end
    end
  end
  inherited Panel1: TPanel
    Width = 650
    Caption = 'Customers'
  end
  inherited NextDBGrid: TMyNextDBGrid
    Top = 163
    Width = 650
    Height = 154
  end
  inherited ActionList1: TActionList
    object actFilter: TAction
      Caption = 'Apply Filter'
      OnExecute = actFilterExecute
    end
  end
end
