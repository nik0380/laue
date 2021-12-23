unit base;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,Wulf,math, Grids, ComCtrls, Menus,Laugram,WideWulf,options
  ,printers;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    SaveDialog2: TSaveDialog;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    PrintDialog1: TPrintDialog;
    procedure FormCreate(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TpointsArr=array[1..150] of Tpoint;

Type TGraphicWulf= Class
     Canvas:TCanvas;
     Width,Height:Integer;
     mash:Extended;
     private
     public
      procedure DrawPolyline(m:TpointsArr);
      procedure PutPointUp(x,y:Extended);
      procedure PutPointDown(x,y:Extended);
      procedure DrawPoint(x,y:Extended);
     end;

type Tarr=array[1..100] of Integer;
     Ta= record
           ro:Extended;
           fi:Extended;
          end;
     arr=array[1..100] of Ta;

procedure PutPoint(r,f:Extended;const s:string);
procedure SetCoord(x,y:Extended);
procedure SetPolus(x,y:Extended);
procedure GetWide(m:integer);
procedure PutPolus(r,f:Extended; const s:string);
procedure GetDuga(r,f:Extended);
procedure LoadStrApp(var str:TStringGrid;var f:textfile);
procedure SaveStrApp(const str:TStringGrid;var f:textfile);

const Radius:integer=100;
      size:Integer=200;

var
  Form1: TForm1;
  wide:TWideWulf;
  Matrix:TMatrix;
  mousex,mousey:integer;
  x0,y0:integer;
  GraphicWulf:TGraphicWulf;

implementation

uses Setting,additional, about;

{$R *.DFM}

procedure TGraphicWulf.DrawPoint;
var xx,yy:integer;
begin
     mash:=radius/size;
     xx:=x0+round(x*radius);
     yy:=y0-round(y*radius);
     with Canvas do
     begin
     Pen.Width:=round(2*mash);
     Pen.Color:=clBlue;
     MoveTo(round(xx-4*mash),round(yy));
     LineTo(round(xx+4*mash),round(yy));
     MoveTo(round(xx),round(yy-4*mash));
     LineTo(round(xx),round(yy+4*mash));
     end;
end;

procedure TGraphicWulf.DrawPolyline(m:TpointsArr);
begin
    Canvas.Pen.Width:=round(radius/size);
    Canvas.Polyline(m);
end;

procedure GetEllips(rr,alfa:extended);
var m:TpointsArr;
    i:byte;
    a,r:extended;
    v1,v:TVector2d;
    mat:TMatrix2d;
begin
   v[1]:=0; v[2]:=1;
   v1[1]:=rr; v1[2]:=0;
   GetCircleB(v,v1,a,r);
   r:=r*x0;
   for i:=1 to 150 do
   with m[i] do
    begin
    y:=round(y0/75*(i-75));
    x:=round(x0+sqrt(r*r-y*y)-a*x0);
    y:=y+y0;
    end;

   mat:=Matrix.GetMatrixOfRotation2d(alfa);
   for i:=1 to 150 do
    with m[i] do
    begin
     v[1]:=x-x0;
     v[2]:=y-y0;
     v:=Matrix.MultMatrixOnVector2d(mat,v);
     x:=round(x0-v[1]);
     y:=round(y0+v[2]);
    end;
    GraphicWulf.Canvas.Pen.Color:=clred;
    GraphicWulf.DrawPolyline(m);
end;

procedure Circle(a,r:extended);
var m:TpointsArr;
    i:byte;
begin
   r:=r*x0;
   for i:=1 to 150 do
   with m[i] do
    begin
    y:=round(y0/75*(i-75));
    x:=round(x0+sqrt(r*r-y*y)-a*x0);
    y:=y+y0;
    end;
    GraphicWulf.Canvas.Pen.Width:=round(radius/size);
   GraphicWulf.Canvas.Pen.Color:=clBlack;
   GraphicWulf.DrawPolyline(m);
   for i:=1 to 150 do
     m[i].x:=round(2*x0-m[i].x);
   GraphicWulf.Canvas.Pen.Color:=clBlack;
   GraphicWulf.DrawPolyline(m);
end;

procedure GetWide(m:integer);
var d,i,x1,x2,x3,x4,y1,y2,y3,y4:integer;
    v,v1:Tvector2d;
    b,r,a:Extended;
begin
    GraphicWulf.Canvas.Brush.Color:=clWhite;
    GraphicWulf.Canvas.Pen.Color:=clBlack;
    GraphicWulf.Canvas.Pen.Width:=round(2*radius/size);
        if GraphicWulf.Width>GraphicWulf.Height
    then d:=GraphicWulf.Height
      else d:=GraphicWulf.Width;
   x0:=d div 2;
   y0:=x0;
   radius:=d div 2;
     GraphicWulf.Canvas.Pen.Width:=round(2*radius/size);
     GraphicWulf.Canvas.Ellipse(1,1,d,d);
    wide.mash:=m;
    wide.BreakField;
    for i:=1 to wide.Mash div 4-1 do
     begin
       v:=wide.GetPointMeridian(i);
       v1[1]:=0;
       v1[2]:=1;
       GetCircleB(v,v1,a,r);
       GraphicWulf.Canvas.Pen.Color:=clBlack;
       Circle(a,r);
     end;
    GraphicWulf.Canvas.Brush.Style:=bsClear;

   for i:=1 to wide.Mash div 4 do
     begin
       v:=wide.GetPointsParalel(i);
       v1:=wide.a[i];
       GetCircle(v,v1,b,r);
       x1:=x0-round(r*x0);
       y1:=y0+round(y0*b-r*y0);
       x2:=x0+round(r*x0);
       y2:=y0+round(y0*b+r*y0);
       v:=wide.a[i+wide.mash div 2];
       x3:=x0 +round(v[1]*x0);
       y3:=y0 +round(v[2]*y0);
       x4:=x0-round(v[1]*x0);
       y4:=y0+round(v[2]*y0);
       GraphicWulf.Canvas.Pen.Color:=clBlack;
       GraphicWulf.Canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
     end;

     for i:=(wide.Mash div 2)+1 to wide.Mash div 2 +wide.Mash div 4 do
     begin
       v:=wide.GetPointsParalel(i);
       v1:=wide.a[i];
       GetCircle(v,v1,b,r);
       x1:=x0-round(r*x0);
       y1:=y0+round(y0*b-r*y0);
       x2:=x0+round(r*x0);
       y2:=y0+round(y0*b+r*y0);
       v:=wide.a[i-wide.mash div 2];
       x3:=x0 +round(v[1]*x0);
       y3:=y0 +round(v[2]*y0);
       x4:=x0-round(v[1]*x0);
       y4:=y0+round(v[2]*y0);
       GraphicWulf.Canvas.Pen.Color:=clBlack;
       GraphicWulf.Canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
     end;

    with GraphicWulf.Canvas do
    begin
    Pen.Width:=2*round(radius/size);
    MoveTo(0,y0);
    LineTo(d,y0);
    MoveTo(x0,0);
    LineTo(x0,d);
    Pen.Width:=round(radius/size);
    end;
  end;

procedure TGraphicWulf.PutPointUp(x,y:Extended);
var xx,yy:integer;
begin
     mash:=radius/size;
     xx:=x0+round(x*radius);
     yy:=y0+round(y*radius);
     with Canvas do
     begin
      Pen.Width:=round(radius/size)*2;
      Pen.Color:=clBlue;
      Ellipse(round(xx-4*mash),round(yy-4*mash),round(xx+4*mash),round(yy+4*mash));
     end;
end;

procedure TGraphicWulf.PutPointDown(x,y:Extended);
var xx,yy:integer;
begin
     mash:=radius/size;
     xx:=x0+round(x*radius);
     yy:=y0+round(y*radius);
     with Canvas do
     begin
     Pen.Width:=round(radius/size)*2;
     Pen.Color:=clGreen;
     MoveTo(round(xx-4*mash),round(yy-4*mash));
     LineTo(round(xx+4*mash),round(yy+4*mash));
     MoveTo(round(xx+4*mash),round(yy-4*mash));
     LineTo(round(xx-4*mash),round(yy+4*mash));
     end;
end;

procedure PutPoint(r,f:Extended;const s:string);
var x,xx,yy,y:Extended;
begin
  wide.GetDecCord(r,f,x,y);
  if r>pi/2 then GraphicWulf.PutPointDown(x,y)
            else GraphicWulf.PutPointUp(x,y);
  if Form5.CheckBox2.Checked then
   begin
    xx:=x0+x*radius;
    yy:=y0+y*radius;
   with GraphicWulf do
    GraphicWulf.Canvas.TextOut(round(xx-3*mash),round(yy+5*mash),s);
   end;
end;

procedure PutPolus(r,f:Extended; const s:string);
var x,y:Extended;
    xx,yy:integer;
begin
  GraphicWulf.mash:=Radius/size;
  wide.GetDecCord(r,f,x,y);
  xx:=x0+round(x*radius);
  yy:=y0+round(y*radius);
  with GraphicWulf.Canvas do
  with GraphicWulf do
  begin
   Pen.Width:=round(2*mash);
   Pen.Color:=clred;
   MoveTo(round(xx-4*mash),round(yy-4*mash));
   LineTo(round(xx+4*mash),round(yy+4*mash));
   MoveTo(round(xx+4*mash),round(yy-4*mash));
   LineTo(round(xx-4*mash),round(yy+4*mash));
   if form5.CheckBox1.Checked then TextOut(round(xx-3*mash),round(yy+5*mash),s)
  end;
end;

procedure GetDuga(r,f:extended);
var x,y:Extended;
begin
  wide.GetDecCord(r-pi/2,f,x,y);
  GetEllips(sqrt(x*x+y*y),f);
end;

procedure SetCoord(x,y:Extended);
var r,f:Extended;
    i:byte;
begin
 with form1 do
 begin
  form4.StringGrid1.Cells[0,form4.StringGrid1.RowCount-1]:=inttostr(form4.StringGrid1.RowCount-1);
  form4.StringGrid1.Cells[1,form4.StringGrid1.RowCount-1]:=floattostr(x);
  form4.StringGrid1.Cells[2,form4.StringGrid1.RowCount-1]:=floattostr(y);
  wide.GetSpherCord(x,y,r,f);
  Form4.StringGrid1.Cells[3,form4.StringGrid1.RowCount-1]:=floattostr(radtodeg(r));
  form4.StringGrid1.Cells[4,form4.StringGrid1.RowCount-1]:=floattostr(radtodeg(f));
  for i:=0 to 4 do Form4.StringGrid1.Cells[i,Form4.StringGrid1.RowCount]:='';
  PutPoint(r,f,inttostr(form4.StringGrid1.RowCount-1));
  form4.StringGrid1.RowCount:=form4.StringGrid1.RowCount+1;
  form4.StringGrid1.Refresh;
 end;
end;

procedure SetPolus(x,y:Extended);
var r,f:Extended;
    i:byte;
begin
 with form1 do
 begin
  Form4.StringGrid2.Cells[0,Form4.StringGrid2.RowCount-1]:=inttostr(Form4.StringGrid2.RowCount-1);
  Form4.StringGrid2.Cells[1,Form4.StringGrid2.RowCount-1]:=floattostr(x);
  Form4.StringGrid2.Cells[2,Form4.StringGrid2.RowCount-1]:=floattostr(y);
  wide.GetSpherCord(x,y,r,f);
  Form4.StringGrid2.Cells[3,Form4.StringGrid2.RowCount-1]:=floattostr(radtodeg(r));
  Form4.StringGrid2.Cells[4,Form4.StringGrid2.RowCount-1]:=floattostr(radtodeg(f));
  for i:=0 to 4 do Form4.StringGrid2.Cells[i,Form4.StringGrid2.RowCount]:='';
  PutPolus(r,f,inttostr(Form4.StringGrid2.RowCount-1));
  GetDuga(r,f);
  Form4.StringGrid2.RowCount:=Form4.StringGrid2.RowCount+1;
  Form4.StringGrid2.Refresh;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    wide:=TWideWulf.Create;
    Matrix:=TMatrix.Create;

end;

function CalcM(const a:Tarr; n:byte):Extended;
var i:byte;
begin
    result:=0;
    for i:=1 to n-1 do
     result:=result+abs(a[i]-a[i+1]);
    result:=(n-1)/result;
end;

procedure CalcMash;
var i:integer;
    a:Tarr;
begin
  with Form4.StringGrid3 do
  begin
   for i:=1 to RowCount-2 do a[i]:=StrToInt(Cells[1,i]);
   MashX:=CalcM(a,RowCount-2);
   end;
   with Form4.StringGrid4 do
   begin
    for i:=1 to RowCount-2 do a[i]:=StrToInt(Cells[1,i]);
    MashY:=CalcM(a,RowCount-2);
   end;
end;

function ParamEllips(x,y,a,b,f:Extended):Extended;
begin
    result:= sqr(x*cos(f)+y*sin(f))/a/a+
             sqr(-x*sin(f)+y*cos(f))/b/b;
end;

procedure GetMeridian(x1,y1,x2,y2,a:Extended; var b0,f0:Extended);
var b,f,v1,v2,v,vv:Extended;
begin
    b:=0;
    vv:=0;
  repeat
   f:=0;
    repeat
     v1:=ParamEllips(x1,y1,a,b,f);
     v2:=ParamEllips(x2,y2,a,b,f);
     v:=Abs(v1-v2);
     if vv<v then
        begin
         b0:=0;
         f0:=0;
        end;
     f:=f+DegToRad(1);
     until f>=pi*2;
     b:=b+0.01;
     until b>=1;
end;

procedure Line(x,y:Extended; var x1,y1:Extended);
const D=3;
      R=10;
var l,f:Extended;
begin
    wide.DecToPolar(x,y,l,f);
    l:=R*tan((pi/4)-(1/4)*(arctan(l/d)));
    f:=f+pi;
    if x<0 then
    begin
     x1:=-abs(l)*cos(f);
     y1:=-abs(l)*sin(f);
    end
    else
    begin
     x1:=abs(l)*cos(f);
     y1:=abs(l)*sin(f);
    end;
end;

procedure  returnpolus(const m:arr;j:integer);
var i:integer;
    ro,fi,r,f:Extended;
    v1,v2:TVector2d;
begin
     r:=0;
     f:=0;
    for i:=1 to j-2 do
      begin
       v1[1]:=m[i].ro;
       v1[2]:=m[i].fi;
       v2[1]:=m[i+1].ro;
       v2[2]:=m[i+1].fi;
       wide.GetPolus(v1,v2,ro,fi);
       r:=r+ro;
       f:=f+fi;
      end;
       r:=r/(j-2);
       f:=f/(j-2);
      wide.GetDecCord(r,f,r,f);
      SetPolus(r,-f);
end;

procedure TForm1.N3Click(Sender: TObject);
var i,j,z,z1:Integer;
    x,y:extended;
    m:arr;
begin
  Clear(form4.stringgrid1);
  Clear(form4.stringgrid2);
  CalcMash;
  if form4.StringGrid5.RowCount=2 then
     begin
      MessageDlg('Заданы не все параметры',mtWarning,mbOKCancel,0);
      exit;
     end;

  if abs(MashX*MashY)<1e-5 then
     begin
      MessageDlg('Не проведено масштабирование',mtWarning,mbOKCancel,0);
      exit;
     end;

  j:=1; z1:=strtoint(Form4.StringGrid5.cells[1,1]);
  with Form4.StringGrid5 do
   for i:=1 to RowCount-2 do
       begin
         x:=strtoint(cells[2,i])-xx;
         y:=-strtoint(cells[3,i])+yy;
         x:=x*cos(alfa)+y*sin(alfa);
         y:=-x*sin(alfa)+Y*cos(alfa);
         x:=GetLenX(x);
         y:=GetLenY(y);
         z:=strtoint(cells[1,i]);
         Line(x,y,x,y);
         x:=x/10;
         y:=y/10;
         SetCoord(x,y);
         if z=z1 then
          with form4.StringGrid1 do
           begin
            m[j].ro:=strtofloat(cells[1,i]);
            m[j].fi:=strtofloat(cells[2,i]);
            inc(j);
           end
          else
             with form4.StringGrid1 do
             begin
              returnpolus(m,j);
              j:=1;
              m[j].ro:=strtofloat(cells[1,i]);
              m[j].fi:=strtofloat(cells[2,i]);
              inc(j);
             end;
          z1:=z;
        end;
        returnpolus(m,j);
   Form3.Refresh;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
    form5.visible:=true;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
      close;
end;

procedure SaveStrApp(const str:TStringGrid;var f:textfile);
var i,j:integer;
begin
     Writeln(f,str.RowCount);
     writeln(f,str.ColCount);
     for i:=0 to str.RowCount-1 do
     for j:=0 to str.ColCount-1 do
     Writeln(f,str.cells[j,i]);
end;

procedure LoadStrApp(var str:TStringGrid;var f:textfile);
var i,j:integer;
    s:string;
begin
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
end;

procedure TForm1.N7Click(Sender: TObject);
var f:textfile;
begin
    if SaveDialog1.Execute then
     begin
      assignfile(f,SaveDialog1.FileName);
      rewrite(f);
      writeln(f,form2.openpicturedialog1.filename);
      SaveStrApp(form4.StringGrid1,f);
      SaveStrApp(form4.StringGrid2,f);
      SaveStrApp(form4.StringGrid3,f);
      SaveStrApp(form4.StringGrid4,f);
      SaveStrApp(form4.StringGrid5,f);
      Writeln(f,alfa);
      Writeln(f,xx,' ',yy);
      Writeln(f,Zone);
      writeln(f,p1.x,' ',p1.y);
      writeln(f,p2.x,' ',p2.y);
      closefile(f);
     end;
end;

procedure TForm1.N6Click(Sender: TObject);
var f:textfile;
    s:string;
begin
    if OpenDialog1.Execute then
     begin
      assignfile(f,OpenDialog1.FileName);
      {$i-}
      reset(f);
      {$i+}
      if IOresult<>0 then
        begin
         MessageDlg('Файл не найден',mtError,mbOKCancel,0);
         exit;
        end;
      readln(f,s);
      LoadStrApp(form4.StringGrid1,f);
      LoadStrApp(form4.StringGrid2,f);
      LoadStrApp(form4.StringGrid3,f);
      LoadStrApp(form4.StringGrid4,f);
      LoadStrApp(form4.StringGrid5,f);
      Readln(f,alfa);
      Readln(f,xx,yy);
      Readln(f,Zone);
      readln(f,p1.x,p1.y);
      readln(f,p2.x,p2.y);
      closefile(f);
      form2.Caption:='Лауэграмма (Зона='+IntToStr(zone)+')';

     if FileExists(s) then
      begin
       form2.Image1.Picture.LoadFromFile(s);
       form2.openpicturedialog1.filename:=s;
      end
      else
      begin
       ShowMessage('Не могу найти файл '+S);
       if form2.OpenPictureDialog1.Execute then
        form2.Image1.Picture.LoadFromFile(form2.OpenPictureDialog1.FileName);
      end;

      form3.Refresh;
      form2.Refresh;
      form2.N2.Enabled:=true;
      form1.N3.Enabled:=true;
      RfreshLau;
     end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
     Form2.N1.Click;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
   form2.Show;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
    form4.Show;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
      form3.Show;
end;

procedure TForm1.N14Click(Sender: TObject);
begin
 Printer.BeginDoc;
 GraphicWulf.Canvas:=Printer.Canvas;
 GraphicWulf.Width:=Printer.PageWidth;
 GraphicWulf.Height:=Printer.PageHeight;
 WulfRegrash;
 Printer.EndDoc;
 GraphicWulf.Canvas:=form3.PaintBox1.Canvas;
 GraphicWulf.Width:=form3.PaintBox1.Width;
 GraphicWulf.Height:=form3.PaintBox1.Height;
 form3.Repaint;
 WulfRegrash;
end;

procedure SaveInText(var f:Textfile; const Str:TStringGrid);
var I,J:Integer;
begin
       with str do
         for i:=0 to RowCount-1 do
          begin
           writeln(f);
           for j:=0 to ColCount do
            write(f,copy(cells[j,i],1,6):10);
          end;
end;

procedure TForm1.N15Click(Sender: TObject);
var f:Textfile;
begin
   if SaveDialog2.Execute then
      begin
       assignfile(f,SaveDialog2.FileName);
       rewrite(f);
        writeln(f,'Направления');
        SaveInText(f,form4.StringGrid1);

        writeln(f);
        write(f,'Полюса');
        SaveInText(f,form4.StringGrid2);

        writeln(f);
        write(f,'Зоны');
        SaveInText(f,form4.StringGrid5);

        closefile(f);
      end;
end;

procedure TForm1.N16Click(Sender: TObject);
begin
    form6.Visible:=true;
end;

procedure TForm1.N17Click(Sender: TObject);
begin
  form7.Visible:=true;
end;

procedure TForm1.N18Click(Sender: TObject);
begin
   Application.HelpFile := 'X-Ray.hlp';
   Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TForm1.N19Click(Sender: TObject);
begin
   Clear(form4.stringgrid1);
   Clear(form4.stringgrid2);
   Clear(form4.stringgrid3);
   Clear(form4.stringgrid4);
   Clear(form4.stringgrid5);
   p1.x:=0;
   p1.y:=0;
   p2.x:=0;
   p2.y:=0;
   form2.Image1.Picture.Bitmap.Dormant;
   form2.Image1.Picture.Bitmap.FreeImage;
   alfa:=0;
   state:=false;
   xx:=0;
   yy:=0;
   form4.Label6.Caption:='';
   form4.Label2.Caption:='';
   form3.Repaint;
   form2.Repaint;
   form4.Repaint;
end;

end.
