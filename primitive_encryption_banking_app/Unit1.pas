unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, SignUp_U, login_U, MPlayer;

type
  TfrmWelcome = class(TForm)
    ImgBackground: TImage;
    pnlSideBack: TPanel;
    pnlWelcomeBack: TPanel;
    pnlSideFront: TPanel;
    pnlWelcomeFront: TPanel;
    MemWelcome: TMemo;
    lblWelcome: TLabel;
    pnlSidefrontT1: TPanel;
    btnSignUp: TButton;
    btnLogin: TButton;
    pnlSideFrontT2: TPanel;
    pnlSideFrontT3: TPanel;
    btnTNC: TButton;
    btnFeedBack: TButton;
    btnContactDetails: TButton;
    rpgTNCs: TRadioButton;
    mpWelcome: TMediaPlayer;
    procedure btnSignUpClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnTNCClick(Sender: TObject);
    procedure btnContactDetailsClick(Sender: TObject);
    procedure MemWelcomeChange(Sender: TObject);
    procedure btnFeedBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;

implementation

{$R *.dfm}

procedure TfrmWelcome.btnContactDetailsClick(Sender: TObject);
var
sline:string;
tContact:textfile;
//CUSTOMER SERVICE BUTTON :Read and display contact deatails
begin
MemWelcome.Lines.Clear;
if FileExists('Contact.txt') then          //READING AND DISPLAYING FROM TEXTFILE
begin
 AssignFile(tContact,'Contact.txt');
 Reset(tContact);
 while not Eof(tContact) do
 begin
 Readln(tContact,sline);
 MemWelcome.Lines.Add(sline);
 end; //while
CloseFile(tContact);
end  //if else
else
begin
 ShowMessage('File does not exist');          //ERROR MSG
 Exit;
end;//if else
end; //end

procedure TfrmWelcome.btnFeedBackClick(Sender: TObject);
var
tfeedback:TextFile;
sfeedback:string;
//FEEDBACK BUTTON :add feedback to textfile
begin
sfeedback:= InputBox('Feedback','Enter feedback','');    //ADDING INFORMATION TO A TEXTFILE
if FileExists('Feedback.txt') then
begin
AssignFile(tfeedback,'Feedback.txt');
Append(tfeedback);
Writeln(tfeedback,sfeedback);
if sfeedback='' then
begin

end    //if else for feed back
else
begin
 mpWelcome.FileName:='feedback.mp3';
  mpWelcome.Open;
  mpWelcome.Play;
ShowMessage('Thank you for your feedback!');         //VERIFYING MSG FOR FEEDBACK

end;//if else for feedback
CloseFile(tfeedback);
end //if else
else
begin
 ShowMessage('file does not exist');                 //ERROR MSG
 Exit;
end;//if else
end;  //end

procedure TfrmWelcome.btnLoginClick(Sender: TObject);
//LOGIN BUTTON: move to login page
begin
if rpgTNCs.Checked then
begin
frmWelcome.Hide;        //MOVE TO LOGIN PAGE
frmLogin.Show;
end //if else TNCS ACCEPTED
else
begin
 mpWelcome.FileName:='TNCS better.mp3';    //DISPLAY ERROR MSG
  mpWelcome.Open;
  mpWelcome.Play;
ShowMessage('Please agree to our terms and conditions before continuing');
end;//if else TNCS NOT ACCEPTED
end; //end

procedure TfrmWelcome.btnSignUpClick(Sender: TObject);
//BUTTON FOR SIGN UP :move to sign up page
begin
if rpgTNCs.Checked then
begin
frmWelcome.Hide;                           //MOVE TO SIGN UP PAGE
frmSignUp.Show;
end  //if else TNCS ACCEPTED
else
begin
 mpWelcome.FileName:='TNCS better.mp3';     //DISPLAY ERROR MSG
  mpWelcome.Open;
  mpWelcome.Play;
ShowMessage('Please agree to our terms and conditions before continuing');
end; //if else TNCS NOT ACCEPTED
end;//END

procedure TfrmWelcome.btnTNCClick(Sender: TObject);
var
tTNCfile:textfile;
sline:string;
//TERMS AND CONDITIONS BUTTON :to read and display from textfile for terms and conditions
begin
MemWelcome.Lines.Clear;
if FileExists('TNCs.txt ') then
begin
AssignFile(tTNCfile,'TNCs.txt');    //READING AND DISPLAYING FROM TEXT FILE
Reset(tTNCfile);
while not Eof(tTNCfile) do
begin
Readln(tTNCfile,sline);
MemWelcome.Lines.Add(sline);
end; //while
 CloseFile(tTNCfile);
end //if else
else
begin
ShowMessage('File does not exist');   //ERROR MSG
Exit;
end; //if else
rpgTNCs.Visible:=True;                 // MAKES RPGTNCs visable
end;//end

 procedure TfrmWelcome.MemWelcomeChange(Sender: TObject);
begin
end;//end


end.
