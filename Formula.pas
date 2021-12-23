unit formula;

interface

uses SysUtils;

 type String10=string[10];

 type Perem=record
            Name:string[10];
            a:Extended;
           end;
      TValues=array[1..50] of perem;


    TFormula=class(Tobject)
      FormulaValue:TValues;
      FormulaNum:Byte;
      procedure AddValue(Name:String10;a:Extended);
      procedure InitFormula;
      function GetFormula(s:string):Extended;
      procedure ChangeValue(Name:String10;a:Extended);
     end;


 implementation

 procedure TFormula.changevalue(name:string10;a:extended);
  var i:byte;
  begin;
   for i:=1 to formulanum do
    if formulavalue[i].name=name then
     begin
      formulavalue[i].a:=a;
      break;
     end;
  end;

 procedure Tformula.addvalue(name:string10;a:extended);
  begin
   inc(formulanum);
   formulavalue[formulanum].name:=name;
   formulavalue[formulanum].a:=a;
  end;

  procedure TFormula.initformula;
  var i:byte;
  begin
   for i:=1 to 50 do
    begin
     formulavalue[i].name:='';
     formulavalue[i].a:=0;
    end;
    formulanum:=0;
  end;

  procedure calcfun(var s:string);forward;

  function findpos(s1:char; s:string):byte;
  var i:byte;
  begin
  findpos:=0;
  for i:=1 to length(s) do
   if s[i]=s1  then
   if (s[i-1]<>'+') and (s[i-1]<>'-') and (s[i-1]<>'/') and (s[i-1]<>'*') and ((s[i-1]<>'E') and (i<>1)) then
   begin
    findpos:=i;
    break;
   end;
 end;

  function flagstr(s:string;x:byte):boolean;
  var f2,f3:boolean;
  begin
   f2:=(s[x]='*') or (s[x]='-') or (s[x]='/') or (s[x]='+');
   f3:=(s[x-1]='*') or (s[x-1]='-') or (s[x-1]='/') or (s[x-1]='+') or (s[x-1]='E') or (s[x-1]='e')  or (x=1);
   if f2 and f3 then
    begin
     flagstr:=true;
     exit;
    end;
    flagstr:=not f2;
  end;

 procedure cup(var s:string;var x,x1,x2:byte; var s1,s2:string);
 begin
        x1:=x-1;
        s1:='';
        while  flagstr(s,x1) and (x1>=1) do
         begin
          s1:=s[x1]+s1;
          dec(x1);
         end;

         x2:=x+1;
        s2:='';
        while  flagstr(s,x2) and (x2<=length(s))  do
         begin
          s2:=s2+s[x2];
          inc(x2);
         end;
       end;

procedure arifmetic(var s:string);
  var x,x1,x2:byte;
      s1,s2:string;
      ar,a1,a2:extended;
  begin
  repeat
  x:=pos('*',s);
  if x<>0 then
          begin
           cup(s,x,x1,x2,s1,s2);
           a1:=strtofloat(s1);
           a2:=strtofloat(s2);
           ar:=a1*a2;
           s1:=floattostr(ar);
           s:=concat(copy(s,1,x1),s1,copy(s,x2,length(s)));
          end;
  until x=0;

  repeat
  x:=pos('/',s);
  if x<>0 then
          begin
           cup(s,x,x1,x2,s1,s2);
          a1:=strtofloat(s1);
           a2:=strtofloat(s2);
           ar:=a1/a2;
           s1:=floattostr(ar);
           s:=concat(copy(s,1,x1),s1,copy(s,x2,length(s)));
          end;
  until x=0;

  repeat
  x:=findpos('-',s);
  if x<>0 then
          begin
           cup(s,x,x1,x2,s1,s2);
          a1:=strtofloat(s1);
           a2:=strtofloat(s2);
           ar:=a1-a2;
           s1:=floattostr(ar);
           s:=concat(copy(s,1,x1),s1,copy(s,x2,length(s)));
          end;
  until x=0;

  repeat
  x:=findpos('+',s);
  if x<>0 then
          begin
           cup(s,x,x1,x2,s1,s2);
          a1:=strtofloat(s1);
           a2:=strtofloat(s2);
           ar:=a1+a2;
           s1:=floattostr(ar);
           s:=concat(copy(s,1,x1),s1,copy(s,x2,length(s)));
          end;
  until x=0;
  end;

 function getstr(var s:string;x:byte):string;
  var i,k:byte;
      s1:string;
  begin
  i:=x+1;
  k:=1;
  s1:='';
  repeat
   s1:=s1+s[i];
   inc(i);
   if s[i]='(' then inc(k);
   if s[i]=')' then dec(k);
  until k=0;
  getstr:=s1;
  delete(s,x,length(s1)+2);
  end;

  procedure scob(var s:string);
  var i:byte;
      s1:string;
  begin
   i:=1;
    repeat
     if s[i]='(' then
      begin
       s1:=getstr(s,i);
       {delete(s,i,length(s1));}
       scob(s1);
       calcfun(s1);
       arifmetic(s1);
       s:=concat(copy(s,1,i-1),s1, copy(s,i,length(s) ));
      end;
     inc(i);
    until i>=length(s);
  end;

 procedure calcfun(var s:string);
  var x:byte;
      s1:string;
      ar:extended;
  begin
   x:=pos('sin',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+3);
    scob(s1);
    calcfun(s1);
    delete(s,x,3);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=sin(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('cos',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+3);
    scob(s1);
    calcfun(s1);
    delete(s,x,3);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=cos(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('sqr(',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+3);
    scob(s1);
    calcfun(s1);
    delete(s,x,4);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=sqr(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('exp(',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+3);
    scob(s1);
    calcfun(s1);
    delete(s,x,3);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=exp(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('sqrt',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+4);
    scob(s1);
    calcfun(s1);
    delete(s,x,4);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=sqrt(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('arctan(',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+6);
    scob(s1);
    calcfun(s1);
    delete(s,x,7);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=arctan(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;

     x:=pos('ln(',s);
   if x<>0 then
    begin
    s1:=getstr(s,x+2);
    scob(s1);
    calcfun(s1);
    delete(s,x,3);
    arifmetic(s1);
    ar:=strtofloat(s1);
    ar:=ln(ar);
    s1:=floattostr(ar);
    s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
    end;
  end;

  procedure insertvalue(var s:string;v:tvalues;n:byte);
   var i,x:byte;
       s1:string;
   begin
      for i:=1 to n do
       begin
       while pos(v[i].name,s)<>0 do
       begin
       x:=pos(v[i].name,s);
       delete(s,x,length(v[i].name));
       s1:=floattostr(v[i].a);
       s:=concat(copy(s,1,x-1),s1,copy(s,x,length(s)));
       end;
       end;
   end;


 function formula1(s:string; value:tvalues;num:byte):extended;
  var ar:extended;
  begin
  insertvalue(s,value,num);
  calcfun(s);
  scob(s);
  arifmetic(s);
  ar:=strtofloat(s);
  formula1:=ar;
  end;

 function TFormula.getformula(s:string):extended;
  begin
   getformula:=formula1(s,formulavalue,formulanum);
  end;

end.