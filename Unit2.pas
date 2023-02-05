unit Unit2;

interface

uses
  WinAPI.Windows, System.SysUtils, FMX.Platform;

var
  ResWidth: Integer = 1920;
  ResHeight: Integer = 1080;
  ScrScale: Single = 1;

implementation

var
  ScrService: IFMXScreenService;

initialization

if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService,
  ScrService) then
begin
  ScrScale := ScrService.GetScreenScale;
  ResWidth := 1920;
  ResHeight := 1080;
end;
AddFontResourceW(PChar(ExtractFilePath(ParamStr(0)) +
  'resources\HurmeGeometricSans3Regular.otf'));
AddFontResourceW(PChar(ExtractFilePath(ParamStr(0)) +
  'resources\HurmeGeometricSans3Black.otf'));

finalization

RemoveFontResource(PChar(ExtractFilePath(ParamStr(0)) +
  'resources\HurmeGeometricSans3Regular.otf'));
RemoveFontResource(PChar(ExtractFilePath(ParamStr(0)) +
  'resources\HurmeGeometricSans3Black.otf'));

end.
