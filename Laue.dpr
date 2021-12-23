program Laue;

uses
  Forms,
  base in 'base.pas' {Form1},
  Wulf in 'Wulf.pas',
  LauGram in 'LauGram.pas' {Form2},
  WideWulf in 'WideWulf.pas' {Form3},
  Options in 'Options.pas' {Form4},
  Setting in 'Setting.pas' {Form5},
  Additional in 'Additional.pas' {Form6},
  about in 'about.pas' {Form7};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
