unit Additional;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Grids,math;

type str6=string[6];

type
  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.DFM}

uses base,wulf;

procedure TForm6.Button2Click(Sender: TObject);
begin
Visible:=false;
end;

procedure TForm6.Button5Click(Sender: TObject);
begin
      if form1.OpenDialog1.Execute then
         Edit2.Text:=form1.OpenDialog1.FileName;
end;

procedure TForm6.Button3Click(Sender: TObject);
var i:Integer;
    x:Extended;
    s:string;
begin
     val(Edit1.Text,x,i);
     if i<>0 then
     begin
      ShowMessage('Неверно задан угол!!!');
      exit;
     end;
     Button1.Enabled:=true;
     s:=Edit1.Text+'           ';
     s:=copy(s,1,10);
     s:=s+Edit2.text;
ListBox1.Items.Add(s);
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
    ListBox1.Items.Delete(ListBox1.ItemIndex)
end;

procedure Rotation(alfa:Extended; const str:TStringGrid);
var m:TMatrix3d;
    i:Integer;
    r,f,x,y:Extended;
begin
     m:=Matrix.GetMatrixOfRotation3dY(-alfa);
    with str do
     for i:=1 to RowCount-2 do
      begin
       r:=DegToRad(StrToFloat(Cells[3,i]));
       f:=DegToRad(StrToFloat(Cells[4,i]));
       wide.RotatinOfPoint(m,r,f);
       wide.GetDecCord(r,f,x,y);
       SetPolus(x,-y);
      end;
end;

procedure TForm6.Button1Click(Sender: TObject);
var f:TextFile;
    str:TStringGrid;
    name,s:string;
    i,er:Integer;
    alfa:Extended;
begin
    Visible:=false;
    str:=TStringGrid.Create(Self);
    for i:=1 to ListBox1.Items.Count do
     begin
      s:=ListBox1.Items.Strings[i-1];
      s:=copy(s,1,6);
      val(s,alfa,er);
      if s[1]='-' then alfa:=-alfa;
      alfa:=DegToRad(alfa);
      name:=copy(ListBox1.Items.Strings[i-1],11,length(ListBox1.Items.Strings[i-1]));
      assignfile(f,name);
      reset(f);
       readln(f,s);
       LoadStrApp(str,f);
       LoadStrApp(str,f);
       Rotation(alfa,str);
      closefile(f);
     end;
end;

end.
