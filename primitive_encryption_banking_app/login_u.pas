unit login_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, ComCtrls, StdCtrls, dmDetails_u,ClientWelcome_u,
  MPlayer;

type
  TfrmLogin = class(TForm)
    imgBackground: TImage;
    pgcLogin: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnlBack: TPanel;
    pnlBack2: TPanel;
    lblAdminUser: TLabel;
    lblAdminPassword: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtAdminUsername: TEdit;
    edtAdminPassword: TEdit;
    btnCancel: TButton;
    BtnLogin: TButton;
    BtnloginA: TButton;
    btnCancelA: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    pnlDisplay: TPanel;
    pnlDisplayA: TPanel;
    MPlogin: TMediaPlayer;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCancelAClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure pgcLoginChange(Sender: TObject);
    procedure BtnloginAClick(Sender: TObject);
  private
    { Private declarations }
  public
   sAccNum,sUser,sFullname,sAll,sName,sSurname,sDOB,sPass,sDOLD,sDOLW:string;
   rAvailable,rDeposit,rWithdrawal:real; { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  Unit1,AdminLogin_u,ClientLoggedin_u,Unit3,ClientFinances_u;
{$R *.dfm}

procedure TfrmLogin.btnCancelAClick(Sender: TObject);
//ADMIN CANCEL BUTTON : MOVES FROM LOGIN TO WELCOME
begin
  frmLogin.Hide;
  frmWelcome.Show;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
//CANCEL BUTTON : MOVES FROM LOGIN TO WELCOME
begin
  frmLogin.Hide;
  frmWelcome.Show;
end;

procedure TfrmLogin.BtnloginAClick(Sender: TObject);
var
sUserName,sPassword:string;
bAccess:boolean;
//ADMIN LOGIN BUTTON : MOVED TO ADMIN LOGGED IN PAGE
begin
sUserName:= edtAdminUsername.Text;
sPassword:=edtAdminPassword.Text;

if (sUserName='') or (sPassword='') or (sPassword=' ') or (sUserName=' ') then
begin
MPlogin.FileName:='fill in details.mp3';                //VERIFYING  THAT FIELDS ARE FILLED IN
MPlogin.Open;
MPlogin.Play;
pnlDisplayA.Caption:='Please ensure all fields are fulled in';  //ERROR MESSAGE
end //if else
else
begin
with DmDetails do
begin
tblDetails.First;

while not tblDetails.Eof do
begin
  if (susername=tblDetails['UserName'])and (sPassword = tblDetails['Password']) and (tblDetails['Admin']=true)then
  begin
    bAccess:=true;                                      //CHECKING DETAILS ARE CORRECT
  end; //if details correct
  tblDetails.Next;
end;//while

if bAccess= true then
begin
 frmLogin.Hide;                        //MOVES TO ADMIN LOGGED IN PAGE
frmAdminLoggin.Show;
end  //if details correct
else
begin
MPlogin.FileName:='wrong login.mp3';   //ERROR MESSAGE INCORRECT DETAILS
MPlogin.Open;
MPlogin.Play;
pnlDisplayA.Caption:='Login details are wrong';
end;  //if details incorrect

end;  //with
 end;//if else
end;  //end


procedure TfrmLogin.BtnLoginClick(Sender: TObject);
var
  susername: string;
  sPassword: string;
  bAccess,bAcces2:boolean;
  //CLIENT LOGIN BUTTON : MOVES TO CLIENT LOGGED IN PAGE
begin
  susername := edtUsername.Text;
  sPassword := edtPassword.Text;

if (sUserName='') or (sPassword='')then      //CHECKS IF ALL FIELDS ARE FULLED IN
begin
MPlogin.FileName:='fill in details.mp3';
MPlogin.Open;
MPlogin.Play;
pnlDisplay.Caption:='Please ensure all fields are fulled in'; //ERROR MESSAGE

end //if else
else
begin
with DmDetails do
begin
 tblDetails.First;
 tblFinance.First;

while not tblDetails.Eof do
begin
   if (susername=tblDetails['UserName']) and (sPassword = tblDetails['Password']) then
  begin
    bAcces2:=True;                                          //IF DETAILS CORRECT

    sAccNum:= tblDetails['AccNum'];                         //ASSIGNS DETAILS VARIABLES
    sName:= tblDetails['FirstName'];
    sSurname:= tblDetails['Surname'];
    sFullname:= tblDetails['FirstName']+' '+tblDetails['Surname'];
    sUser:= tblDetails['UserName'];
    sDOB:= DateToStr(tblDetails['DateOfBirth']);
    sPass:= tblDetails['Password'];

        frmClientLoggedin.lblUserName.Caption:=sUser;        //CHANGES Client loggedin labels
        frmClientLoggedin.lblFullname.Caption:=sFullname+' ';

        frmClientDetails.lblName.Caption:= sName;         //CHANGES Client details labels
        frmClientDetails.lblSurname.Caption:= sSurname;
        frmClientDetails.lblPassword.Caption:= sPassword;
        frmClientDetails.lblUserName.Caption:= sUser;
        frmClientDetails.lblDateOfBirth.Caption:= sDOB;

while NOT tblFinance.Eof do
begin                                           //finances information
if sAccNum= tblFinance['AccNum'] then
begin
rAvailable:= tblFinance['AvailableBalance'];      //ASSIGN FINANCE VARIABLES
rDeposit:= tblFinance['Deposit'];
rWithdrawal:= tblFinance['Withdrawal'];
sDOLD:= DateToStr(tblFinance['DateOfLastDeposit']);
sDOLW:=DateToStr(tblFinance['DateOfLastWithDrawal']);

frmClientFinances.lblWithdrawal.Caption:= FloatToStrf(rWithdrawal,ffCurrency,8,2);  //CHANGES CLIENT FINANCES LABELS
frmClientFinances.lblDeposit.Caption:= FloatToStrf(rDeposit,ffCurrency,8,2);
frmClientFinances.lblAvalibleBalance.Caption:= FloatToStrf(rAvailable,ffCurrency,8,2);
frmClientFinances.lblDateoflastdeposit.Caption:= sDOLD;
frmClientFinances.lbldateoflastwithdrawal.Caption:=sDOLW;

end; //if else
tblFinance.Next;
end;//while finances loop
end; //if else
  tblDetails.Next;
end; //while


if (bAcces2=true) then        //IF DETAILS CORRECT
begin
frmLogin.hide;               //MOVES TO CLIENT LOGGED IN
frmClientLoggedin.Show;
end  //if else 2
else
begin
MPlogin.FileName:='wrong login.mp3';
MPlogin.Open;
MPlogin.Play;
  pnlDisplay.Caption:='Your login details are wrong'; //ERROR MESSAGE
end;  //if else 2

end;//with
end;//if else blank spaces
 end; //end


   procedure TfrmLogin.pgcLoginChange(Sender: TObject);
begin
end; // end



end.
