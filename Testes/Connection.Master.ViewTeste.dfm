object Form24: TForm24
  Left = 0
  Top = 0
  Caption = 'Form24'
  ClientHeight = 475
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Ubuntu'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
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
  object btn1: TButton
    Left = 775
    Top = 432
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object Edit1: TEdit
    Left = 608
    Top = 432
    Width = 161
    Height = 24
    TabOrder = 2
    Text = 'fb3'
  end
  object grp1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 263
    Width = 558
    Height = 209
    Align = alLeft
    Caption = 'grp1'
    TabOrder = 3
    object lbl1: TLabel
      Left = 21
      Top = 28
      Width = 88
      Height = 16
      Caption = 'Nome da conex'#227'o'
    end
    object lbl2: TLabel
      Left = 263
      Top = 28
      Width = 68
      Height = 16
      Caption = 'Ip de conex'#227'o'
    end
    object lbl3: TLabel
      Left = 21
      Top = 84
      Width = 28
      Height = 16
      Caption = 'Porta'
    end
    object lbl4: TLabel
      Left = 21
      Top = 140
      Width = 88
      Height = 16
      Caption = 'Nome da conex'#227'o'
    end
    object EdConectionName: TEdit
      Left = 21
      Top = 50
      Width = 236
      Height = 24
      TabOrder = 0
      Text = 'fb3'
    end
    object EdIp: TEdit
      Left = 263
      Top = 50
      Width = 282
      Height = 24
      TabOrder = 1
      Text = 'fb3'
    end
    object EdPorta: TEdit
      Left = 21
      Top = 106
      Width = 116
      Height = 24
      TabOrder = 2
      Text = 'fb3'
    end
    object btn2: TButton
      Left = 143
      Top = 105
      Width = 75
      Height = 25
      Caption = 'btn1'
      TabOrder = 3
      OnClick = btn2Click
    end
    object btn3: TButton
      Left = 263
      Top = 161
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 4
      OnClick = btn3Click
    end
    object Edit2: TEdit
      Left = 21
      Top = 162
      Width = 236
      Height = 24
      TabOrder = 5
      Text = 'fb3'
    end
  end
  object btn4: TButton
    Left = 600
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cria Rota'
    TabOrder = 4
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 681
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Libera a rota'
    TabOrder = 5
    OnClick = btn5Click
  end
end
