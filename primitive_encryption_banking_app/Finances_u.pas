unit Finances_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TfrmFinances = class(TForm)
    imgBackGround: TImage;
    pnlBack: TPanel;
    btnBack: TButton;
    lblWithdrawal: TLabel;
    lblAvalibleBalance: TLabel;
    lblDateoflastdeposit: TLabel;
    lbldateoflastwithdrawal: TLabel;
    lblDeposit: TLabel;
    pnlDecrypt: TPanel;
    btnDecrypt: TButton;
    lblInfo1: TLabel;
    lblInfo2: TLabel;
    lblInfo3: TLabel;
    imgDec: TImage;
    lblInfo4: TLabel;
    lblInfo5: TLabel;
    btnWithdrawal: TButton;
    btnDeposit: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinances: TfrmFinances;

implementation

{$R *.dfm}

end.
