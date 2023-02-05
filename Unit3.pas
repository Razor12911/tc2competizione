unit Unit3;

interface

uses
  WinAPI.Windows,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TForm3 = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

uses Unit2;

procedure TForm3.FormHide(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Left := 0;
  Top := 0;
  Layout1.Height := (52 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Width := (592 * GetSystemMetrics(1)) / ResHeight;
  Rectangle1.Width := (152 * GetSystemMetrics(1)) / ResHeight;
  Label1.Font.Size := (40 * GetSystemMetrics(1)) / ResHeight;
  Label2.Font.Size := (40 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Position.X := GetSystemMetrics(0) div 2 - Layout1.Width / 2;
  Layout1.Position.Y := GetSystemMetrics(1) div 2 - Layout1.Height / 2;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  Visible := False;
  Timer1.Enabled := False;
end;

end.
