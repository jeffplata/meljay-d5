object statusFm: TstatusFm
  Left = 300
  Top = 263
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'statusFm'
  ClientHeight = 45
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 308
    Height = 45
    Align = alClient
    TabOrder = 0
    object label1: TPanel
      Left = 1
      Top = 1
      Width = 215
      Height = 43
      Align = alClient
      BevelOuter = bvNone
      Caption = 'label1'
      Color = clActiveBorder
      TabOrder = 0
    end
    object cancelpanel: TPanel
      Left = 216
      Top = 1
      Width = 91
      Height = 43
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel1'
      Color = clActiveBorder
      TabOrder = 1
      Visible = False
      object LMDButton1: TButton
        Left = 10
        Top = 8
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        TabOrder = 0
        OnClick = LMDButton1Click
      end
    end
  end
end
