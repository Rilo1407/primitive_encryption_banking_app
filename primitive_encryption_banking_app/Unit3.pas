unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls,dmDetails_u, ComCtrls, MPlayer;

type
  TfrmClientDetails = class(TForm)
    imgBackground: TImage;
    pnlBack: TPanel;
    btnBack: TButton;
    pnlDecrypt: TPanel;
    btnDecrypt: TButton;
    pnlName: TPanel;
    pnlSurname: TPanel;
    pnlUsername: TPanel;
    pnlDateOfBirth: TPanel;
    pnlPassword: TPanel;
    lblName: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblSurname: TLabel;
    lblDateOfBirth: TLabel;
    btnEditName: TButton;
    btnEditSurname: TButton;
    btnEditDOB: TButton;
    btnEditPassword: TButton;
    btnEditUsername: TButton;
    imgDecoration: TImage;
    lblInfo1: TLabel;
    lblInfo2: TLabel;
    lblInfo3: TLabel;
    lblInfo4: TLabel;
    lblInfo5: TLabel;
    dtpDOB: TDateTimePicker;
    btnChange: TButton;
    MpDetails: TMediaPlayer;
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure btnEditNameClick(Sender: TObject);
    procedure btnEditSurnameClick(Sender: TObject);
    procedure btnEditUsernameClick(Sender: TObject);
    procedure btnEditPasswordClick(Sender: TObject);
    procedure btnEditDOBClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
   bDecrypt:boolean; { Public declarations }
  end;

var
  frmClientDetails: TfrmClientDetails;

implementation
uses
ClientLoggedin_u,login_u;

{$R *.dfm}

procedure TfrmClientDetails.btnBackClick(Sender: TObject);
//Back button : moves to client loggin page
begin
frmClientDetails.Hide;
frmClientLoggedin.Show;
bDecrypt:= False;

end;//end

procedure TfrmClientDetails.btnChangeClick(Sender: TObject);
var
dDob:tdate;
iAge:integer;
sCopy:string;
//CHANGE BUTTON : edits DOB on database
begin
dDob:=dtpDOB.Date;
sCopy:= Datetostr(dDOB);
iAge:= 2021- StrToInt(Copy(sCopy,1,4));

if (iAge=0) or (iAge>150) or (iAge<0)  then        //CHECKS IF AGE IS PLUASEABLE
begin
     MpDetails.FileName:='dob.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('Please check that your date of birth is correct');
end
else
begin
with DmDetails do
begin
tblDetails.First;
if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then     //editing name on database
begin
 tblDetails.Edit;
 tblDetails['DateOfBirth']:= dDob;
 tblDetails.Post;
end; //if else 3

pnlDateOfBirth.Visible:=True;      //makes visable
btnChange.Visible:=False;
dtpDOB.Visible:=false;
lblDateOfBirth.Caption:= DateToStr(dDob);
end;//with dmdetails
end;//if data validation
end;//end

procedure TfrmClientDetails.btnDecryptClick(Sender: TObject);
var
sDecrypt:string;
sdob:string;
//DECRYPT BUTTON : decrypts labels allows user to edit information
begin
sDecrypt:=InputBox('Decrypt','Enter code to decrypt','');

if sDecrypt = frmLogin.sAccNum then         //code to decrypt labels
begin
bDecrypt:=True;
with DmDetails do begin
tblDetails.Locate('AccNum',frmLogin.sAccNum,[]);
lblName.Caption:= tblDetails['FirstName'];
lblSurname.Caption:= tblDetails['Surname'];
lblUserName.Caption:=tblDetails['UserName'];
sdob:= DateToStr(tblDetails['DateOfBirth']);
Delete(sdob,11,10);
lblDateOfBirth.Caption:=sdob;
lblPassword.Caption:= tblDetails['Password'];
end;//with dmDeatils
end//if else
else
begin
     MpDetails.FileName:='incorrect code.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('incorrect code');
end;//if else
end;//end

procedure TfrmClientDetails.btnEditDOBClick(Sender: TObject);
//DOB EDIT BUTTON : makes date time picker and
begin
if bDecrypt=false then
begin
     MpDetails.FileName:='no access.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('You do not have access');
end
else
begin
pnlDateOfBirth.Visible:=false;
dtpDOB.Visible:=True;
btnChange.Visible:=true;
end;
end;  //end

procedure TfrmClientDetails.btnEditNameClick(Sender: TObject);
var
sName:string;
//EDIT NAME BUTTON : EDITS NAME ON DATA BASE
begin
//For checking if code have been decrypted and editing name
if bDecrypt=false then
begin
     MpDetails.FileName:='no access.mp3';
     MpDetails.Open;
     MpDetails.Play;                                                      //data validation
ShowMessage('You do not have access');
end //if else
else
begin
sName:= InputBox('New name','Enter a new name','');

if (sName='') or (sName=frmLogin.sName)  then         //data validation
begin
     MpDetails.FileName:='name invalid.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('invalid input the new name must be differnt from the old one and you are not allowed to add blank text');
end  // if else 2
else
begin


with DmDetails do
begin
tblDetails.First;
if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then     //editing name on database
begin
 tblDetails.Edit;
 tblDetails['FirstName']:= sName;
 tblDetails.Post;
 lblName.Caption:= tblDetails['FirstName'] ;
 frmClientLoggedin.lblFullname.Caption:= lblName.Caption+' '+lblSurname.Caption;
end; //if else 3


end;//with dm details
end; //if else 2
end; //if else
end;//end

procedure TfrmClientDetails.btnEditPasswordClick(Sender: TObject);
var
sPass :string;
//EDIT PASSWORD BUTTON : edits password on database
begin
//For checking if code have been decrypted and editing password
if bDecrypt=false then
begin
     MpDetails.FileName:='no access.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('You do not have access');                             //data validation
end //if else
else
begin
sPass:= InputBox('New name','Enter a new name','');

if (sPass='') or (sPass=frmLogin.sPass)  then        //Data valadation
begin
     MpDetails.FileName:='password invalid.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('invalid input the new password must be differnt from the old one and you are not allowed to add blank text');
end  // if else 2
else
begin
lblPassword.Caption:= sPass;

with DmDetails do
begin
tblDetails.First;
if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then  //Editing password on database
begin
 tblDetails.Edit;
 tblDetails['Password']:= sPass;
 tblDetails.Post;
end; //if else 3


end;//with dm details
end; //if else 2
end; //if else
end;//end




procedure TfrmClientDetails.btnEditSurnameClick(Sender: TObject);
var
sSurname:string;
//SURNAME EDIT BUTTON :edit surnmae on database
begin
//For checking if code have been decrypted and editing surname
if bDecrypt=false then
begin
     MpDetails.FileName:='no access.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('You do not have access');                             //data validation
end //if else
else
begin
sSurname:= InputBox('New Surname','Enter a new Surname','');

if (sSurname='') or (sSurname=frmLogin.sSurname)  then        //Data valadation
begin
     MpDetails.FileName:='surname invalid.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('invalid input the new Surname must be differnt from the old one and you are not allowed to add blank text');
end  // if else 2
else
begin


with DmDetails do
begin

tblDetails.First;
//Editing surname on database
if tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ])= true then
begin
 tblDetails.Edit;
 tblDetails['Surname']:= sSurname;
 tblDetails.Post;
   lblSurname.Caption:= tblDetails['Surname'];
  frmClientLoggedin.lblFullname.Caption:= lblName.Caption+' '+lblSurname.Caption;
end; //if else 3


end;//with dm details
end; //if else 2
end; //if else
end;//end

procedure TfrmClientDetails.btnEditUsernameClick(Sender: TObject);
var
suser:string;
bDiff:boolean;
//USERNAME EDIT BUTTON : Edits username on database
begin
//For checking if code have been decrypted and editing Username
bDiff:=True;
if bDecrypt=false then
begin
     MpDetails.FileName:='no access.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('You do not have access');                             //data validation
end //if else
else
begin
suser:= InputBox('New Username','Enter a new Username','');

if (suser='') or (suser=frmLogin.sUser)  then        //Data valadation
begin
     MpDetails.FileName:='user invalid.mp3';
     MpDetails.Open;
     MpDetails.Play;
ShowMessage('invalid input the new Username must be differnt from the old one and you are not allowed to add blank text');
end  // if else 2
else
begin

with DmDetails do
begin

    if  tblDetails.Locate('UserName',suser,[ ])=true then      //checks user name is not same as others on system
    begin
     bDiff:=False;
     MpDetails.FileName:='invalid user.mp3';
     MpDetails.Open;
     MpDetails.Play;
     ShowMessage('Invalid username');
    end;//if user matches with another

  if bDiff=true then
  begin
 tblDetails.Locate('AccNum',frmLogin.sAccNum,[ ]); //Editing Username on database
 tblDetails.Edit;
 tblDetails['UserName']:= suser;
 tblDetails.Post;
 lblUserName.Caption:= suser;
frmClientLoggedin.lblUserName.Caption:= lblUserName.Caption;
end;//if differnet


end;//with dm details
end; //if else 2
end; //if else
end;//end



procedure TfrmClientDetails.FormCreate(Sender: TObject);
begin

end;  //end

end.
