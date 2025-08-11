unit Clientdetails_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

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
    Image1: TImage;
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientDetails: TfrmClientDetails;

implementation
uses
ClientLoggedin_u;

{$R *.dfm}

procedure TfrmClientDetails.btnBackClick(Sender: TObject);
begin       //move back
frmClientDetails.Hide;
frmClientLoggedin.Show;
end;

end.
