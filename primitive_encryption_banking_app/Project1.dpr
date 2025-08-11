program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmWelcome},
  SignUp_U in 'SignUp_U.pas' {frmSignUp},
  login_u in 'login_u.pas' {frmLogin},
  ClientWelcome_u in 'ClientWelcome_u.pas' {Form2},
  Unit3 in 'Unit3.pas' {frmClientDetails},
  dmDetails_u in 'dmDetails_u.pas' {DmDetails: TDataModule},
  AdminLogin_u in 'AdminLogin_u.pas' {frmAdminLoggin},
  ClientLoggedin_u in 'ClientLoggedin_u.pas' {frmClientLoggedin},
  ClientFinances_u in 'ClientFinances_u.pas' {frmClientFinances};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmAdminLoggin, frmAdminLoggin);
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TfrmClientLoggedin, frmClientLoggedin);
  Application.CreateForm(TDmDetails, DmDetails);
  Application.CreateForm(TfrmClientFinances, frmClientFinances);
  {Application.CreateForm(TForm2, Form2);}
  Application.CreateForm(TfrmClientDetails, frmClientDetails);
  Application.Run;
end.
