unit dmDetails_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDmDetails = class(TDataModule)
    ADOConnection1: TADOConnection;
    tblDetails: TADOTable;
    dmLogindetails: TDataSource;
    tblFinance: TADOTable;
    dmFinance: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmDetails: TDmDetails;

implementation

{$R *.dfm}

end.
