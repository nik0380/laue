unit Wulf;

interface

Uses Math;

type TVector3d=array[1..3] of extended;
     TVector2d=array[1..2] of extended;
     ArrVector2d=array[1..360] of Tvector2d;
     TMatrix2d=array[1..2] of TVector2d;
     TMatrix3d=array[1..3] of TVector3d;

     TMatrix = class {класс по работе с матрицами поворота}
               protected
                m:TMatrix2d;
               public
                function GetMatrixOfRotation2d(alfa:extended):Tmatrix2d;
                function GetMatrixOfRotation3dX(alfa:extended):Tmatrix3d;
                function GetMatrixOfRotation3dY(alfa:extended):Tmatrix3d;
                function GetMatrixOfRotation3dZ(alfa:extended):Tmatrix3d;
                function MultMatrix2d(a,b:TMatrix2d):TMatrix2d;
                function MultMatrix3d(a,b:TMatrix3d):TMatrix3d;
                function MultMatrixOnVector2d(a:Tmatrix2d; t:TVector2d):Tvector2d;
                function MultMatrixOnVector3d(a:Tmatrix3d; t:TVector3d):Tvector3d;
                property Matrix:TMatrix2d read m write m;
                function GetNewCoord(v:TVector2d):TVector2d;
                function ScalarMultiplication3d(v1,v2:TVector3d):Extended;
                function Abs3d(v:TVector3d):Extended;
               end;


     TWideWulf= class
                 procedure BreakField;
                 {–азбивает окружность на Mash частей}
                 function GetPointMeridian(i:integer):Tvector2d;
                 function GetPointsParalel(i:integer):Tvector2d;
                 {¬озвращает дек. координаты меридиана или паралели}
                 procedure GetDecCord(r,f:Extended; Var x,y:Extended);
                 procedure GetSpherCord(x,y:Extended; var r,f:Extended);
                 {ѕереходы из одной системы соординт в другую}
                 procedure GetPolus(v1,v2:TVector2d; var r,f:Extended);
                 {возвращает коорд. полюса по двум точкам}
                 procedure RotatinOfPoint(m:TMatrix3d; var r,f: Extended);
                 {r,f - при обращении имеют значени€ исходной точки, после выплнени€
                 проседуры они имеют новые значени€; m - матрица поворота}
                public
                  Mash:integer;
                  A:ArrVector2d;
                  constructor Create;
                  destructor  destore;
                  procedure DecToPolar(x,y:Extended; var r,f:extended);
                  procedure PolarToDec(r,f:extended; var x,y:Extended);
                  function GetUgol(r1,f1,r2,f2:Extended):Extended;
                  {процедуры работы в пол€рных координатах}
                protected
                  Matrix:TMatrix;
                  m:integer;
                  procedure Getsphercord1(v1:TVector3d;var r,f:Extended);
                  procedure GetParamLine(v1,v2:Tvector2d; var a,b:Extended);
                  function VectMultVectors(v1,v2:TVector3d):TVector3d;
                  {параметры лин. функции проход€щей через 2 точки}
                 { Procedure GetParamPlos(v1,v2:TVector3d; var a,b:extended);}
                  {параметры плоскости проход€щей через начало координат}
             end;

procedure GetAsimCoord(x,y:Extended; Var r,f:extended);
{¬озвращавет значение –о и ‘и по декартовым координатам}
Procedure SferToDecCord(r,f:Extended; Var x,y:Extended);
Procedure SferToDecart1(r,t,f:Extended; var tr:Tvector3d);
{ѕереводит сферические координаты в декартовы}
Procedure SferToDecart(r,t,f:Extended; var x,y,z:Extended);
{¬озвращает по сферическим координатам декартовы}
procedure GetCircle(t1,t2:Tvector2d; var b,r:Extended);
{¬озвращает параметры параметры окружности проход€щей через три точки}
{procedure proection(t:vector3d; var t1:vector2d);
{проэктирует сферичкскую поверхность на плоскость "лист бумаги"}
procedure GetCircleB(t1,t2:Tvector2d; var a,r:Extended);

implementation

function TMatrix.Abs3d;
var i:Integer;
begin
  result:=0;
  for i:=1 to 3 do result:=result+v[i]*v[i];
  result:=sqrt(result);
end;

function TMatrix.ScalarMultiplication3d;
var i:Integer;
begin
     result:=0;
     for i:=1 to 3 do
      result:=result+v1[i]*v2[i];
end;

function TWideWulf.GetUgol;
var v1,v2:TVector3d;
begin
   SferToDecart1(1,r1,f1,v1);
   SferToDecart1(1,r2,f2,v2);
   result:=arccos(Matrix.ScalarMultiplication3d(v1,v2)/Matrix.Abs3d(v1)/Matrix.Abs3d(v2));
end;

constructor TWideWulf.Create;
begin
     matrix:=TMatrix.Create;
     Inherited;
end;

destructor TWideWulf.destore;
begin
     Matrix.Destroy;
     inherited;
end;

procedure TWideWulf.RotatinOfPoint;
var v:TVector3d;
begin
     SferToDecart1(1,r,f,v);
     v:=Matrix.MultMatrixOnVector3d(m,v);
     Getsphercord1(v,r,f);
end;

function TMatrix.GetMatrixOfRotation3dZ(alfa:extended):Tmatrix3d;
begin
    result[1,1]:=cos(alfa);   result[1,2]:=sin(alfa); result[1,3]:=0;
    result[2,1]:=-sin(alfa);  result[2,2]:=cos(alfa); result[2,3]:=0;
    result[3,1]:=0;           result[3,2]:=0;         result[3,3]:=1;
end;

function TMatrix.GetMatrixOfRotation3dX(alfa:extended):Tmatrix3d;
begin
    result[1,1]:=1;  result[1,2]:=0;         result[1,3]:=0;
    result[2,1]:=0;  result[2,2]:=cos(alfa); result[2,3]:=sin(alfa);
    result[3,1]:=0;  result[3,2]:=-sin(alfa);result[3,3]:=cos(alfa);
end;

function TMatrix.GetMatrixOfRotation3dY(alfa:extended):Tmatrix3d;
begin
    result[1,1]:=cos(alfa); result[1,2]:=0;   result[1,3]:=sin(alfa);
    result[2,1]:=0;         result[2,2]:=1;   result[2,3]:=0;
    result[3,1]:=-sin(alfa);result[3,2]:=0;   result[3,3]:=cos(alfa);
end;

function TWideWulf.VectMultVectors(v1,v2:TVector3d):TVector3d;
begin
     result[1]:=v1[2]*v2[3]-v2[2]*v1[3];
     result[2]:=-(v1[1]*v2[3]-v2[1]*v1[3]);
     result[3]:=v1[1]*v2[2]-v2[1]*v1[2];
end;

{
Procedure TWideWulf.GetParamPlos(v1,v2:TVector3d; var a,b:extended);
begin
     if (v1[1]*v2[2]-v2[1]*v1[2]) <> 0 then
     a:=(v1[3]*v2[2]-v2[3]*v1[2])/(v1[1]*v2[2]-v2[1]*v1[2])
     else a:=0;

     if (v1[1]*v2[2]-v2[1]*v1[2]) <> 0 then
     b:=(v1[1]*v2[3]-v2[1]*v1[3])/(v1[1]*v2[2]-v2[1]*v1[2])
     else b:=0;
end;
 }

//{     if v1[1]<>0 then
  {    begin
       if (v1[1]<0) and (v1[2]>0) then
        begin
         if v1[3]<0 then
           f0:=pi-ArcTan(v1[2]/v1[1])
           else
           f0:=-ArcTan(v1[2]/v1[1])
        end;

      if (v1[1]>0) and (v1[2]<0) then
         begin
          if (v1[3]<0) or ((v1[1]>0) and (v1[2]<0) and (v1[3]>0)) then
            f0:=-ArcTan(v1[2]/abs(v1[1]))
             else f0:=pi-ArcTan(v1[2]/abs(v1[1]));
         end;

      if (v1[1]<0) and (v1[2]<0) then
         begin
          if v1[3]<0 then
            f0:=pi-ArcTan(abs(v1[2]/v1[1]))
             else f0:=-ArcTan(abs(v1[2]/v1[1]))
         end;

      if (v1[1]>0) and (v1[2]>0) then
          begin
           if (v1[3]<0) or ((v1[1]>0) and (v1[2]>0) and (v1[3]>0)) then
            f0:=-ArcTan(abs(v1[2]/v1[1]))
             else f0:=pi-ArcTan(abs(v1[2]/v1[1]))
           end
      end
     else
     if v1[2]>0 then f0:=pi/2
        else f0:=3*pi/2;
}
procedure TWideWulf.Getsphercord1(v1:TVector3d;var r,f:Extended);
var d,r0,f0:Extended;
begin
     d:=sqrt(sqr(v1[1])+sqr(v1[2])+sqr(v1[3]));
     r0:=ArcCos(abs(v1[3]/d));
     f0:=0;
     v1[1]:=v1[1]*(v1[3]/abs(v1[3]));
     v1[2]:=v1[2]*(v1[3]/abs(v1[3]));

     if (v1[1]>0) and (v1[2]>0) then
       f0:=arctan(v1[2]/v1[1]);

     if (v1[1]>0) and (v1[2]<=0) then
       f0:=2*pi-arctan(abs(v1[2]/v1[1]));

     if (v1[1]<=0) and (v1[2]<=0) then
       f0:=pi+arctan(abs(v1[2]/v1[1]));

     if (v1[1]<=0) and (v1[2]>0) then
       f0:=pi-arctan(abs(v1[2]/v1[1]));

        r:=r0;
        f:=f0;
end;

procedure TWideWulf.GetPolus(v1,v2:TVector2d; var r,f:Extended);
var r1,f1,r2,f2:Extended;
    vv1,vv2:TVector3d;
begin

    GetSpherCord(v1[1],v1[2],r1,f1);
    GetSpherCord(v2[1],v2[2],r2,f2);
    SferToDecart(1,r1,f1,vv1[1],vv1[2],vv1[3]);
    SferToDecart(1,r2,f2,vv2[1],vv2[2],vv2[3]);
    vv1:=VectMultVectors(vv1,vv2);
    Getsphercord1(vv1,r,f);
    {f:=f+pi/2;}
end;

function TMatrix.GetNewCoord(v:TVector2d):TVector2d;
begin
     result:=TMatrix.Create.MultMatrixOnVector2d(m,v);
end;

function TMatrix.MultMatrixOnVector2d(a:Tmatrix2d; t:TVector2d):Tvector2d;
var i,j:byte;
begin
     for i:=1 to 2 do
        begin
         result[i]:=0;
         for j:=1 to 2 do
          result[i]:=result[i]+a[i,j]*t[j];
        end;
end;

function TMatrix.MultMatrixOnVector3d(a:Tmatrix3d; t:TVector3d):Tvector3d;
var i,j:byte;
begin
     for i:=1 to 3 do
        begin
         result[i]:=0;
         for j:=1 to 3 do
          result[i]:=result[i]+a[i,j]*t[j];
        end;
end;

function TMatrix.MultMatrix2d(a,b:TMatrix2d):TMatrix2d;
var i,j,k:byte;
begin
     for i:=1 to 2 do
         for j:=1 to 2 do
          begin
           result[i,j]:=0;
           for k:=1 to 2 do
            result[i,j]:=result[i,j]+a[i,k]*b[k,j];
          end;
end;

function TMatrix.MultMatrix3d(a,b:TMatrix3d):TMatrix3d;
var i,j,k:byte;
begin
     for i:=1 to 3 do
         for j:=1 to 3 do
          begin
           result[i,j]:=0;
           for k:=1 to 3 do
            result[i,j]:=result[i,j]+a[i,k]*b[k,j];
          end;
end;

function Tmatrix.GetMatrixOfRotation2d(alfa:extended):Tmatrix2d;
begin
    result[1,1]:=cos(alfa); result[1,2]:=sin(alfa);
    result[2,1]:=-sin(alfa); result[2,2]:=cos(alfa);
end;

procedure TWideWulf.BreakField;
var i:integer;
    f,df:Extended;
    v:Tvector2d;
begin
     df:=2*pi/Mash;
     f:=0;
     for i:=1 to 360 do
      begin
       f:=f+df;
       PolarToDec(1,f,v[1],v[2]);
       A[i]:=v;
      end;
end;

function TWideWulf.GetPointMeridian(i:integer):Tvector2d;
var a1,b1:Extended;
    v:Tvector2d;
begin
    v:=a[i];
   if v[2]>0 then
      begin
       result[2]:=0;
       v[1]:=0;
       v[2]:=-1;
       GetParamLine(v,a[i],a1,b1);
       result[1]:=-b1/a1;
      end
      else
      begin
       result[2]:=0;
       v[1]:=0;
       v[2]:=1;
       GetParamLine(v,a[i],a1,b1);
       result[1]:=-b1/a1;
      end
end;

procedure TwideWulf.GetSpherCord(x,y:Extended; var r,f:Extended);
var v1,v2:Tvector2d;
    a,b,d,xx,yy:Extended;
begin
    DecToPolar(x,y,r,f);
    v1[1]:=r; v1[2]:=0;
    v2[1]:=0; v2[2]:=-1;
    GetParamLine(v1,v2,a,b);
    d:=sqrt(4*a*a*b*b-4*(a*a+1)*(b*b-1));
    xx:=(-2*a*b+d)/2/(a*a+1);
    yy:=sqrt(1-xx*xx);
    DecToPolar(xx,yy,a,b);
    r:=pi/2-b;

    if x>0  then
     if f>=0 then f:=2*pi-f
    else f:=-f;

    if (x<0) then
     if f>=0 then f:=pi-f
    else f:=pi-f;

    if x=0 then
    if y>0 then f:=3*pi/2
     else f:=pi/2;
end;

function TWideWulf.GetPointsParalel(i:integer):Tvector2d;
var a1,b1:Extended;
    v:Tvector2d;
begin
    v:=a[i];
   if v[1]>0 then
      begin
       result[1]:=0;
       v[1]:=-1;
       v[2]:=0;
       GetParamLine(v,a[i],a1,b1);
       result[2]:=b1;
      end
      else
      begin
       result[1]:=0;
       v[1]:=1;
       v[2]:=0;
       GetParamLine(v,a[i],a1,b1);
       result[2]:=b1;
      end
end;

procedure TwideWulf.GetParamLine(v1,v2:Tvector2d; var a,b:Extended);
begin
     if (v2[1]-v1[1])<>0 then a:=(v2[2]-v1[2])/(v2[1]-v1[1])
      else a:=0;
     b:=v1[2]-a*v1[1];
end;

procedure TWideWulf.PolarToDec(r,f:extended; var x,y:Extended);
begin
     x:=r*cos(f);
     y:=r*sin(f);
end;

procedure TWideWulf.DecToPolar(x,y:Extended; var r,f:extended);
begin
     r:=sqrt(x*x+y*y);
     if x <> 0 then f:=ArcTan(y/x)
        else f:=pi/2;
end;

{
procedure proection(t:vector3d; var t1:vector2d);
var r,ro,r1,f1:Extended;
begin
    r:=sqrt(t[1]*t[1]+t[3]*t[3]+t[2]*t[2]);
    if r<>0 then
       ro:=ArcCos(t[1]/r)
    else ro:=pi/2;
    DecToPolar(t[2],t[3],r1,f1);
    PolarToDec(r*ro*2/pi,f1,t1[1],t1[2]);
end;
 }
procedure GetCircle(t1,t2:Tvector2d; var b,r:Extended);
var d1:Extended;
begin
     d1:=sqr(t2[1])+sqr(t2[2])-sqr(t1[1])-sqr(t1[2]);
     if (t1[2]-t2[2])<>0 then
        b:=d1/2/(t1[2]-t2[2])
     else b:=0;

     r:=sqrt(sqr(t1[1])+sqr(t1[2]+b));
end;

procedure GetCircleB(t1,t2:Tvector2d; var a,r:Extended);
var d1:Extended;
begin
     d1:=sqr(t2[1])+sqr(t2[2])-sqr(t1[1])-sqr(t1[2]);
     if (t1[1]-t2[1])<>0 then
        a:=d1/2/(t1[1]-t2[1])
     else a:=0;

     r:=sqrt(sqr(t1[1]+a)+sqr(t1[2]));
end;

procedure GetAsimCoord(x,y:Extended; Var r,f:extended);
begin
    if y<>0 then
       f:=ArcTan(x/y)
    else f:=Pi/2;
    if sqrt(x*x+y*y)<=1 then
    r:=Pi/2- ArcCos(sqrt(x*x+y*y))
    else r:=0;
end;

Procedure SferToDecart(r,t,f:Extended; var x,y,z:Extended);
begin
     x:=r*cos(f)*sin(t);
     y:=r*sin(f)*sin(t);
     z:=r*cos(t);
end;

Procedure SferToDecart1(r,t,f:Extended; var tr:Tvector3d);
begin
     tr[1]:=r*cos(f)*sin(t);
     tr[2]:=r*sin(f)*sin(t);
     tr[3]:=r*cos(t);
end;

Procedure TWideWulf.GetDecCord(r,f:Extended; Var x,y:Extended);
var v,v1:Tvector2d;
    a,b:Extended;
begin
     PolarToDec(1,DegToRad(270)+r,v[1],v[2]);

     if r=0 then
        begin
         x:=0;y:=0;
         exit;
        end;

     if v[2]>=0 then
     begin
          v1[1]:=0; v1[2]:=-1;
          if not ((v1[1]=0) and (v[1]=0)) then
          begin
            GetParamLine(v,v1,a,b);
            x:=-b/a;
            PolarToDec(x,f,x,y);
          end
          else
           begin
            x:=0;
            y:=0;
           end;
     end
     else
     begin
          v1[1]:=0; v1[2]:=1;
         if not ((v1[1]=0) and (v[1]=0)) then
          begin
            GetParamLine(v,v1,a,b);
            x:=-b/a;
            PolarToDec(x,f,x,y);
          end
          else
           begin
            x:=0;
            y:=0;
           end;
          end;

end;

Procedure SferToDecCord(r,f:Extended; Var x,y:Extended);
begin
     x:=sin(r)*cos(f);
     y:=sin(r)*sin(f);
end;

end.
