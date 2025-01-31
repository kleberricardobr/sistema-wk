object DmDatabase: TDmDatabase
  Height = 480
  Width = 640
  object Connection: TFDConnection
    Params.Strings = (
      'Server=127.0.0.1'
      'CharacterSet=utf8'
      'Password=****'
      'DriverID=MySQL')
    LoginDialog = LoginDialog
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object Link: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\Xpr\Desktop\sistema-wk\mysql-connector\libmysql.dll'
    Left = 144
    Top = 32
  end
  object LoginDialog: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 232
    Top = 32
  end
end
