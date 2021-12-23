unit Options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, Menus, StdCtrls, Buttons,math;

type
  TForm4 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    TabSheet8: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PopupMenu2: TPopupMenu;
    N4: TMenuItem;
    PopupMenu3: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    TabSheet9: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



procedure Clear(var str:TStringGrid);

const Zone:Integer=1;

var
  Form4: TForm4;

implementation

uses base,LauGram, WideWulf,wulf;

{$R *.DFM}

procedure TForm4.FormCreate(Sender: TObject);
begin
    left:=form2.Width+10;
    top:=20;
    form4.StringGrid1.Cells[1,0]:='X';
    form4.StringGrid1.Cells[2,0]:='Y';
    form4.StringGrid1.Cells[3,0]:='Ro';
    form4.StringGrid1.Cells[4,0]:='Fi';

    form4.StringGrid2.Cells[1,0]:='X';
    form4.StringGrid2.Cells[2,0]:='Y';
    form4.StringGrid2.Cells[3,0]:='Ro';
    form4.StringGrid2.Cells[4,0]:='Fi';

    form4.StringGrid3.Cells[1,0]:='X';

    form4.StringGrid4.Cells[1,0]:='Y';

    form4.StringGrid5.Cells[0,0]:='N';
    form4.StringGrid5.Cells[1,0]:='N зоны';
    form4.StringGrid5.Cells[2,0]:='X';
    form4.StringGrid5.Cells[3,0]:='Y';
end;

procedure SaveStr(const str:TStringGrid; name:string);
var i,j:integer;
    f:textfile;
begin
     assignfile(f,name);
     rewrite(f);
     Writeln(f,str.RowCount);
     writeln(f,str.ColCount);
     for i:=0 to str.RowCount-1 do
     for j:=0 to str.ColCount-1 do
     Writeln(f,str.cells[j,i]);
     closefile(f);
end;

procedure LoadStr(var str:TStringGrid; name:string);
var i,j:integer;
    f:textfile;
    s:string;
begin
     assignfile(f,name);
     reset(f);
     readln(f,i);
     str.RowCount:=i;
     readln(f,j);
     str.ColCount:=j;
     for i:=0 to str.RowCount-1 do
     for j:=0 to str.ColCount-1 do
     begin
      Readln(f,s);
      str.cells[j,i]:=s;
     end;
     closefile(f);
end;

procedure TForm4.N1Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
  begin
   if form4.PageControl1.ActivePage.TabIndex=1 then SaveStr(Form4.StringGrid2,SaveDialog1.FileName);
   if form4.PageControl1.ActivePage.TabIndex=0 then SaveStr(form4.StringGrid1,SaveDialog1.FileName);
  end;
end;

procedure TForm4.N2Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
    begin
     if form4.PageControl1.ActivePage.TabIndex=0 then LoadStr(form4.StringGrid1,OpenDialog1.FileName);
     if form4.PageControl1.ActivePage.TabIndex=1 then LoadStr(Form4.StringGrid2,OpenDialog1.FileName);
    end;
   form1.Refresh;
end;

procedure DeleteRow(var str:TStringGrid);
var i:Integer;
begin
  if str.RowCount>2 then
    begin
     for i:=str.row to str.RowCount do
      begin
       str.Rows[i]:=str.Rows[i+1];
       str.Cells[0,i]:=inttostr(i);
      end;
     str.RowCount:=str.RowCount-1;
    end;
end;

procedure TForm4.N3Click(Sender: TObject);
begin
   if form4.PageControl1.ActivePage.TabIndex=0 then DeleteRow(form4.stringgrid1);
   if form4.PageControl1.ActivePage.TabIndex=1 then DeleteRow(Form4.StringGrid2);
    form3.Refresh;
end;


procedure TForm4.N4Click(Sender: TObject);
begin

   if Form4.PageControl3.ActivePage.TabIndex=0 then
     begin
      DeleteRow(form4.StringGrid3);
      form4.StringGrid4.Refresh;
     end;

   if Form4.PageControl3.ActivePage.TabIndex=1 then
     begin
      DeleteRow(form4.StringGrid4);
      form4.StringGrid4.Refresh;
     end;

end;

procedure TForm4.N5Click(Sender: TObject);
begin
   if Form4.PageControl2.ActivePage.TabIndex=1 then
   begin
     DeleteRow(form4.StringGrid5);
      form4.StringGrid5.Refresh;
      RfreshLau;
   end;
end;

procedure TForm4.N6Click(Sender: TObject);
begin
    Zone:=Zone+1;
    form2.Caption:='Лауэграмма (Зона='+IntToStr(zone)+')';
end;

procedure TForm4.N7Click(Sender: TObject);
begin
    if SaveDialog1.Execute then
       SaveStr(StringGrid5,SaveDialog1.FileName);
end;

procedure TForm4.N8Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
     begin
      LoadStr(StringGrid5,opendialog1.filename);
      zone:=strtoint(form4.StringGrid5.Cells[1,form4.StringGrid5.rowcount-2]);
     end;
      RfreshLau;
end;

procedure Clear(var str:TStringGrid);
var i:byte;
begin
   str.RowCount:=2;
  for i:=0 to 4 do str.Cells[i,1]:='';
end;

procedure TForm4.N9Click(Sender: TObject);
begin
   if form4.PageControl1.ActivePage.TabIndex=0 then Clear(form4.stringgrid1);
   if form4.PageControl1.ActivePage.TabIndex=1 then Clear(Form4.StringGrid2);
    form3.Refresh;
end;

procedure TForm4.N10Click(Sender: TObject);
var x,i:integer;
begin
   x:=form2.Image1.Picture.Bitmap.Width;
   x:=round(x/8.9{dume});
   form4.StringGrid3.RowCount:=2;
   form4.StringGrid4.RowCount:=2;
   for i:=0 to 5 do
    begin
     with form4.StringGrid3 do
        begin
          RowCount:=RowCount+1;
          Cells[1,RowCount-2]:=inttostr(i*x);
          Cells[0,RowCount-2]:=inttostr(RowCount-2);
          Cells[1,RowCount-1]:='';
          Cells[0,RowCount-1]:='';
          Refresh;
        end;

     with form4.StringGrid4 do
        begin
          RowCount:=RowCount+1;
          Cells[1,RowCount-2]:=inttostr(i*x);
          Cells[0,RowCount-2]:=inttostr(RowCount-2);
          Cells[1,RowCount-1]:='';
          Cells[0,RowCount-1]:='';
          Refresh;
        end;
    end;
end;

procedure TForm4.N11Click(Sender: TObject);
begin
   with PageControl3.ActivePage do
    begin
     if TabIndex=0 then
       with StringGrid3 do
        begin
          RowCount:=2;
          Cells[0,1]:='';
          Cells[1,1]:='';
        end;

       if TabIndex=1 then
       with StringGrid4 do
        begin
          RowCount:=2;
          Cells[0,1]:='';
          Cells[1,1]:='';
        end;
    end;
end;

end.
