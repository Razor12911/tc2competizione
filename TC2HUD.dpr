program TC2HUD;

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

uses
  Unit2 in 'Unit2.pas',
  WinAPI.Windows,
  System.StartUpCopy,
  System.SysUtils,
  FMX.Forms,
  Unit6 in 'Unit6.pas' {Form6} ,
  Unit1 in 'Unit1.pas' {Form1} ,
  Unit3 in 'Unit3.pas' {Form3} ,
  Unit5 in 'Unit5.pas' {Form5};

{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED}
{$R *.res}

begin
  FormatSettings := TFormatSettings.Invariant;
  FormatSettings.ShortTimeFormat := 'nn:ss.zzz';
  FormatSettings.LongTimeFormat := 'nn:ss.zzz';
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.Run;

end.
