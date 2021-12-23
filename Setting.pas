unit Setting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    min: TLabel;
    max: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses base, WideWulf;

{$R *.DFM}

procedure TForm5.Button1Click(Sender: TObject);
begin
Visible:=false ;
form3.refresh;
end;

procedure TForm5.TrackBar1Change(Sender: TObject);
begin
     size:=200+(10-TrackBar1.Position)*18;
end;

end.
