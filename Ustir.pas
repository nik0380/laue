unit Ustir;

interface

uses
  Classes;

type
  TRotation = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses math,Options,base,LauGram,wulf;
var Laue:arr1;
{ TRotation }

procedure TRotation.Execute;
  var m:Tmatrix2d;
    v:TVector2d;
    i,j,mi,mj:Integer;
begin

      mi:=Form2.Image1.Width;
      mj:=Form2.Image1.Height;
      with Form2.Image1.Picture.Bitmap.Canvas do
       begin

       for i:=1 to mi do
         for j:=1 to mj do
               laue[i,j]:=Pixels[i,j];
        { m:=Matrix.GetMatrixOfRotation2d(degtorad(10));}
         for i:=1 to mi do
          for j:=1 to mj do
           begin
            {v[1]:=i;
            v[2]:=j;
           { v:=Matrix.MultMatrixOnVector2d(m,v);}
            {v[1]:=v[1]+xx;
            v[2]:=-v[2]+yy;}
            {if (v[1]>0) and (v[2]>0) and (v[1]<mi) and (v[2]<mj) then}
            Pixels[i,j]:=laue[i,j];
           end;


       end;

end;

end.
