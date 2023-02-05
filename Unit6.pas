unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.UIConsts, System.SyncObjs, System.Math,
  System.DateUtils, System.IOUtils, System.ConvUtils, System.Rtti,
  System.IniFiles, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Platform,
  Vcl.Graphics, FMX.Layouts, FMX.TabControl, FMX.Edit, FMX.ComboEdit,
  FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.EditBox,
  FMX.SpinBox, FMX.DialogService.Sync, FMX.Memo.Types, FMX.Memo, FMX.Objects,
  FMX.Effects, FMX.Filter.Effects, FMX.ExtCtrls, FMX.Ani;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    StyleBook1: TStyleBook;
    Timer1: TTimer;
    Label3: TLabel;
    ComboBox3: TComboBox;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Timer2: TTimer;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Grid1: TGrid;
    Layout7: TLayout;
    Label5: TLabel;
    SpinBox1: TSpinBox;
    IntegerColumn1: TIntegerColumn;
    TimeColumn1: TTimeColumn;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    TimeColumn2: TTimeColumn;
    FloatColumn1: TFloatColumn;
    Label6: TLabel;
    StringColumn1: TStringColumn;
    Button5: TButton;
    Layout6: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    Layout8: TLayout;
    Button4: TButton;
    Rectangle1: TRectangle;
    Layout9: TLayout;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel1: TPanel;
    Label7: TLabel;
    Button6: TButton;
    Button1: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Button7: TButton;
    TabItem3: TTabItem;
    Memo2: TMemo;
    Layout5: TLayout;
    Button9: TButton;
    CheckBox2: TCheckBox;
    Button8: TButton;
    TabControl2: TTabControl;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    Layout10: TLayout;
    Button11: TButton;
    Label10: TLabel;
    Grid2: TGrid;
    StringColumn2: TStringColumn;
    IntegerColumn2: TIntegerColumn;
    Label11: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpinBox1Change(Sender: TObject);
    procedure Grid1SetValue(Sender: TObject; const ACol, ARow: Integer;
      const Value: TValue);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure ComboBox5Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button6Click(Sender: TObject);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Grid2GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TRaceInfo = record
    Clock: array [1 .. 100] of TDateTime;
    Speed: array [1 .. 100] of Single;
  end;

  TSectorType = array [0 .. 14] of TValue;
  TSectorInfo = array [0 .. 2] of TSectorType;

var
  Form6: TForm6;
  IsGameRunning: Boolean = False;
  CurrRun, PrevRun: TRaceInfo;
  PrevSectors, CurrSectors: TSectorInfo;
  CurrProgress: Integer;
  CurrClock: TDateTime;
  CurrSpeed: Single;
  DeltaClock: Integer;
  DeltaSpeed: Single;
  SectorClocks: array [0 .. 14] of PValue;
  SectorDeltas: array [0 .. 14] of Integer;
  EventState: Integer = 0;
  ColData: array of TSectorType;
  ColCtrl: TArray<TTimeColumn>;

implementation

{$R *.fmx}

uses
  Unit1, Unit2, Unit3, Unit5;

function GetIniString(Section, Key, Default, FileName: string): string;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  with Ini do
    try
      Result := Ini.ReadString(Section, Key, Default);
    finally
      Free;
    end;
end;

procedure SetIniString(Section, Key, Value, FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  with Ini do
    try
      Ini.WriteString(Section, Key, Value);
    finally
      Free;
    end;
end;

type
  TBitmapForceHalftone = class(Vcl.Graphics.TBitmap)
  protected
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
  end;

  { TBitmapForceHalftone }

procedure TBitmapForceHalftone.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  p: TPoint;
  dc: HDC;
begin
  // not calling inherited; here!
  dc := ACanvas.Handle;
  GetBrushOrgEx(dc, p);
  SetStretchBltMode(dc, HALFTONE);
  SetBrushOrgEx(dc, p.X, p.Y, @p);
  StretchBlt(dc, Rect.Left, Rect.Top, Rect.Right - Rect.Left,
    Rect.Bottom - Rect.Top, Canvas.Handle, 0, 0, Width, Height,
    ACanvas.CopyMode);
end;

type
  TRGBTripleArray = array [Word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBQuadArray = array [Word] of TRGBQuad;
  pRGBQuadArray = ^TRGBQuadArray;

var
  kHook: HHOOK;
  GlobalDC: HDC;
  CaptureBMP, RegionBMP: TBitmapForceHalftone;
  RLines: array of pRGBQuadArray;
  PN, CN, SN1, SN2, SN3: array [0 .. 9] of TBitmap;
  LastProgress: Integer = 0;
  LastClock: TDateTime;

function BitmapColor24(Lines: array of pRGBTripleArray;
  const X, Y, W, H: Integer): TAlphaColor;
var
  I, J: Integer;
  B, G, R: Cardinal;
begin
  B := 0;
  G := 0;
  R := 0;
  for I := 0 to W - 1 do
    for J := 0 to H - 1 do
    begin
      Inc(B, Lines[Y + J][X + I].rgbtBlue);
      Inc(G, Lines[Y + J][X + I].rgbtGreen);
      Inc(R, Lines[Y + J][X + I].rgbtRed);
    end;
  TAlphaColorRec(Result).B := B div (W * H);
  TAlphaColorRec(Result).G := G div (W * H);
  TAlphaColorRec(Result).R := R div (W * H);
  TAlphaColorRec(Result).A := 255;
end;

function BitmapColor32(Lines: array of pRGBQuadArray; const X, Y, W, H: Integer)
  : TAlphaColor;
var
  I, J: Integer;
  B, G, R, A: Cardinal;
begin
  B := 0;
  G := 0;
  R := 0;
  A := 0;
  for I := 0 to W - 1 do
    for J := 0 to H - 1 do
    begin
      Inc(B, Lines[Y + J][X + I].rgbBlue);
      Inc(G, Lines[Y + J][X + I].rgbGreen);
      Inc(R, Lines[Y + J][X + I].rgbRed);
      Inc(A, Lines[Y + J][X + I].rgbReserved);
    end;
  TAlphaColorRec(Result).B := B div (W * H);
  TAlphaColorRec(Result).G := G div (W * H);
  TAlphaColorRec(Result).R := R div (W * H);
  TAlphaColorRec(Result).A := A div (W * H);
end;

function SameColor(Color1, Color2: TAlphaColor; Epsilon: Single)
  : Boolean overload;
var
  R, G, B: Byte;
begin
  R := Max(TAlphaColorRec(Color1).R, TAlphaColorRec(Color2).R) -
    Min(TAlphaColorRec(Color1).R, TAlphaColorRec(Color2).R);
  G := Max(TAlphaColorRec(Color1).G, TAlphaColorRec(Color2).G) -
    Min(TAlphaColorRec(Color1).G, TAlphaColorRec(Color2).G);
  B := Max(TAlphaColorRec(Color1).B, TAlphaColorRec(Color2).B) -
    Min(TAlphaColorRec(Color1).B, TAlphaColorRec(Color2).B);
  Result := ((R + G + B) / (255 * 3)) <= Epsilon;
end;

function SameColor(Color1, Color2: TColor; Epsilon: Single): Boolean overload;
var
  R, G, B: Byte;
begin
  R := Max(TColorRec(Color1).R, TColorRec(Color2).R) - Min(TColorRec(Color1).R,
    TColorRec(Color2).R);
  G := Max(TColorRec(Color1).G, TColorRec(Color2).G) - Min(TColorRec(Color1).G,
    TColorRec(Color2).G);
  B := Max(TColorRec(Color1).B, TColorRec(Color2).B) - Min(TColorRec(Color1).B,
    TColorRec(Color2).B);
  Result := ((R + G + B) / (255 * 3)) <= Epsilon;
end;

function RGBTripleToColor(rgbt: TRGBTriple): TColor;
begin
  TColorRec(Result).B := rgbt.rgbtBlue;
  TColorRec(Result).G := rgbt.rgbtGreen;
  TColorRec(Result).R := rgbt.rgbtRed;
end;

function ColorToRGBTriple(color: TColor): TRGBTriple;
begin
  Result.rgbtBlue := TColorRec(color).B;
  Result.rgbtGreen := TColorRec(color).G;
  Result.rgbtRed := TColorRec(color).R;
end;

function RGBQuadToColor(rgb: TRGBQuad): TColor;
begin
  TColorRec(Result).B := rgb.rgbBlue;
  TColorRec(Result).G := rgb.rgbGreen;
  TColorRec(Result).R := rgb.rgbRed;
  TColorRec(Result).A := rgb.rgbReserved;
end;

function ColorToRGBQuad(color: TColor): TRGBQuad;
begin
  Result.rgbBlue := TColorRec(color).B;
  Result.rgbGreen := TColorRec(color).G;
  Result.rgbRed := TColorRec(color).R;
  Result.rgbReserved := 255;
end;

function BitmapSameSector24(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to SubBMP.Height - 1 do
  begin
    if not CompareMem((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBTriple)), SubBMP.ScanLine[I], SubBMP.Width * SizeOf(TRGBTriple))
    then
      exit;
  end;
  Result := True;
end;

function BitmapSameSector32(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to SubBMP.Height - 1 do
  begin
    if not CompareMem((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBQuad)), SubBMP.ScanLine[I], SubBMP.Width * SizeOf(TRGBQuad))
    then
      exit;
  end;
  Result := True;
end;

function BitmapSameSector24Ex(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer; Epsilon: Single): Boolean;
  function CompareMemEx(P1, P2: Pointer; Length: Integer): Integer;
  var
    A: Integer;
  begin
    Result := 0;
    for A := 0 to Length - 1 do
      Inc(Result, (not((PByte(P1) + A)^ = (PByte(P2) + A)^)).ToInteger);
  end;

var
  I: Integer;
  X: UInt64;
begin
  Result := False;
  X := 0;
  for I := 0 to SubBMP.Height - 1 do
  begin
    Inc(X, CompareMemEx((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBTriple)), SubBMP.ScanLine[I],
      SubBMP.Width * SizeOf(TRGBTriple)));
  end;
  Result := X / (SubBMP.Width * SubBMP.Height) <= Epsilon;
end;

function BitmapSameSector24Ex2(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer): Single;
  function CompareMemEx(P1, P2: Pointer; Length: Integer): Integer;
  var
    A: Integer;
  begin
    Result := 0;
    for A := 0 to Length - 1 do
      Inc(Result, (not((PByte(P1) + A)^ = (PByte(P2) + A)^)).ToInteger);
  end;

var
  I: Integer;
  X: UInt64;
begin
  Result := 1;
  X := 0;
  for I := 0 to SubBMP.Height - 1 do
  begin
    Inc(X, CompareMemEx((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBTriple)), SubBMP.ScanLine[I],
      SubBMP.Width * SizeOf(TRGBTriple)));
  end;
  Result := X / (SubBMP.Width * SubBMP.Height);
end;

function BitmapSameSector32Ex(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer; Epsilon: Single): Boolean;
  function CompareMemEx(P1, P2: Pointer; Length: Integer): Integer;
  var
    A: Integer;
  begin
    Result := 0;
    for A := 0 to Length - 1 do
      Inc(Result, (not((PByte(P1) + A)^ = (PByte(P2) + A)^)).ToInteger);
  end;

var
  I: Integer;
  X: UInt64;
begin
  Result := False;
  X := 0;
  for I := 0 to SubBMP.Height - 1 do
  begin
    Inc(X, CompareMemEx((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBQuad)), SubBMP.ScanLine[I], SubBMP.Width * SizeOf(TRGBQuad)));
  end;
  Result := X / (SubBMP.Width * SubBMP.Height) <= Epsilon;
end;

function BitmapSameSector32Ex2(MainBMP, SubBMP: Vcl.Graphics.TBitmap;
  PosX, PosY: Integer): Single;
  function CompareMemEx(P1, P2: Pointer; Length: Integer): Integer;
  var
    A: Integer;
  begin
    Result := 0;
    for A := 0 to Length - 1 do
      Inc(Result, (not((PByte(P1) + A)^ = (PByte(P2) + A)^)).ToInteger);
  end;

var
  I: Integer;
  X: UInt64;
begin
  Result := 1;
  X := 0;
  for I := 0 to SubBMP.Height - 1 do
  begin
    Inc(X, CompareMemEx((PByte(MainBMP.ScanLine[I + PosY]) + PosX *
      SizeOf(TRGBQuad)), SubBMP.ScanLine[I], SubBMP.Width * SizeOf(TRGBQuad)));
  end;
  Result := X / (SubBMP.Width * SubBMP.Height);
end;

function MinValue(const Data: array of Single; var Index: Integer): Single;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  Index := Low(Data);
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then
    begin
      Result := Data[I];
      Index := I;
    end;
end;

function MaxValue(const Data: array of Single; var Index: Integer): Single;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  Index := Low(Data);
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
    begin
      Result := Data[I];
      Index := I;
    end;
end;

procedure CaptureScreen;
  function IsWhite(C: TAlphaColor): Boolean;
  begin
    Result := (TAlphaColorRec(C).R in [255]) and
      (TAlphaColorRec(C).R = TAlphaColorRec(C).G) and
      (TAlphaColorRec(C).R = TAlphaColorRec(C).B);
  end;

var
  I, J: Integer;
begin
  // (211 * GetSystemMetrics(1)) div ResHeight
  //
  I := (GetSystemMetrics(0) div 2) - ((ResWidth div 2) * GetSystemMetrics(1))
    div ResHeight;
  if I < 0 then
    I := 0;
  BitBlt(CaptureBMP.Canvas.Handle, 0, 0, CaptureBMP.Width, CaptureBMP.Height,
    GlobalDC, ((I + 43) * GetSystemMetrics(1)) div ResHeight,
    (54 * GetSystemMetrics(1)) div ResHeight, SRCCOPY);
  CaptureBMP.PixelFormat := pf8bit;
  CaptureBMP.PixelFormat := pf32bit;
  CaptureBMP.Draw(RegionBMP.Canvas, Rect(0, 0, RegionBMP.Width,
    RegionBMP.Height));
  for I := 0 to RegionBMP.Width - 1 do
    for J := 0 to RegionBMP.Height - 1 do
    begin
      if IsWhite(RGBQuadToColor(RLines[J][I]))
      { SameColor(RGBQuadToColor(RLines[J][I]), clWhite, 0.0125) } then
        RLines[J][I] := ColorToRGBQuad(clWhite)
      else
        RLines[J][I] := ColorToRGBQuad(clBlack);
    end;
end;

function GetProgress: Integer;
const
  CheckVal = 0.15;
var
  I, J: Integer;
  X: Integer;
  S: Single;
  Checks: array [0 .. 1] of Boolean;
  Values: array [0 .. 9] of Single;
begin
  Result := -1;
  for I := Low(Checks) to High(Checks) do
    Checks[I] := False;
  X := 0;
  for J := Low(Checks) to High(Checks) do
  begin
    for I := Low(PN) to High(PN) do
      Values[I] := BitmapSameSector32Ex2(RegionBMP, PN[I], 47 * J, 0);
    S := MinValue(Values, I);
    if S <= CheckVal then
    begin
      X := X + I * Round(Power(10, High(Checks) - J));
      Checks[J] := True;
    end
    else
      exit;
  end;
  if X = 10 then
    if BitmapSameSector32Ex(RegionBMP, PN[0], 47 * 2, 0, CheckVal) then
      X := 100;
  Result := X;
end;

function GetClock: TDateTime;
const
  CheckVal = 0.5;
var
  I, J: Integer;
  X, Y, Z: Integer;
  S: Single;
  Checks: array [0 .. 2] of Boolean;
  Values: array [0 .. 9] of Single;
begin
  Result := -1;
  for I := Low(Checks) to High(Checks) do
    Checks[I] := False;
  X := 0;
  for J := Low(Checks) to Pred(High(Checks)) do
  begin
    for I := Low(CN) to High(CN) do
      Values[I] := BitmapSameSector32Ex2(RegionBMP, CN[I], 27 * J, 74);
    S := MinValue(Values, I);
    if S <= CheckVal then
    begin
      X := X + I * Round(Power(10, Pred(High(Checks)) - J));
      Checks[J] := True;
    end
    else
      exit;
  end;
  for I := Low(Checks) to High(Checks) do
    Checks[I] := False;
  Y := 0;
  for J := Low(Checks) to Pred(High(Checks)) do
  begin
    for I := Low(CN) to High(CN) do
      Values[I] := BitmapSameSector32Ex2(RegionBMP, CN[I], 65 + 27 * J, 74);
    S := MinValue(Values, I);
    if S <= CheckVal then
    begin
      Y := Y + I * Round(Power(10, Pred(High(Checks)) - J));
      Checks[J] := True;
    end
    else
      exit;
  end;
  for I := Low(Checks) to High(Checks) do
    Checks[I] := False;
  Z := 0;
  for J := Low(Checks) to High(Checks) do
  begin
    for I := Low(CN) to High(CN) do
      Values[I] := BitmapSameSector32Ex2(RegionBMP, CN[I], 130 + 27 * J, 74);
    S := MinValue(Values, I);
    if S <= CheckVal then
    begin
      Z := Z + I * Round(Power(10, High(Checks) - J));
      Checks[J] := True;
    end
    else
      exit;
  end;
  try
    Result := EncodeTime(0, X, Y, Z);
  except
  end;
end;

procedure CaptureInfo;
begin
  CaptureScreen;
  CurrProgress := GetProgress;
  CurrClock := GetClock;
  { Form1.Label26.Text := CurrProgress.ToString + ' - ' + TimeToStr(CurrClock);
    if CurrClock <> -1 then
    begin
    RegionBMP.SaveToFile('hmm.bmp');
    Halt;
    end; }
  { case Form6.ComboBox3.ItemIndex of
    0:
    CurrSpeed := IfThen(Form6.ComboBox2.ItemIndex = 0, GetSpeedA, GetSpeedM) *
    IfThen(Form6.ComboBox1.ItemIndex = 0, 1, 1.609);
    1:
    CurrSpeed := GetSpeedO * IfThen(Form6.ComboBox1.ItemIndex = 0, 1, 1.609);
    end; }
end;

procedure CalculateRaceInfo(Progress: Integer);
begin
  if not InRange(Progress, Low(CurrRun.Clock), High(CurrRun.Clock)) then
    exit;
  if (PrevRun.Clock[High(PrevRun.Clock)] = -1) or
    (CurrRun.Clock[Low(CurrRun.Clock)] = -1) then
  begin
    DeltaClock := 0;
    DeltaSpeed := 0;
  end
  else
  begin
    DeltaClock := MilliSecondOfTheDay(CurrRun.Clock[Progress]) -
      MilliSecondOfTheDay(PrevRun.Clock[Progress]);
    DeltaSpeed := PrevRun.Speed[Progress] - CurrRun.Speed[Progress];
  end;
end;

procedure CalculateSectorInfo(Progress: Integer);
var
  I, X: Integer;
begin
  I := Form6.Grid1.RowCount - 1;
  if I < 0 then
    exit;
  if (PrevSectors[2, I].AsType<TDateTime> = -1) then
    exit;
  if not InRange(Progress, Low(CurrRun.Clock), High(CurrRun.Clock)) then
    exit;
  try
    for I := Low(CurrSectors[0]) to High(CurrSectors[0]) do
      if Progress = PrevSectors[1, I].ToString.ToInteger then
      begin
        if I = Low(CurrSectors[0]) then
          SectorDeltas[I] := MilliSecondOfTheDay
            (CurrSectors[2, I].AsType<TDateTime>) -
            MilliSecondOfTheDay(PrevSectors[2, I].AsType<TDateTime>)
        else
          SectorDeltas[I] :=
            (MilliSecondOfTheDay(CurrSectors[2, I].AsType<TDateTime>) -
            MilliSecondOfTheDay(CurrSectors[2, Pred(I)].AsType<TDateTime>)) -
            (MilliSecondOfTheDay(PrevSectors[2, I].AsType<TDateTime>) -
            MilliSecondOfTheDay(PrevSectors[2, Pred(I)].AsType<TDateTime>));
      end;
  except
  end;
end;

procedure UpdateInfo(Progress: Integer);
var
  I: Integer;
begin
  if not InRange(Progress, Low(CurrRun.Clock), High(CurrRun.Clock)) then
    exit;
  if (CurrRun.Clock[Progress] = -1) then
    CurrRun.Clock[Progress] := CurrClock;
  if (CurrRun.Speed[Progress] = -1) then
    CurrRun.Speed[Progress] := CurrSpeed;
  try
    for I := Low(CurrSectors[0]) to High(CurrSectors[0]) do
      if (Progress = PrevSectors[1, I].ToString.ToInteger) then
      begin
        if (CurrSectors[2, I].AsType<TDateTime> = -1) then
          CurrSectors[2, I] := CurrClock;
        break;
      end;
  except
  end;
end;

procedure UpdateSectorInfo(Progress: Integer);

begin
  if not InRange(Progress, Low(CurrRun.Clock), High(CurrRun.Clock)) then
    exit;

end;

procedure ResetRaceInfo(var RaceInfo: TRaceInfo);
var
  I: Integer;
begin
  for I := Low(RaceInfo.Clock) to High(RaceInfo.Clock) do
  begin
    RaceInfo.Clock[I] := -1;
    RaceInfo.Speed[I] := -1;
  end;
end;

procedure ResetSectorInfo(var SectorInfo: TSectorInfo);
var
  I: Integer;
begin
  for I := Low(SectorInfo[0]) to High(SectorInfo[0]) do
    SectorInfo[2, I] := -1;
end;

procedure StoreRaceInfo;
var
  I: Integer;
begin
  I := High(PrevRun.Clock);
  if CurrRun.Clock[I] = -1 then
    exit;
  if (PrevRun.Clock[I] = -1) or
    ((MilliSecondOfTheDay(PrevRun.Clock[I]) > MilliSecondOfTheDay(CurrRun.Clock
    [I])) and Form6.CheckBox1.IsChecked) then
    Move(CurrRun, PrevRun, SizeOf(TRaceInfo));
end;

procedure StoreSectorInfo;
var
  I: Integer;
begin
  I := Form6.Grid1.RowCount - 1;
  if I < 0 then
    exit;
  if CurrSectors[2, I].AsType<TDateTime> = -1 then
    exit;
  if (PrevSectors[2, I].AsType<TDateTime> = -1) or
    ((MilliSecondOfTheDay(PrevSectors[2, I].AsType<TDateTime>) >
    MilliSecondOfTheDay(CurrSectors[2, I].AsType<TDateTime>)) and
    Form6.CheckBox1.IsChecked) then
  begin
    Form6.Grid1.BeginUpdate;
    Move(CurrSectors, PrevSectors, SizeOf(TSectorInfo));
    Form6.Grid1.EndUpdate;
  end;
end;

procedure CalculateOptTime;
var
  I, J, K: Integer;
  X, Y, Z: Integer;
begin
  X := 0;
  if Length(ColData) > 0 then
  begin
    for I := Low(ColData[0]) to High(ColData[0]) do
    begin
      Y := Y.MaxValue;
      for J := Low(ColData) to High(ColData) do
        for K := Low(ColData[J]) to High(ColData[J]) do
          if I = K then
            if ColData[J, K].AsType<TDateTime> <> -1 then
            begin
              if K = Low(ColData[J]) then
                Z := MilliSecondOfTheDay(ColData[J, K].AsType<TDateTime>)
              else
                Z := MilliSecondOfTheDay(ColData[J, K].AsType<TDateTime>) -
                  MilliSecondOfTheDay(ColData[J, Pred(K)].AsType<TDateTime>);
              if Z < Y then
                Y := Z;
            end;
      if Y <> Y.MaxValue then
        Inc(X, Y);
    end;
  end;
  Form6.Label11.Text := Format('%0:.2d:%1:.2d.%2:.3d',
    [(X div 60000) mod 60, (X div 1000) mod 60, X mod 1000]);
end;

procedure RefreshList;
var
  I: Integer;
  LList: TStringDynArray;
begin
  Form6.ComboBox4.Items.Clear;
  LList := TDirectory.GetFiles(ExtractFilePath(ParamStr(0)) + 'saved_runs\' +
    Form6.ComboBox5.Selected.Text);
  for I := Low(LList) to High(LList) do
    Form6.ComboBox4.Items.Add(ExtractFileName(LList[I]));
end;

procedure TForm6.Button11Click(Sender: TObject);
begin
  TabControl2.TabIndex := 0;
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  Grid1.BeginUpdate;
  Grid2.BeginUpdate;
  for I := Low(ColData) to High(ColData) do
    ColCtrl[I].Free;
  SetLength(ColData, 0);
  SetLength(ColCtrl, 0);
  CurrProgress := -1;
  CurrClock := -1;
  CurrSpeed := -1;
  ResetRaceInfo(PrevRun);
  ResetRaceInfo(CurrRun);
  ResetSectorInfo(PrevSectors);
  ResetSectorInfo(CurrSectors);
  for I := Low(PrevSectors[0]) to High(PrevSectors[0]) do
    SectorDeltas[I] := SectorDeltas[I].MinValue;
  Grid1.EndUpdate;
  Grid2.EndUpdate;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
end;

procedure TForm6.Button3Click(Sender: TObject);
var
  I, J: Integer;
  D: TDateTime;
  Category, FileName: String;
  M: TModalResult;
begin
  Form5.Edit1.Text := '';
  Form5.Button7.Text := TimeToStr(PrevSectors[2, Pred(Grid1.RowCount)
    ].AsType<TDateTime>);
  Form5.Button7.Enabled := PrevSectors[2, Pred(Grid1.RowCount)
    ].AsType<TDateTime> <> -1;
  Form5.Button2.Text := TimeToStr(CurrSectors[2, Pred(Grid1.RowCount)
    ].AsType<TDateTime>);
  Form5.Button2.Enabled := CurrSectors[2, Pred(Grid1.RowCount)
    ].AsType<TDateTime> <> -1;
  M := Form5.ShowModal;
  if (M in [mrYes, mrNo]) and (Form5.Edit1.Text = '') then
  begin
    ShowMessage('Please specify run name');
    exit;
  end;
  if (M in [mrYes, mrNo]) then
  begin
    Category := Form5.ComboBox5.Selected.Text;
    FileName := Form5.Edit1.Text;
    if ComboBox5.Items.IndexOf(Category) < 0 then
    begin
      ShowMessage('Invalid race discipline');
      exit;
    end;
    with TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'saved_runs\' +
      Category + '\' + FileName, fmCreate) do
    begin
      I := Round(SpinBox1.Value);
      WriteBuffer(I, I.Size);
      if M = mrYes then
      begin
        WriteBuffer(PrevRun, SizeOf(TRaceInfo));
        for I := 0 to Grid1.RowCount - 1 do
        begin
          J := PrevSectors[1, I].ToString.ToInteger;
          WriteBuffer(J, J.Size);
          D := PrevSectors[2, I].AsType<TDateTime>;
          WriteBuffer(D, SizeOf(TDateTime));
        end;
      end
      else
      begin
        WriteBuffer(CurrRun, SizeOf(TRaceInfo));
        for I := 0 to Grid1.RowCount - 1 do
        begin
          J := CurrSectors[1, I].ToString.ToInteger;
          WriteBuffer(J, J.Size);
          D := CurrSectors[2, I].AsType<TDateTime>;
          WriteBuffer(D, SizeOf(TDateTime));
        end;
      end;
      Free;
    end;
    ComboBox5.ItemIndex := ComboBox5.Items.IndexOf(Category);
    RefreshList;
    ComboBox4.ItemIndex := ComboBox4.Items.IndexOf(FileName);
  end;
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
end;

procedure TForm6.Button5Click(Sender: TObject);
var
  L: TDialogServiceSync;
  S: String;
begin
  L := TDialogServiceSync.Create;
  try
    if L.MessageDialog('Are you sure you want to delete ' +
      ComboBox4.Selected.Text + '?', TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbYes, 0) = mrYes then
    begin
      S := ExtractFilePath(ParamStr(0)) + 'saved_runs\' +
        Form6.ComboBox5.Selected.Text + '\' + Form6.ComboBox4.Selected.Text;
      DeleteFile(S);
      RefreshList;
    end;
  finally
    L.Free;
  end;
end;

procedure TForm6.Button6Click(Sender: TObject);
begin
  Close;
end;

procedure TForm6.Button7Click(Sender: TObject);
begin
  ShellExecute(0, 'open', Pchar('https://paypal.me/razor326f'), '', '',
    SW_SHOWNORMAL);
end;

procedure TForm6.Button8Click(Sender: TObject);
begin
  TabControl2.TabIndex := 1;
end;

procedure TForm6.CheckBox2Change(Sender: TObject);
begin
  Button9.Enabled := CheckBox2.IsChecked;
end;

procedure TForm6.ComboBox4Change(Sender: TObject);
var
  I, J: Integer;
  D: TDateTime;
  S: String;
begin
  Button5.Enabled := ComboBox4.ItemIndex >= 0;
  if ComboBox4.ItemIndex < 0 then
    exit;
  SpinBox1.Value := 6;
  SpinBox1Change(nil);
  S := ExtractFilePath(ParamStr(0)) + 'saved_runs\' +
    Form6.ComboBox5.Selected.Text + '\' + Form6.ComboBox4.Selected.Text;
  with TFileStream.Create(S, fmShareDenyNone) do
    try
      Grid1.BeginUpdate;
      Grid2.BeginUpdate;
      ResetRaceInfo(PrevRun);
      ResetRaceInfo(CurrRun);
      ResetSectorInfo(PrevSectors);
      ResetSectorInfo(CurrSectors);
      for I := Low(PrevSectors[0]) to High(PrevSectors[0]) do
        SectorDeltas[I] := SectorDeltas[I].MinValue;
      ReadBuffer(I, I.Size);
      SpinBox1.Value := I;
      ReadBuffer(PrevRun, SizeOf(TRaceInfo));
      for I := 0 to Grid1.RowCount - 1 do
      begin
        ReadBuffer(J, J.Size);
        PrevSectors[1, I] := J;
        CurrSectors[1, I] := J;
        ReadBuffer(D, SizeOf(TDateTime));
        PrevSectors[2, I] := D;
      end;
      { EventState := 0;
        LastProgress := 0;
        LastClock := -1; }
    finally
      Free;
      Grid1.EndUpdate;
      Grid2.EndUpdate;
    end;
end;

procedure TForm6.ComboBox5Change(Sender: TObject);
begin
  RefreshList;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  if ScrScale <> 1 then
    ShowMessage('Unsupported screen scaling, set to 100% and try again!');
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  RemoveFontResource(Pchar(ExtractFilePath(ParamStr(0)) +
    'resources\HurmeGeometricSans3Regular.otf'));
  RemoveFontResource(Pchar(ExtractFilePath(ParamStr(0)) +
    'resources\HurmeGeometricSans3Black.otf'));
  if CheckBox2.IsChecked then
  begin
    if RadioButton1.IsChecked then
      SetIniString('Config', 'Clock', '0', ChangeFileExt(ParamStr(0), '.ini'));
    if RadioButton3.IsChecked then
      SetIniString('Config', 'Clock', '1', ChangeFileExt(ParamStr(0), '.ini'));
    if RadioButton4.IsChecked then
      SetIniString('Config', 'Clock', '2', ChangeFileExt(ParamStr(0), '.ini'));
  end;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  if not FileExists(ChangeFileExt(ParamStr(0), '.ini')) then
    TabControl1.TabIndex := 2
  else
  begin
    TabControl1.TabIndex := 0;
    CheckBox2.IsChecked := True;
    case GetIniString('Config', 'Clock', '0', ChangeFileExt(ParamStr(0), '.ini')
      ).ToInteger of
      0:
        RadioButton1.IsChecked := True;
      1:
        RadioButton3.IsChecked := True;
      2:
        RadioButton4.IsChecked := True;
    end;
  end;
  Form6.ClientWidth := 580 * 540 div 420;
  Form6.ClientHeight := 540;
  Form6.Left := GetSystemMetrics(0) div 2 - Form6.ClientWidth div 2;
  Form6.Top := GetSystemMetrics(1) div 2 - Form6.ClientHeight div 2;
  Rectangle1.Scale.X := Form6.ClientHeight / 420;
  Rectangle1.Scale.Y := Form6.ClientHeight / 420;
  RefreshList;
  Timer2Timer(nil);
  SpinBox1Change(nil);
  ComboBox4Change(nil);
end;

procedure TForm6.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
begin
  if ACol in [0 .. 2] then
    Value := PrevSectors[ACol, ARow]
  else if ACol in [3] then
    Value := CurrSectors[ACol - 1, ARow]
  else if ACol in [4] then
    Value := IfThen(SectorDeltas[ARow] = SectorDeltas[ARow].MinValue, 0,
      SectorDeltas[ARow]) / 1000;
end;

procedure TForm6.Grid1SetValue(Sender: TObject; const ACol, ARow: Integer;
  const Value: TValue);
begin
  if ACol in [1 .. 2] then
  begin
    ComboBox4.ItemIndex := -1;
    PrevSectors[ACol, ARow] := Value;
    if ACol <> 2 then
      CurrSectors[ACol, ARow] := Value;
  end;
end;

procedure TForm6.Grid2GetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
begin
  if ACol in [0, 1] then
    Value := PrevSectors[ACol, ARow]
  else
    Value := ColData[ACol - 2, ARow];
end;

procedure TForm6.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  Ani: TAnimator;
begin
  Ani := TAnimator.Create;
  try
    Ani.AnimateColor(Rectangle1, 'Fill.Color', $40002B49);
    StartWindowDrag;
  finally
    Ani.Free;
  end;
end;

procedure TForm6.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  Ani: TAnimator;
begin
  Ani := TAnimator.Create;
  try
    Ani.AnimateColor(Rectangle1, 'Fill.Color', $FF002B49);
  finally
    Ani.Free;
  end;
end;

procedure TForm6.SpinBox1Change(Sender: TObject);
var
  I, J: Integer;
begin
  Grid1.Enabled := SpinBox1.Value > 0;
  Grid2.Enabled := SpinBox1.Value > 0;
  Grid1.BeginUpdate;
  Grid2.BeginUpdate;
  for I := Low(ColData) to High(ColData) do
    ColCtrl[I].Free;
  SetLength(ColData, 0);
  SetLength(ColCtrl, 0);
  J := Round(SpinBox1.Value);
  for I := 0 to J - 1 do
  begin
    if I = J - 1 then
      PrevSectors[0, I] := 'Finish'
    else
      PrevSectors[0, I] := 'S' + Succ(I).ToString;
    PrevSectors[1, I] := Round(100 / J * Succ(I));
    PrevSectors[2, I] := -1;
    CurrSectors[0, I] := PrevSectors[0, I];
    CurrSectors[1, I] := PrevSectors[1, I];
  end;
  Grid1.RowCount := J;
  Grid2.RowCount := J;
  Grid1.EndUpdate;
  Grid2.EndUpdate;
end;

{ 8 1:32.399
  18 3:55.260
  27 5:53.161
  37 8:00.623
  41 9:03.592
  48 10:32.637
  56 12:25.577
  66 14:24.126
  73 16:02.773
  80 18:00.795
  86 19:38.321
  89 20:27.775
  93 21:24.836
  95 21:55.481
  100 22:54.100
  NY sectors for doggerbot's WR run }

procedure TForm6.Timer1Timer(Sender: TObject);
var
  I: Integer;
  X, Y: Integer;
begin
  if TabControl1.TabIndex = 2 then
    exit;
  CaptureInfo;
  if EventState = 1 then
  begin
    EventState := 2;
    Grid2.BeginUpdate;
    Insert(CurrSectors[2], ColData, Length(ColData));
    I := Length(ColCtrl);
    Insert(TTimeColumn.Create(Form6), ColCtrl, Length(ColCtrl));
    ColCtrl[I].Parent := Grid2;
    ColCtrl[I].Header := 'Run ' + Succ(I).ToString;
    ColCtrl[I].HorzAlign := TTextAlign.Center;
    ColCtrl[I].ReadOnly := True;
    ColCtrl[I].Width := 100;
    Grid2.EndUpdate;
    CalculateOptTime;
    if (SectorClocks[Pred(Form6.Grid1.RowCount)]^.AsType<TDateTime> <> -1) and
      ((MilliSecondOfTheDay(SectorClocks[Pred(Form6.Grid1.RowCount)
      ]^.AsType<TDateTime>) < MilliSecondOfTheDay(PrevRun.Clock
      [High(PrevRun.Clock)])) or (PrevRun.Clock[High(PrevRun.Clock)] = -1)) then
    begin
      X := 0;
      for I := 0 to Form6.Grid1.RowCount - 1 do
      begin
        if SectorDeltas[I] <> SectorDeltas[I].MinValue then
          Inc(X, SectorDeltas[I]);
      end;
      Y := MilliSecondOfTheDay(SectorClocks[Pred(Form6.Grid1.RowCount)
        ]^.AsType<TDateTime>);
    end
    else
    begin
      X := DeltaClock;
      Y := MilliSecondOfTheDay(PrevRun.Clock[High(PrevRun.Clock)]);
    end;
    Form3.Rectangle1.Fill.color :=
      IfThen(X <= 0, IfThen(X = 0, $FFC3C3C3, $FF25EA7E), $FFFA1043);
    Form3.Label2.Text := IfThen(X <= 0, '-', '+') +
      FormatFloat('0.00', Abs(X / 1000));
    if X < 0 then
      Form3.Label1.Text := 'IMPROVED TIME BY'
    else if X > 0 then
      Form3.Label1.Text := 'FAILED TO BEAT TIME';
    if X <> 0 then
    begin
      Form3.OnShow(nil);
      Sleep(2000);
      Form3.Visible := True;
      Form3.Timer1.Enabled := True;
    end;
  end;
  if (CurrProgress <> -1) and (CurrProgress < LastProgress) then
  begin
    if (CurrSectors[2, 0].AsType<TDateTime> <> -1) and
      (LastProgress <> High(CurrRun.Clock)) then
    begin
      Grid2.BeginUpdate;
      Insert(CurrSectors[2], ColData, Length(ColData));
      I := Length(ColCtrl);
      Insert(TTimeColumn.Create(Form6), ColCtrl, Length(ColCtrl));
      ColCtrl[I].Parent := Grid2;
      ColCtrl[I].Header := 'Run ' + Succ(I).ToString;
      ColCtrl[I].HorzAlign := TTextAlign.Center;
      ColCtrl[I].ReadOnly := True;
      ColCtrl[I].Width := 100;
      Grid2.EndUpdate;
      CalculateOptTime;
    end;
    if (LastProgress = High(CurrRun.Clock)) and CheckBox1.IsChecked then
    begin
      StoreRaceInfo;
      StoreSectorInfo;
    end;
    EventState := 0;
    LastProgress := 0;
    LastClock := -1;
    ResetRaceInfo(CurrRun);
    ResetSectorInfo(CurrSectors);
    for I := Low(PrevSectors[0]) to High(PrevSectors[0]) do
      SectorDeltas[I] := SectorDeltas[I].MinValue;
    // event restart
  end;
  UpdateInfo(CurrProgress);
  if InRange(CurrProgress, Low(CurrRun.Clock), High(CurrRun.Clock)) then
    LastProgress := CurrProgress;
  CalculateRaceInfo(CurrProgress);
  CalculateSectorInfo(CurrProgress);
  if (LastProgress = High(CurrRun.Clock)) and (CurrProgress = -1) then
  begin
    Grid1.BeginUpdate;
    if EventState = 0 then
      EventState := 1;
    { ResetRaceInfo(CurrRun);
      ResetSectorInfo(CurrSectors);
      for I := Low(PrevSectors[0]) to High(PrevSectors[0]) do
      SectorDeltas[I] := SectorDeltas[I].MinValue; }
    Grid1.EndUpdate;
    // event finished
  end;
end;

procedure TForm6.Timer2Timer(Sender: TObject);
begin
  if TabControl1.TabIndex = 2 then
    exit;
  IsGameRunning := FindWindow('WndClassTheCrew', 'TheCrew2') <> 0;
  if IsGameRunning then
    Label9.Text := 'Game found'
  else
    Label9.Text := 'Game not detected';
  Timer1.Enabled := IsGameRunning;
  Form1.Visible := IsGameRunning and (CurrProgress <> -1);
end;

var
  I: Integer;

initialization

GlobalDC := GetWindowDC(GetDesktopWindow { FindWindow('WndClassTheCrew',
    'TheCrew2') } );

CaptureBMP := TBitmapForceHalftone.Create((211 * GetSystemMetrics(1))
  div ResHeight, (973 * GetSystemMetrics(1)) div ResHeight);
CaptureBMP.PixelFormat := pf32bit;
RegionBMP := TBitmapForceHalftone.Create(211, 973);
RegionBMP.PixelFormat := pf32bit;
SetLength(RLines, RegionBMP.Height);
for I := Low(RLines) to High(RLines) do
  RLines[I] := RegionBMP.ScanLine[I];

for I := Low(PN) to High(PN) do
begin
  PN[I] := TBitmap.Create;
  PN[I].LoadFromFile('resources\progress\' + I.ToString + '.bmp');
end;

for I := Low(CN) to High(CN) do
begin
  CN[I] := TBitmap.Create;
  CN[I].LoadFromFile('resources\clock\' + I.ToString + '.bmp');
end;

for I := Low(SN1) to High(SN1) do
begin
  SN1[I] := TBitmap.Create;
  SN1[I].LoadFromFile('resources\speed_auto\' + I.ToString + '.bmp');
end;

for I := Low(SN2) to High(SN2) do
begin
  SN2[I] := TBitmap.Create;
  SN2[I].LoadFromFile('resources\speed_manual\' + I.ToString + '.bmp');
end;

for I := Low(SN3) to High(SN3) do
begin
  SN3[I] := TBitmap.Create;
  SN3[I].LoadFromFile('resources\speed_other\' + I.ToString + '.bmp');
end;

CurrProgress := -1;
CurrClock := -1;
CurrSpeed := -1;
ResetRaceInfo(CurrRun);
ResetRaceInfo(PrevRun);
ResetSectorInfo(CurrSectors);
ResetSectorInfo(PrevSectors);
for I := Low(PrevSectors[0]) to High(PrevSectors[0]) do
begin
  SectorClocks[I] := @PrevSectors[2, I];
  SectorDeltas[I] := SectorDeltas[I].MinValue;
end;

end.
