object FVisaoCliente: TFVisaoCliente
  Left = 0
  Top = 0
  Caption = 'FVisaoCliente'
  ClientHeight = 441
  ClientWidth = 869
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 768
    Top = 400
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
  end
  object btn2: TButton
    Left = 680
    Top = 400
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 1
  end
  object dbgrd1: TDBGrid
    Left = 8
    Top = 8
    Width = 853
    Height = 289
    DataSource = ds1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ds1: TDataSource
    AutoEdit = False
    Left = 792
    Top = 312
  end
end
