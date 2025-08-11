unit AdminLogin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,dmDetails_U, Grids, DBGrids, ExtCtrls, jpeg,
  MPlayer;

type
  TfrmAdminLoggin = class(TForm)
    imgBackground: TImage;
    pnlBack: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    btnLogout: TButton;
    pnlSearchUser: TPanel;
    btnSearchUser: TButton;
    pnlDeleteUser: TPanel;
    btnDelete: TButton;
    pnlSort: TPanel;
    btnSort: TButton;
    pnlEdit: TPanel;
    btnEdit: TButton;
    pnlAdmin: TPanel;
    btnAdmin: TButton;
    mpAdmin: TMediaPlayer;
    procedure BtnNameClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnAdminClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdminLoggin: TfrmAdminLoggin;

implementation

{$R *.dfm}

procedure TfrmAdminLoggin.BtnNameClick(Sender: TObject);
var
sUser,sSearch,sFirstName:string;
iAccNum:integer;
//SEARCH USER BUTTON : ALLOWS TO SEARCH FOR A SPECIFIC USER
begin
 sSearch:=InputBox('User search','Are you searching for a Username/First Name/Acc Number ','');

 if UpperCase(sSearch)= 'USERNAME' then
 begin
  sUser:=InputBox('Username search','Search for Username','');

  with DmDetails do
  begin
  if tblDetails.Locate('UserName',sUser,[])=true then        //user name located record
  begin
  iAccNum:= tblDetails['AccNum'];
  tblFinance.Locate('AccNum',iAccNum,[]);
    mpAdmin.FileName:='record found.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
   ShowMessage('Record found');

        pnlEdit.Visible:=True;               //making panels visable
      pnlDeleteUser.Visible:=True;
         pnlSort.Visible:=True;
            pnlAdmin.Visible:=True;

  end //if located
  else
  begin
    mpAdmin.FileName:='record not found better.mp3'; //ERROR MESSAGE
  mpAdmin.Open;
  mpAdmin.Play;
  ShowMessage('Record not found');
  end;  //if not located
  end;  // dm details



 end//if else
 else
 if (UpperCase(sSearch)= 'FIRST NAME') or (UpperCase(sSearch)= 'FIRSTNAME') then
 begin
  sFirstName:=InputBox('Name search','Search for a name','');

   with DmDetails do
  begin
  if tblDetails.Locate('FirstName',sFirstName,[])=true then        //first name located record
  begin
  iAccNum:= tblDetails['AccNum'];
  tblFinance.Locate('AccNum',iAccNum,[]);
    mpAdmin.FileName:='record found.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
   ShowMessage('Record found');

   pnlEdit.Visible:=True;                               //making panels visable
      pnlDeleteUser.Visible:=True;
         pnlSort.Visible:=True;
            pnlAdmin.Visible:=True;

  end //if located
  else
  begin
    mpAdmin.FileName:='record not found better.mp3';      //ERROR MESSAGE
  mpAdmin.Open;
  mpAdmin.Play;
  ShowMessage('Record not found');
  end;  //if not located
  end;  // dm details


 end //if else
 else
 if (UpperCase(sSearch)= 'ACC NUMBER') or (UpperCase(sSearch)= 'ACCNUMBER') then
 begin
   iAccNum:=strtoint(InputBox('Account search','Search for an Account',''));

    with DmDetails do
  begin
  if tblDetails.Locate('AccNum',iAccNum,[])=true then        //acc number located record
  begin
  tblFinance.Locate('AccNum',iAccNum,[]);
    mpAdmin.FileName:='record found.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
   ShowMessage('Record found');

     pnlEdit.Visible:=True;               //making panels visable
      pnlDeleteUser.Visible:=True;
         pnlSort.Visible:=True;
            pnlAdmin.Visible:=True;


  end //if located
  else
  begin
    mpAdmin.FileName:='record not found better.mp3'; //ERROR MESSAGE
  mpAdmin.Open;
  mpAdmin.Play;
  ShowMessage('Record not found');
  end;  //if not located
  end;  // dm details

 end //if else
 else
 begin
   mpAdmin.FileName:='incorrect input better.mp3';  //ERROR MESSAGE
  mpAdmin.Open;
  mpAdmin.Play;
 ShowMessage('Incorrect input');
 end; //if else
end;//end


 procedure TfrmAdminLoggin.btnSortClick(Sender: TObject);
 var
 sSort:string;
  //SORT BUTTON :SORT MONEY IN ASCENDING OR DESCENDING ORDER
begin
sSort:=InputBox('SORT money','Would you like ascending or decending','');

if UpperCase(sSort)='ASCENDING' then   //ASCENDING ORDER
begin
DmDetails.tblFinance.Sort:='AvailableBalance ASC';
end //if else
else
if UpperCase(sSort)= 'DESCENDING' then    //DESCENDING ORDER
begin
DmDetails.tblFinance.Sort:='AvailableBalance DESC';
end//if else
else
begin
  mpAdmin.FileName:='incorrect input better.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
 ShowMessage('Incorrect input'); //ERROR MESSAGE
end;//if else
end;//end



procedure TfrmAdminLoggin.btnAdminClick(Sender: TObject);
//make admin button : MAKES USER ADMIN
begin
with DmDetails do
begin
tblDetails.Edit;
tblDetails['Admin']:= True;
tblDetails.Post;
 mpAdmin.FileName:='now an admin.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
ShowMessage(tblDetails['FirstName']+ ' is now an Admin'); //ADMIN MESSAGE
end;//with dm deatils

end;

procedure TfrmAdminLoggin.btnDeleteClick(Sender: TObject);
var
iAccNum:integer;
//DELETE BUTTON : DELETES USER
begin
with DmDetails do
begin
iAccNum:= tblDetails['AccNum'];
tblDetails.Delete;

if tblFinance.Locate('AccNum', iAccNum, []) = true then
begin
tblFinance.Delete;
end;//locate

end;//with
end;//END


procedure TfrmAdminLoggin.btnEditClick(Sender: TObject);
var
sWhatEdit,sUser,sPass:string;
//EDIT BUTTON : EDITS USERS PASSWORD OR USERNAME
begin
sWhatEdit:= InputBox('Edit a field','What would you like to edit Username/Password','');

if UpperCase(sWhatEdit)='USERNAME' then
begin
sUser:= InputBox('Username','Enter a new user name','');

with DmDetails do
begin

if sUser=tblDetails['UserName'] then //USERNAME IS SAME AS PREVIOUS USERNAME
begin
  mpAdmin.FileName:='diff username.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
ShowMessage('The username must be different'); //ERROR MESSAGE

end // if else
else
begin
tblDetails.Edit;                                    //editing Username
tblDetails['UserName']:= sUser;
tblDetails.Post;
end; //if else
end;//with
end//if else
else                                                          //editing password
if UpperCase(sWhatEdit)='PASSWORD' then
begin

sPass:= InputBox('Password','Enter a new Password','');

with DmDetails do
begin

if sPass=tblDetails['Password'] then //PASSWORD IS AME AS PREVIOUS PASSWORD
begin
 mpAdmin.FileName:='diff password.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
ShowMessage('The password must be different'); //ERROR MESSAGE
end // if else
else
begin
tblDetails.Edit;                           //editing password
tblDetails['Password']:= sPass;
tblDetails.Post;
end; //if else
end;//with
end//if else
else
begin
  mpAdmin.FileName:='incorrect input better.mp3';
  mpAdmin.Open;
  mpAdmin.Play;
 ShowMessage('Incorrect input'); //ERROR MESSAGE
end; //if else
end;//end

procedure TfrmAdminLoggin.btnLogoutClick(Sender: TObject);
// log out button : closes application
begin
Application.Terminate;
end; //end



end.
