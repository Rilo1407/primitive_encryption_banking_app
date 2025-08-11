object DmDetails: TDmDetails
  OldCreateOrder = False
  Height = 431
  Width = 650
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=BankingDetails_u.md' +
      'b;Mode=ReadWrite;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 152
    Top = 176
  end
  object tblDetails: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'LoginDetails'
    Left = 280
    Top = 160
  end
  object dmLogindetails: TDataSource
    DataSet = tblDetails
    Left = 384
    Top = 176
  end
  object tblFinance: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Financial information'
    Left = 280
    Top = 240
  end
  object dmFinance: TDataSource
    DataSet = tblFinance
    Left = 368
    Top = 256
  end
end
