object DataModule25: TDataModule25
  OldCreateOrder = False
  Height = 493
  Width = 823
  object FCon: TFDConnection
    Params.Strings = (
      'Database=C:\Windows\BaseSys\IMAGESRESOURCE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'CharacterSet=WIN1254'
      'DriverID=FB')
    Left = 752
    Top = 24
  end
  object FPsysFB: TFDPhysFBDriverLink
    Left = 752
    Top = 80
  end
end
