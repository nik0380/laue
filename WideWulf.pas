unit WideWulf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,math, StdCtrls, Menus;

type
  TForm3 = class(TForm)
    PaintBox1: TPaintBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure WulfRegrash;

const Fpoint:boolean=false;

type TPointEx = record
            x,y:Extended;
           end;

var
  Form3: TForm3;
  point1,point2:TPointEx;
  Ugol:String;

implementation

{$R *.DFM}
uses base, Options,wulf,LauGram;


procedure TForm3.FormResize(Sender: TObject);
begin
    form3.Height:=form3.Width;
    GraphicWulf.Width:=PaintBox1.Width;
    GraphicWulf.Height:=PaintBox1.Height;
end;

procedure TForm3.FormCreate(Sender: TObject);
var d:Integer;
begin
    Left:=3;
    Top:=form2.Height+10;
     GraphicWulf:=TGraphicWulf.Create;
     GraphicWulf.Canvas:=PaintBox1.Canvas;
     GraphicWulf.Width:=PaintBox1.Width;
     GraphicWulf.Height:=PaintBox1.Height;
        if GraphicWulf.Width>GraphicWulf.Height
    then d:=GraphicWulf.Height
      else d:=GraphicWulf.Width;
   x0:=d div 2;
   y0:=x0;
   radius:=d div 2;
end;

procedure WulfRegrash;
var i:byte;
    r,f:Extended;
begin
   GetWide(36);
  for i:=1 to form4.StringGrid1.RowCount-2 do
  begin
   r:=StrToFloat(form4.StringGrid1.Cells[3,i]);
   f:=StrToFloat(form4.StringGrid1.Cells[4,i]);
   PutPoint(DegToRad(r),DegToRad(f),inttostr(i));
  end;

  for i:=1 to form4.StringGrid2.RowCount-2 do
  begin
   r:=StrToFloat(form4.StringGrid2.Cells[3,i]);
   f:=StrToFloat(form4.StringGrid2.Cells[4,i]);
   PutPolus(DegToRad(r),DegToRad(f),inttostr(i));
   GetDuga(DegToRad(r),DegToRad(f));
  end;
  if Form3.N3.Checked then
   begin
    GraphicWulf.DrawPoint(point1.x,point1.y);
    GraphicWulf.DrawPoint(point2.x,point2.y);
   end;
end;

procedure OutUgol;
var r1,r2,f1,f2:Extended;
begin
     wide.GetSpherCord(point1.x,point1.y,r1,f1);
     wide.GetSpherCord(point2.x,point2.y,r2,f2);
     Ugol:=FloatToStr(RadToDeg(wide.GetUgol(r1,f1,r2,f2)));
end;

procedure TForm3.PaintBox1Click(Sender: TObject);
var x,y:Extended;
begin
 x:=(mousex-x0)/radius;
 y:=(-mousey+y0)/radius;

 if not N3.Checked then
 begin
  if sqr(x) + sqr(y)<=1 then
   begin
   if form4.PageControl1.ActivePage.TabIndex=0 then SetCoord(x,y);
   if form4.PageControl1.ActivePage.TabIndex=1 then SetPolus(x,y);
   WulfRegrash;
   end;
 end
 else
 begin
  if Fpoint then
   begin
    point1.x:=x;
    point1.y:=y;
    Fpoint:=not Fpoint;
    WulfRegrash;
    OutUgol;
   end
   else
   begin
    point2.x:=x;
    point2.y:=y;
    Fpoint:=not Fpoint;
    WulfRegrash;
    OutUgol;
   end;
 end;
end;

procedure TForm3.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var r,f,xx,yy:extended;
    s1,s2:string;
begin
   Form3.PaintBox1.Cursor:=-3;
    mousex:=x;
    mousey:=y;
    xx:=(x-x0)/radius;
    yy:=(y-y0)/radius;
 if sqrt(xx*xx+yy*yy)<=1 then
   begin
    wide.GetSpherCord(xx,yy,r,f);
    str(radtodeg(r):5:2,s1);
    str(radtodeg(2*pi-f):5:2,s2);
    form3.Caption:='Сетка Вульфа ('+s1+' '+s2+') '+Ugol;
   end;
end;

procedure TForm3.PaintBox1Paint(Sender: TObject);
begin
   WulfRegrash;
end;

procedure TForm3.N1Click(Sender: TObject);
begin
Width:=round(Width*1.5);
Height:=round(Height*1.5);
end;

procedure TForm3.N2Click(Sender: TObject);
begin
   Width:=round(Width/1.5);
   Height:=round(Height/1.5);
end;

procedure TForm3.N3Click(Sender: TObject);
begin
   n3.Checked:=not N3.Checked;
   if not n3.Checked then Ugol:=''; 
   WulfRegrash;
end;

end.
