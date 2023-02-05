unit Unit1;

interface

uses
  WinAPI.Windows,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.DateUtils, System.Math, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Platform.Win, FMX.Objects,
  FMX.Effects, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Ani, FMX.Layouts;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Layout2: TLayout;
    Label3: TLabel;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Layout6: TLayout;
    Rectangle6: TRectangle;
    Label10: TLabel;
    Label11: TLabel;
    Layout7: TLayout;
    Rectangle7: TRectangle;
    Label12: TLabel;
    Label13: TLabel;
    Layout8: TLayout;
    Rectangle8: TRectangle;
    Label14: TLabel;
    Label15: TLabel;
    Layout9: TLayout;
    Rectangle9: TRectangle;
    Label16: TLabel;
    Label17: TLabel;
    Layout10: TLayout;
    Rectangle10: TRectangle;
    Label18: TLabel;
    Label19: TLabel;
    Layout11: TLayout;
    Rectangle11: TRectangle;
    Label20: TLabel;
    Label21: TLabel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    Label6: TLabel;
    Rectangle19: TRectangle;
    Label7: TLabel;
    Rectangle20: TRectangle;
    Label8: TLabel;
    Rectangle21: TRectangle;
    Label9: TLabel;
    Rectangle22: TRectangle;
    Label22: TLabel;
    Rectangle23: TRectangle;
    Label23: TLabel;
    Rectangle24: TRectangle;
    Label24: TLabel;
    Rectangle25: TRectangle;
    Label25: TLabel;
    Label26: TLabel;
    Layout4: TLayout;
    Rectangle26: TRectangle;
    Label27: TLabel;
    Rectangle27: TRectangle;
    Label28: TLabel;
    Rectangle28: TRectangle;
    Label29: TLabel;
    Layout5: TLayout;
    Rectangle29: TRectangle;
    Label30: TLabel;
    Rectangle30: TRectangle;
    Label31: TLabel;
    Rectangle31: TRectangle;
    Label32: TLabel;
    Layout12: TLayout;
    Rectangle32: TRectangle;
    Label33: TLabel;
    Rectangle33: TRectangle;
    Label34: TLabel;
    Rectangle34: TRectangle;
    Label35: TLabel;
    Layout13: TLayout;
    Rectangle35: TRectangle;
    Label36: TLabel;
    Rectangle36: TRectangle;
    Label37: TLabel;
    Rectangle37: TRectangle;
    Label38: TLabel;
    Layout14: TLayout;
    Rectangle38: TRectangle;
    Label39: TLabel;
    Rectangle39: TRectangle;
    Label40: TLabel;
    Rectangle40: TRectangle;
    Label41: TLabel;
    Layout15: TLayout;
    Rectangle41: TRectangle;
    Label42: TLabel;
    Rectangle42: TRectangle;
    Label43: TLabel;
    Rectangle43: TRectangle;
    Label44: TLabel;
    Layout16: TLayout;
    Rectangle44: TRectangle;
    Label45: TLabel;
    Rectangle45: TRectangle;
    Label46: TLabel;
    Rectangle46: TRectangle;
    Label47: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSectorItem = record
    Base: TLayout;
    IndiB: TRectangle;
    IndiT: TLabel;
    ClockB: TRectangle;
    ClockT: TLabel;
    SectorB: TRectangle;
    SectorT: TLabel;
  end;

var
  Form1: TForm1;
  SectorItems: array [0 .. 14] of TSectorItem;

implementation

{$R *.fmx}

uses
  Unit2, Unit6;

// slower $FFFA1043
// faster $FF25EA7E
// equal  $FFC3C3C3

procedure InitSectorItems;
begin
  SectorItems[0].Base := Form1.Layout2;
  SectorItems[1].Base := Form1.Layout3;
  SectorItems[2].Base := Form1.Layout11;
  SectorItems[3].Base := Form1.Layout10;
  SectorItems[4].Base := Form1.Layout9;
  SectorItems[5].Base := Form1.Layout8;
  SectorItems[6].Base := Form1.Layout7;
  SectorItems[7].Base := Form1.Layout6;
  SectorItems[8].Base := Form1.Layout4;
  SectorItems[9].Base := Form1.Layout5;
  SectorItems[10].Base := Form1.Layout12;
  SectorItems[11].Base := Form1.Layout13;
  SectorItems[12].Base := Form1.Layout14;
  SectorItems[13].Base := Form1.Layout15;
  SectorItems[14].Base := Form1.Layout16;

  SectorItems[0].IndiB := Form1.Rectangle2;
  SectorItems[1].IndiB := Form1.Rectangle3;
  SectorItems[2].IndiB := Form1.Rectangle11;
  SectorItems[3].IndiB := Form1.Rectangle10;
  SectorItems[4].IndiB := Form1.Rectangle9;
  SectorItems[5].IndiB := Form1.Rectangle8;
  SectorItems[6].IndiB := Form1.Rectangle7;
  SectorItems[7].IndiB := Form1.Rectangle6;
  SectorItems[8].IndiB := Form1.Rectangle26;
  SectorItems[9].IndiB := Form1.Rectangle29;
  SectorItems[10].IndiB := Form1.Rectangle32;
  SectorItems[11].IndiB := Form1.Rectangle35;
  SectorItems[12].IndiB := Form1.Rectangle38;
  SectorItems[13].IndiB := Form1.Rectangle41;
  SectorItems[14].IndiB := Form1.Rectangle44;

  SectorItems[0].IndiT := Form1.Label2;
  SectorItems[1].IndiT := Form1.Label4;
  SectorItems[2].IndiT := Form1.Label20;
  SectorItems[3].IndiT := Form1.Label18;
  SectorItems[4].IndiT := Form1.Label16;
  SectorItems[5].IndiT := Form1.Label14;
  SectorItems[6].IndiT := Form1.Label12;
  SectorItems[7].IndiT := Form1.Label10;
  SectorItems[8].IndiT := Form1.Label27;
  SectorItems[9].IndiT := Form1.Label30;
  SectorItems[10].IndiT := Form1.Label33;
  SectorItems[11].IndiT := Form1.Label36;
  SectorItems[12].IndiT := Form1.Label39;
  SectorItems[13].IndiT := Form1.Label42;
  SectorItems[14].IndiT := Form1.Label45;

  SectorItems[0].ClockB := Form1.Rectangle4;
  SectorItems[1].ClockB := Form1.Rectangle5;
  SectorItems[2].ClockB := Form1.Rectangle12;
  SectorItems[3].ClockB := Form1.Rectangle13;
  SectorItems[4].ClockB := Form1.Rectangle14;
  SectorItems[5].ClockB := Form1.Rectangle15;
  SectorItems[6].ClockB := Form1.Rectangle16;
  SectorItems[7].ClockB := Form1.Rectangle17;
  SectorItems[8].ClockB := Form1.Rectangle27;
  SectorItems[9].ClockB := Form1.Rectangle30;
  SectorItems[10].ClockB := Form1.Rectangle33;
  SectorItems[11].ClockB := Form1.Rectangle36;
  SectorItems[12].ClockB := Form1.Rectangle39;
  SectorItems[13].ClockB := Form1.Rectangle42;
  SectorItems[14].ClockB := Form1.Rectangle45;

  SectorItems[0].ClockT := Form1.Label3;
  SectorItems[1].ClockT := Form1.Label5;
  SectorItems[2].ClockT := Form1.Label21;
  SectorItems[3].ClockT := Form1.Label19;
  SectorItems[4].ClockT := Form1.Label17;
  SectorItems[5].ClockT := Form1.Label15;
  SectorItems[6].ClockT := Form1.Label13;
  SectorItems[7].ClockT := Form1.Label11;
  SectorItems[8].ClockT := Form1.Label28;
  SectorItems[9].ClockT := Form1.Label31;
  SectorItems[10].ClockT := Form1.Label34;
  SectorItems[11].ClockT := Form1.Label37;
  SectorItems[12].ClockT := Form1.Label40;
  SectorItems[13].ClockT := Form1.Label43;
  SectorItems[14].ClockT := Form1.Label46;

  SectorItems[0].SectorB := Form1.Rectangle18;
  SectorItems[1].SectorB := Form1.Rectangle19;
  SectorItems[2].SectorB := Form1.Rectangle20;
  SectorItems[3].SectorB := Form1.Rectangle21;
  SectorItems[4].SectorB := Form1.Rectangle22;
  SectorItems[5].SectorB := Form1.Rectangle23;
  SectorItems[6].SectorB := Form1.Rectangle24;
  SectorItems[7].SectorB := Form1.Rectangle25;
  SectorItems[8].SectorB := Form1.Rectangle28;
  SectorItems[9].SectorB := Form1.Rectangle31;
  SectorItems[10].SectorB := Form1.Rectangle34;
  SectorItems[11].SectorB := Form1.Rectangle37;
  SectorItems[12].SectorB := Form1.Rectangle40;
  SectorItems[13].SectorB := Form1.Rectangle43;
  SectorItems[14].SectorB := Form1.Rectangle46;

  SectorItems[0].SectorT := Form1.Label6;
  SectorItems[1].SectorT := Form1.Label7;
  SectorItems[2].SectorT := Form1.Label8;
  SectorItems[3].SectorT := Form1.Label9;
  SectorItems[4].SectorT := Form1.Label22;
  SectorItems[5].SectorT := Form1.Label23;
  SectorItems[6].SectorT := Form1.Label24;
  SectorItems[7].SectorT := Form1.Label25;
  SectorItems[8].SectorT := Form1.Label29;
  SectorItems[9].SectorT := Form1.Label32;
  SectorItems[10].SectorT := Form1.Label35;
  SectorItems[11].SectorT := Form1.Label38;
  SectorItems[12].SectorT := Form1.Label41;
  SectorItems[13].SectorT := Form1.Label44;
  SectorItems[14].SectorT := Form1.Label47;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InitSectorItems;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  I: Integer;
begin
  Rectangle1.Visible := (CurrRun.Clock[Low(CurrRun.Clock)] <> -1) and
    not Form6.RadioButton1.IsChecked;
  Layout1.Visible := (CurrRun.Clock[Low(CurrRun.Clock)] <> -1);
  for I := Low(SectorItems) to High(SectorItems) do
  begin
    SectorItems[I].Base.Opacity :=
      IfThen(Form6.Grid1.RowCount >= Succ(I), 1, 0);
    SectorItems[I].Base.Margins.Top := (4 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].Base.Height := (28 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].IndiT.Font.Size := (18 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].ClockT.Font.Size := (18 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].SectorT.Font.Size := (18 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].ClockB.Width := (100 * GetSystemMetrics(1)) / ResHeight;
    SectorItems[I].SectorB.Width := (50 * GetSystemMetrics(1)) / ResHeight;
  end;
  I := (GetSystemMetrics(0) div 2) - ((ResWidth div 2) * GetSystemMetrics(1))
    div ResHeight;
  if I < 0 then
    I := 0;
  Rectangle1.Height := (32 * GetSystemMetrics(1)) / ResHeight;
  Rectangle1.Width := (172 * GetSystemMetrics(1)) / ResHeight;
  Label1.Font.Size := (28 * GetSystemMetrics(1)) / ResHeight;
  Rectangle1.Position.X := (GetSystemMetrics(0) div 2) - (Rectangle1.Width / 2);
  Rectangle1.Position.Y := (40 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Width := (230 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Height := (268 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Position.X := GetSystemMetrics(0) - I - Layout1.Width -
    (40 * GetSystemMetrics(1)) / ResHeight;
  Layout1.Position.Y := ((792 - (Form6.Grid1.RowCount * 32)) *
    GetSystemMetrics(1)) / ResHeight;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  I, X, Y, Z: Integer;
  Ani: TAnimator;
begin
  if Form1.Visible then
  begin
    Rectangle1.Visible := (CurrRun.Clock[Low(CurrRun.Clock)] <> -1) and
      not Form6.RadioButton1.IsChecked;
    Layout1.Visible := (CurrRun.Clock[Low(CurrRun.Clock)] <> -1);
    Form1.BringToFront;
    Ani := TAnimator.Create;
    if (SectorClocks[Pred(Form6.Grid1.RowCount)]^.AsType<TDateTime> <> -1) and
      ( { (MilliSecondOfTheDay(SectorClocks[Pred(Form6.Grid1.RowCount)
        ]^.AsType<TDateTime>) < MilliSecondOfTheDay(PrevRun.Clock
        [High(PrevRun.Clock)]))  or } (PrevRun.Clock[High(PrevRun.Clock)] = -1))
    then
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
    if Form6.RadioButton4.IsChecked then
      Z := X + Y
    else
      Z := Abs(X);
    Label1.Text := IfThen(Form6.RadioButton4.IsChecked, '',
      IfThen(X <= 0, '-', '+')) + Format('%0:.2d:%1:.2d.%2:.3d',
      [(Z div 60000) mod 60, (Z div 1000) mod 60, Z mod 1000]);
    Ani.AnimateColor(Rectangle1, 'Fill.Color',
      IfThen(X <= 0, IfThen(X = 0, $FFC3C3C3, $FF25EA7E), $FFFA1043), 0.2);
    for I := Low(SectorItems) to High(SectorItems) do
    begin
      SectorItems[I].ClockT.Text :=
        TimeToStr(SectorClocks[I]^.AsType<TDateTime>);
      SectorItems[I].IndiB.Fill.Color := IfThen(SectorDeltas[I] <= 0,
        IfThen((SectorDeltas[I] = 0) or (SectorDeltas[I] = SectorDeltas[I]
        .MinValue), $FFC3C3C3, $FF25EA7E), $FFFA1043);
      if SectorDeltas[I] = SectorDeltas[I].MinValue then
        SectorItems[I].IndiT.Text := '-.--'
      else
        SectorItems[I].IndiT.Text := IfThen(SectorDeltas[I] <= 0, '-', '+') +
          FormatFloat('0.00', Abs(SectorDeltas[I] / 1000));
      SectorItems[I].SectorT.Text := PrevSectors[1, I].ToString + '%';
    end;
    Ani.Free;
  end;
end;

end.
