unit ClientFinances_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Spin, MPlayer;

type
  TfrmClientFinances = class(TForm)
    imgBackGround: TImage;
    pnlBackWithdrawal: TPanel;
    lblWithdrawal: TLabel;
    lblAvalibleBalance: TLabel;
    lblDateoflastdeposit: TLabel;
    lbldateoflastwithdrawal: TLabel;
    lblDeposit: TLabel;
    lblInfo1: TLabel;
    lblInfo2: TLabel;
    lblInfo3: TLabel;
    imgDec: TImage;
    lblInfo4: TLabel;
    lblInfo5: TLabel;
    btnBack: TButton;
    pnlDecrypt: TPanel;
    btnDecrypt: TButton;
    pnlBackDeposit: TPanel;
    btnDeposit: TButton;
    pnlWithdrawal: TPanel;
    btnWithdrawal: TButton;
    spnDeposit: TSpinEdit;
    spnWithdrwal: TSpinEdit;
    MPFinances: TMediaPlayer;
    procedure btnBackClick(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure btnWithdrawalClick(Sender: TObject);
  private
    { Private declarations }
  public
  bDecrypt:boolean;  { Public declarations }
  end;

var
  frmClientFinances: TfrmClientFinances;

implementation
uses
clientloggedin_u,login_u,dmDetails_u;

{$R *.dfm}

procedure TfrmClientFinances.btnBackClick(Sender: TObject);
// BACK BUTTON :move from finanaces back to client loggedin
begin
frmClientFinances.Hide;
frmClientLoggedin.Show;
bDecrypt:=false;
spnDeposit.Visible:=False;
spnWithdrwal.Visible:=False;
end;

procedure TfrmClientFinances.btnDecryptClick(Sender: TObject);
var
sDecrypt:string;
//DECRYPT BUTTON : decrypts labels
begin
sDecrypt:= InputBox('Decrypt','Enter code','');

if sDecrypt= frmLogin.sAccNum then
begin
bDecrypt:= true;
with DmDetails do
begin
tblFinance.Locate('AccNum',frmLogin.sAccNum,[]);
frmClientFinances.lblWithdrawal.Caption:= FloatToStrf(tblFinance['Withdrawal'],ffCurrency,8,2);    //Decrypts labels
frmClientFinances.lblDeposit.Caption:= FloatToStrf(tblFinance['Deposit'],ffCurrency,8,2);
frmClientFinances.lblDateoflastdeposit.Caption:= tblFinance['DateOfLastWithdrawal'];
frmClientFinances.lbldateoflastwithdrawal.Caption:= tblFinance['DateOfLastDeposit'];
frmClientFinances.lblAvalibleBalance.Caption:= FloatToStrf( tblFinance['AvailableBalance'],ffCurrency,8,2);
spnDeposit.Visible:= true;
spnWithdrwal.Visible:= true;
end;//dm details
end
else
begin
MPFinances.FileName:='incorrect code.mp3';
MPFinances.Open;
MPFinances.Play;
ShowMessage('Inncorrect code'); //ERRROR MESSAGE
end  //if else
end; //end


procedure TfrmClientFinances.btnDepositClick(Sender: TObject);
var
 rDeposit:real;
 dDOLD:tdate;
  //deposit button : adds money to database
begin
 rDeposit:= spnDeposit.Value;
if bDecrypt=true then
begin


if (rDeposit<0) or (rDeposit=0) then //checks if amount deposited is puasable
begin
MPFinances.FileName:='not deposit.mp3';
MPFinances.Open;
MPFinances.Play;
 ShowMessage('You can not deposit that');//ERRROR MESSAGE
end  //if else 2
else
begin
with DmDetails do
begin

if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then
begin
 dDOLD:=Date;                                                             //UPDATES EVERYTHING
 tblFinance.Locate('AccNum',frmLogin.sAccNum,[ ]);
 tblFinance.Edit;
 tblFinance['Deposit']:= rDeposit;
 tblFinance['DateOfLastDeposit']:= dDOLD;
 tblFinance['AvailableBalance']:= tblFinance['AvailableBalance']+rDeposit;
 tblFinance.Post;
 tblFinance.Refresh;

 lblDeposit.Caption:=  FloatToStrF(tblFinance['Deposit'],ffCurrency,8,2);
 lblDateoflastdeposit.Caption:=  tblFinance['DateOfLastDeposit'];
 lblAvalibleBalance.Caption:=  FloatToStrF(tblFinance['AvailableBalance'],ffCurrency,8,2);
end; //if else 3
end; //with dm details
end; //if else 2
end //if else
else
begin
MPFinances.FileName:='no access.mp3';
MPFinances.Open;
MPFinances.Play;
ShowMessage('You do not have access');//ERROR MESSAGE
end;//if else
end;//end

 procedure TfrmClientFinances.btnWithdrawalClick(Sender: TObject);
var
dDOLW:tdate;
rwithdrawal:real;
iAge:integer;
sCopy:string;
//WITHDRAWAL BUTTON : takes out money from database
begin
 rwithdrawal:= spnWithdrwal.Value;

if bDecrypt=true then
begin
with DmDetails do
begin

if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then
begin
 sCopy:= Copy(tblDetails['DateOfBirth'],1,4);
 iAge:= 2021- StrToInt(sCopy);

if (rwithdrawal<0) or (rwithdrawal=0) or (rwithdrawal>tblFinance['AvailableBalance']) then //CHECKS IF WITHDRAWAL AMOUNT IS PLAUSABLE
begin
MPFinances.FileName:='not withdrawal.mp3';
MPFinances.Open;
MPFinances.Play;
 ShowMessage('You can not Withdrawal that');//ERRROR MESSAGE
end  //if else 2
else
if (iAge<18) and (rwithdrawal>1000) then //AGE RESITRICTION ON AMOUNT WITHDRAWA
begin
MPFinances.FileName:='minor.mp3';
MPFinances.Open;
MPFinances.Play;
ShowMessage('You are a minor and cant withdraw that amount without parental permission');//ERROR MESSAGE
end
else
begin
 dDOLW:=Date;

 tblFinance.Locate('AccNum',frmLogin.sAccNum,[ ]);

 tblFinance.Edit;                                                             //UPDATES EVERYTHING
 tblFinance['Withdrawal']:= rwithdrawal;
 tblFinance['DateOfLastWithdrawal']:= dDOLW;
 tblFinance['AvailableBalance']:= tblFinance['AvailableBalance']-rwithdrawal;
 tblFinance.Post;
 tblFinance.Refresh;

 lblWithdrawal.Caption:=  FloatToStrF(tblFinance['Withdrawal'],ffCurrency,8,2);
 lbldateoflastwithdrawal.Caption:=  tblFinance['DateOfLastWithdrawal'];
 lblAvalibleBalance.Caption:=  FloatToStrF(tblFinance['AvailableBalance'],ffCurrency,8,2);
end; //if else 3
end; //with dm details
end; //if else 2
end //if else
else
begin
MPFinances.FileName:='no access.mp3';
MPFinances.Open;
MPFinances.Play;
ShowMessage('You do not have access');//ERROR MESSAGE
end;//if else
end;//end


end.
