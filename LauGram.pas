unit LauGram;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ExtDlgs,math;

const Dume=2.54;

type
  TForm2 = class(TForm)
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type TGraphicLaue=class
     Private
      Canvas:TCanvas;
      Width,Height:Integer;
     Public
      procedure SetLabel(p:Tpoint);
      procedure DrawCenter(x,y:Integer);
      procedure Reflex(x,y:Integer);
      function DrawLine:extended;
     end;

  procedure RfreshLau;
  function GetLenY(Y:Extended):extended;
  function GetLenX(X:Extended):extended;

const MashX:extended=0;
      MashY:extended=0;

var
  Form2: TForm2;
  xx,yy:Integer;
  alfa:extended;
  state:boolean;
  p1,p2:Tpoint;
  GraphicLaue:TGraphicLaue;

implementation

{$R *.DFM}
uses base,Options;

procedure TGraphicLaue.SetLabel(p:Tpoint);
begin
        with Canvas do
         begin
          pen.Color:=clBlue;
          pen.Width:=2;
          MoveTo(p.x+5,p.y+5);
          LineTo(p.x-5,p.y-5);
          MoveTo(p.x+5,p.y-5);
          LineTo(p.x-6,p.y+5);
         end;
end;

procedure RfreshLau;
var i,x,y:integer;
 begin
      if Form2.OpenPictureDialog1.FileName<>'' then
      begin
       Form2.Image1.Picture.Bitmap.LoadFromFile(Form2.OpenPictureDialog1.FileName);
       GraphicLaue.Width:=Form2.Image1.Picture.Bitmap.Width;
       GraphicLaue.Height:=Form2.Image1.Picture.Bitmap.Height;
       GraphicLaue.Canvas:=Form2.Image1.Picture.Bitmap.Canvas;
       GraphicLaue.DrawCenter(xx,yy);
       if p1.y*p2.y<>0 then GraphicLaue.DrawLine;
       if p1.y<>0 then GraphicLaue.SetLabel(p1);
       if p2.y<>0 then GraphicLaue.SetLabel(p2);
      end;
       for i:=1 to form4.StringGrid5.RowCount-2 do
       begin
        x:=strtoint(form4.StringGrid5.cells[2,i]);
        y:=strtoint(form4.StringGrid5.cells[3,i]);
        GraphicLaue.Reflex(x,y);
       end;
 end;

function GetLenX(x:Extended):extended;
begin
     result:=x*mashX;
end;

function GetLenY(Y:Extended):extended;
begin
     result:=Y*mashY;
end;


procedure TGraphicLaue.DrawCenter(x,y:Integer);
begin
    with Canvas do
     begin
       Pen.Color:=clRed;
       Pen.Width:=2;
       MoveTo(x-20,y);
       LineTo(x+20,y);
       MoveTo(x,y-20);
       LineTo(x,y+20);
     end;
end;

procedure TGraphicLaue.Reflex(x,y:Integer);
begin
with Canvas do
      begin
       Pen.Color:=clYellow;
       Pen.Width:=2;
       Ellipse(x-2,y-2,x+2,y+2);
      end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
 if OpenPictureDialog1.Execute then
 begin
  Image1.Picture.Bitmap.LoadFromFile(OpenPictureDialog1.filename);
  N2.Enabled:=true;
  GraphicLaue.Width:=Image1.Picture.Bitmap.Width;
  GraphicLaue.Height:=Image1.Picture.Bitmap.Height;
 end;

end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if Image1.Picture.Bitmap.Width<>0 then
    begin
     MouseX:=round(x*(Image1.Picture.Bitmap.Width/Image1.Width));
     MouseY:=round(y*(Image1.Picture.Bitmap.Height/Image1.Height));
    end;
end;

function Liner(p1,p2:TPoint;x:Extended):Extended;
var a,y:Extended;
begin
   if p2.x-p1.x=0 then
    begin
     result:=0;
     exit;
    end;
   a:=(p1.y-p2.y)/(p1.x-p2.x);
   y:=p1.y-a*p1.x;
   result:=y+a*x;
end;

function TGraphicLaue.DrawLine:Extended;
begin
with Canvas do
        begin
         pen.Width:=2;
         pen.Color:=ClRed;
         if (p1.x-p2.x)<>0 then
           Result:=arctan((p1.y-p2.y)/(p1.x-p2.x))
          else
          begin
           Result:=0;
           exit;
          end;
           MoveTo(0,round(Liner(p1,p2,0)));
           LineTo(Width,round(Liner(p1,p2,Width)));
         end;
end;

procedure Mashtab;
var s:string;
begin
     if Form4.PageControl3.ActivePage.TabIndex =0
      then
       with form4.StringGrid3 do
        begin
          RowCount:=RowCount+1;
          Cells[1,RowCount-2]:=inttostr(mousex);
          Cells[0,RowCount-2]:=inttostr(RowCount-2);
          Cells[1,RowCount-1]:='';
          Cells[0,RowCount-1]:='';
          Refresh;
        end;

   if Form4.PageControl3.ActivePage.TabIndex =1 then
       with form4.StringGrid4 do
        begin
          RowCount:=RowCount+1;
          Cells[1,RowCount-2]:=inttostr(mousey);
          Cells[0,RowCount-2]:=inttostr(RowCount-2);
          Cells[1,RowCount-1]:='';
          Cells[0,RowCount-1]:='';
          Refresh;
        end;

   if Form4.PageControl3.ActivePage.TabIndex =2 then
    begin
     xx:=mousex;
     yy:=mousey;
     Form4.label2.Caption:='X0='+inttostr(xx);
     Form4.label3.Caption:='Y0='+inttostr(yy);
     GraphicLaue.DrawCenter(mousex,mousey);
     form1.N3.Enabled:=true;
    end;

   if Form4.PageControl3.ActivePage.TabIndex =3 then
    begin
         if state then
            begin
              p1.x:=mousex;
              p1.y:=mousey;
            end
            else
            begin
              p2.x:=mousex;
              p2.y:=mousey;
            end;
      state:=not state;
      if not state then
       begin
        alfa:=GraphicLaue.DrawLine;
        str(radtodeg(alfa):6:3,s);
        Form4.Label6.Caption:=s;
       end;
    end;

   RfreshLau;
end;

procedure SetZone;
begin
   with Form4.StringGrid5 do
    begin
     RowCount:=RowCount+1;
     Cells[0,RowCount-2]:=IntToStr(RowCount-2);
     Cells[1,RowCount-2]:=IntToStr(Zone);
     Cells[2,RowCount-2]:=IntToStr(mousex);
     Cells[3,RowCount-2]:=IntToStr(mousey);

     Cells[0,RowCount-1]:='';
     Cells[1,RowCount-1]:='';
     Cells[2,RowCount-1]:='';
     Cells[3,RowCount-1]:='';

     Refresh;
    end;
  GraphicLaue.Reflex(mousex,mousey);
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
    if Form4.PageControl1.ActivePage.TabIndex<>2 then exit;
    with Form4.PageControl2 do
     begin
      if ActivePage.TabIndex=0 then Mashtab;
      if ActivePage.TabIndex=1 then
       if xx*yy<>0 then SetZone;
     end;
     form4.Refresh;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
    Image1.Picture.Bitmap.LoadFromFile(OpenPictureDialog1.FileName);
    Form4.StringGrid5.RowCount:=2;
    zone:=1;
     Caption:='Лауэграмма (Зона='+IntToStr(zone)+')';
    Form4.StringGrid5.Cells[2,1]:='';
    Form4.StringGrid5.Cells[3,1]:='';
    Form4.StringGrid5.Cells[1,1]:='';
end;

procedure TForm2.N3Click(Sender: TObject);
begin
     inc(zone );
     Caption:='Лауэграмма (Зона='+IntToStr(zone)+')';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
    Left:=3;
    Top:=20;
    GraphicLaue:=TGraphicLaue.Create;
    GraphicLaue.Canvas:=Image1.Picture.Bitmap.Canvas;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
     GraphicLaue.Width:=Image1.Picture.Bitmap.Width;
     GraphicLaue.Height:=Image1.Picture.Bitmap.Height;
end;

procedure TForm2.N4Click(Sender: TObject);
begin
   Width:=round(Width*1.5);
   Height:=round(Height*1.5);
end;

procedure TForm2.N5Click(Sender: TObject);
begin
    Width:=round(Width / 1.5);
    Height:=round(Height / 1.5);
end;

end.
