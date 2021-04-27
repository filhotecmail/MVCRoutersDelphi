object Form24: TForm24
  Left = 0
  Top = 0
  Caption = 'Form24'
  ClientHeight = 331
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Ubuntu'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object mmo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 859
    Height = 254
    Align = alTop
    BorderStyle = bsNone
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object btn4: TButton
    Left = 24
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cria Rota'
    TabOrder = 1
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 105
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Libera a rota'
    TabOrder = 2
    OnClick = btn5Click
  end
end
