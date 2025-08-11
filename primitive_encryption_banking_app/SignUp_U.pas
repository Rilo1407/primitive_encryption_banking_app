unit SignUp_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, ComCtrls,Math, MPlayer;

type
  TfrmSignUp = class(TForm)
    imgBackground: TImage;
    pnlBack: TPanel;
    lblSurname: TLabel;
    pnlFront: TPanel;
    lblDateOfBirth: TLabel;
    lblPassword: TLabel;
    lblFirstName: TLabel;
    lblUsername: TLabel;
    edtPassword: TEdit;
    EdtFirstName: TEdit;
    edtUseName: TEdit;
    edtSurname: TEdit;
    lblErrormsg: TLabel;
    btnConfirmSignUp: TButton;
    btnCancel: TButton;
    dtpDOB: TDateTimePicker;
    lblError2: TLabel;
    btnVerify: TButton;
    lblAvailable: TLabel;
    lblNotAvailable: TLabel;
    MPsignUp: TMediaPlayer;
    procedure btnCancelClick(Sender: TObject);
    procedure btnConfirmSignUpClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
  private
    { Private declarations }
  public
  sUser:string;
bVerify,bButtonClicked:boolean; { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation
uses
Unit1,dmDetails_u,login_u;

{$R *.dfm}


procedure TfrmSignUp.btnCancelClick(Sender: TObject);
//CANCEL BUTTON : MOVES BACK TO WELCOME SCREEN
begin
frmSignUp.Hide;
frmWelcome.Show;
end;//END

procedure TfrmSignUp.btnConfirmSignUpClick(Sender: TObject);
var
sName,sSurname,sUser2,sPassword,scopy:string;
dDOB,dDOLD,dDOLW:tDate;
iAge,iAccNum:integer;
 //SIGN UP BUTTON : CREATES ACCOUNT ON DATABASE AND MOVES TO LOGIN FORM
begin
sName:=EdtFirstName.Text;                     //extracting information
sPassword:=edtPassword.Text;
sUser2:=edtUseName.Text;
sSurname:=edtSurname.Text;
dDOB:= dtpDOB.Date;
scopy:= DateToStr(dDOB);
iAge:= 2021-StrToInt(Copy(scopy,1,4));
dDOLD:=Date;
dDOLW:=Date;

if (bButtonClicked=false) or (bVerify=false) or (sUser<>sUser2) then      //CHECKING IF USERNAME HAS BEEN VERIFIED
begin
MPsignUp.FileName:='verify username.mp3';
MPsignUp.Open;
MPsignUp.Play;
ShowMessage('Please verify UserName'); //ERROR MESSAGE
lblAvailable.Visible:=false;
lblNotAvailable.Visible:=true;
end
else
if (sName='') or (sSurname='') or (sPassword='') or (sUser='')  then    //CHECKING IF ALL FIELDS HAVE BEEN FILLED IN
begin
lblAvailable.Visible:=true;
MPsignUp.FileName:='not proceed.mp3'; //ERROR MESSAGE
MPsignUp.Open;
MPsignUp.Play;
lblErrormsg.Visible:= true;

end
else
if (iAge=0) or (iAge>150) or (iAge<0) then           // CHECKING IF AGE IS A PLAUSABLE ONE
begin
lblAvailable.Visible:=true;
MPsignUp.FileName:='dob.mp3';//ERROR MESSAGE
MPsignUp.Open;
MPsignUp.Play;
lblError2.Visible:=True;
end//if else DOB //if else 1
else
begin
lblAvailable.Visible:=true;
with DmDetails do                                //inserting in data base
begin
tblDetails.Last;
iAccNum:=tblDetails['AccNum']+1;

tblDetails.First;
tblDetails.Insert;                          //tblDetails
tblDetails['AccNum']:=iAccNum;
tblDetails['FirstName']:=sName;
tblDetails['Surname']:=sSurname;
tblDetails['Password']:=sPassword;
tblDetails['UserName']:=sUser;
tblDetails['DateOfBirth']:=dDOB;
tblDetails['Admin']:=false;
tblDetails.Post;


tblFinance.Insert;                               //tblFinances
tblFinance['AccNum']:=iAccNum;
tblFinance['Deposit']:=0;
tblFinance['Withdrawal']:=0;
tblFinance['AvailableBalance']:=0;
tblFinance['DateOfLastWithdrawal']:=dDOLW;
tblFinance['DateOfLastDeposit']:=dDOLD;

tblFinance.Post;
tblFinance.Refresh;

end; //with dmDetails
MPsignUp.FileName:='signed up.mp3';
MPsignUp.Open;
MPsignUp.Play;
ShowMessage('Congradulations your account is now setup your code is ' +IntToStr(iAccNum)); //SIGN UP MESSAGE AND CODE
frmSignUp.Hide;
frmlogin.Show;      //MOVES TO LOGIN PAGE
end;//if else 1
end; //end


procedure TfrmSignUp.btnVerifyClick(Sender: TObject);
//VERIFY USER BUTTON : CHECKS IF USERNAME IS AVAILABLE ON SYSTEM
begin
bButtonClicked:=False;
bVerify:=true;
sUser:=edtUseName.Text;

with DmDetails do
begin
tblDetails.First;

while not tblDetails.Eof do
begin
 if tblDetails.Locate('UserName',sUser,[ ])= true  then      //COMPARES USERNAME WITH ONES ON SYSTEM
 begin
 bVerify:=False;
 tblDetails.Last;
 end; //if else end
tblDetails.Next;
end; //while
end;//with

 if bVerify=False then //IF USERNAME WAS FOUND
 begin
 MPsignUp.FileName:='user not available.mp3';  //ERROR MESSAGE
MPsignUp.Open;
MPsignUp.Play;
  lblAvailable.Visible:= false;
  lblNotAvailable.Visible:=True;
 end//if else labels
 else
 begin
 MPsignUp.FileName:='user available.mp3';   //USER AVAILABLE MESSAGE
MPsignUp.Open;
MPsignUp.Play;
 bButtonClicked:=true;
   lblAvailable.Visible:= true;
  lblNotAvailable.Visible:=false;
 end;//if else labels
end; //end



end.
