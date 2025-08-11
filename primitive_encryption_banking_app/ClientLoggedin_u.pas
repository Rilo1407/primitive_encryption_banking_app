unit ClientLoggedin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg,dmDetails_u;

type
  TfrmClientLoggedin = class(TForm)
    imgBackground: TImage;
    pnlBack: TPanel;
    imgDec: TImage;
    pnlpfp: TPanel;
    lblUserName: TLabel;
    pnlPfpBack: TPanel;
    imgProfile: TImage;
    Button1: TButton;
    pnlWelcome: TPanel;
    lblWelcome: TLabel;
    lblFullname: TLabel;
    pnlDetails: TPanel;
    btnAccInfo: TButton;
    pnlFinance: TPanel;
    btnFinances: TButton;
    procedure btnAccInfoClick(Sender: TObject);
    procedure btnFinancesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientLoggedin: TfrmClientLoggedin;

implementation
uses
unit3,ClientFinances_u,Unit1,login_u;

{$R *.dfm}

procedure TfrmClientLoggedin.btnAccInfoClick(Sender: TObject);
 var
 arrCopy:array[1..5] of string;
 sInfo:string;
iASCII,iLength,Ic:integer;
//CHECK ACC INFORMATION BUTTON : encrypt client details labels and move from client logged in to client details
begin
 frmClientLoggedin.Hide;
 frmClientDetails.Show;

   //To encrypt Name lable on Client details
sInfo:= frmClientDetails .lblName.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[1]:= arrCopy[1] + Chr(iASCII+1);
end;   // for loop
 frmClientDetails.lblName.Caption:=arrCopy[1];

    //To encrypt Surname lable on Client details
 sInfo:= frmClientDetails .lblSurname.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[2]:= arrCopy[2] + Chr(iASCII+1);
end;   // for loop
 frmClientDetails.lblSurname.Caption:=arrCopy[2];

     //To encrypt UserName lable on Client details
 sInfo:= frmClientDetails .lblUserName.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[3]:= arrCopy[3] + Chr(iASCII+1);
end;   // for loop
 frmClientDetails.lblUserName.Caption:=arrCopy[3];

     //To encrypt password lable on Client details
 sInfo:= frmClientDetails .lblPassword.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[4]:= arrCopy[4] + Chr(iASCII+1);
end;   // for loop
 frmClientDetails.lblPassword.Caption:=arrCopy[4];

     //To encrypt DOB lable on Client details
 sInfo:= frmClientDetails .lblDateOfBirth.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[5]:= arrCopy[5] + Chr(iASCII+1);
end;   // for loop
 frmClientDetails.lblDateOfBirth.Caption:=arrCopy[5];
end; //end

procedure TfrmClientLoggedin.btnFinancesClick(Sender: TObject);
var
arrCopy:array[1..5] of string;
sInfo:string;
Ic,iASCII:integer;
 //CLIENTS FINANCES :  encrypt client finances labels and move from client logged in to client finances
begin
frmClientLoggedin.Hide;
frmClientFinances.Show;

 //To encrypt Withdrawal lable on Client Finances
sInfo:= frmClientFinances.lblWithdrawal.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[1]:= arrCopy[1] + Chr(iASCII+1);
end;   // for loop
 frmClientFinances.lblWithdrawal.Caption:=arrCopy[1];

  //To encrypt Deposit lable on Client Finances
sInfo:= frmClientFinances.lblDeposit.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[2]:= arrCopy[3] + Chr(iASCII+1);
end;   // for loop
 frmClientFinances.lblDeposit.Caption:=arrCopy[2];

  //To encrypt Date of last deposit lable on Client Finances
sInfo:= frmClientFinances.lblDateoflastdeposit.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[3]:= arrCopy[3] + Chr(iASCII+1);
end;   // for loop
 frmClientFinances.lblDateoflastdeposit.Caption:=arrCopy[3];

 //To encrypt Date of last withdrawal lable on Client Finances
sInfo:= frmClientFinances.lbldateoflastwithdrawal.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[4]:= arrCopy[4] + Chr(iASCII+1);
end;   // for loop
 frmClientFinances.lbldateoflastwithdrawal.Caption:=arrCopy[4];

 //To encrypt Available balance lable on Client Finances
sInfo:= frmClientFinances.lblAvalibleBalance.Caption;
for Ic := 1 to Length(sInfo) do
begin
 iASCII:= Ord(sInfo[ic]);
 arrCopy[5]:= arrCopy[5] + Chr(iASCII+1);
end;   // for loop
 frmClientFinances.lblAvalibleBalance.Caption:=arrCopy[5];
end; //end


procedure TfrmClientLoggedin.Button1Click(Sender: TObject);
  //log out button : closes application
begin
frmClientLoggedin.Hide;
Application.Terminate;
end;

procedure TfrmClientLoggedin.FormCreate(Sender: TObject);
begin

end;  //end


end.
