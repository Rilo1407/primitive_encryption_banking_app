unit ClientWelcome_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TfrmLoggedin = class(TForm)
    imgBackground: TImage;
    pnlBack: TPanel;
    pnlpfp: TPanel;
    pnlPfpBack: TPanel;
    imgProfile: TImage;
    lblUserName: TLabel;
    pnlWelcome: TPanel;
    btnAccInfo: TButton;
    btnFinances: TButton;
    lblWelcome: TLabel;
    lblFullname: TLabel;
    imgDec: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoggedin: TfrmLoggedin;

implementation

{$R *.dfm}

end.
