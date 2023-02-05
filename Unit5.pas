unit Unit5;

interface

uses
  WinAPI.Windows,
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Memo.Types, FMX.StdCtrls, FMX.Memo, FMX.Grid,
  FMX.ScrollBox, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.ListBox, FMX.Ani,
  FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl, FMX.Objects;

type
  TForm5 = class(TForm)
    Rectangle1: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout1: TLayout;
    Label3: TLabel;
    ComboBox3: TComboBox;
    Layout2: TLayout;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Layout3: TLayout;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Layout4: TLayout;
    Label6: TLabel;
    Layout6: TLayout;
    Button2: TButton;
    Button7: TButton;
    TabItem2: TTabItem;
    Memo1: TMemo;
    Layout8: TLayout;
    Button4: TButton;
    TabItem3: TTabItem;
    Memo2: TMemo;
    Layout5: TLayout;
    Button9: TButton;
    CheckBox2: TCheckBox;
    Panel1: TPanel;
    Label7: TLabel;
    Button6: TButton;
    Label4: TLabel;
    Edit1: TEdit;
    ClearEditButton1: TClearEditButton;
    ComboBox5: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

uses
  Unit6;

procedure TForm5.FormShow(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  Left := 0;
  Top := 0;
  ClientWidth := 415 * 186 div 145;
  ClientHeight := 186;
  Rectangle1.Scale.X := Form5.ClientHeight / 145;
  Rectangle1.Scale.Y := Form5.ClientHeight / 145;
  Form5.Left := P.X - Form5.Width div 2;
  Form5.Top := P.Y - Form5.Height div 2;
  ComboBox5.ItemIndex := Form6.ComboBox5.ItemIndex;
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TForm5.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
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

end.
