object fmAboutBox: TfmAboutBox
  Left = 488
  Top = 261
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 208
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 341
    Height = 169
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General'
      DesignSize = (
        333
        141)
      object AppNameVersion: TLabel
        Left = 4
        Top = 24
        Width = 325
        Height = 13
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'AppNameVersion'
      end
      object AppCopyright: TLabel
        Left = 0
        Top = 56
        Width = 329
        Height = 13
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'AppCopyright'
      end
      object lblAuthorEmail: TLabel
        Left = 0
        Top = 72
        Width = 329
        Height = 13
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'jeffplata@yahoo.com'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dev'
      ImageIndex = 1
      DesignSize = (
        333
        141)
      object Memo1: TMemo
        Left = 3
        Top = 3
        Width = 327
        Height = 135
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 133
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object RzVersionInfo1: TRzVersionInfo
    Left = 16
    Top = 180
  end
end
