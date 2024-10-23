unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private êÈåæ }
    Sente: Boolean;
    Caps: array [1 .. 9] of TSpeedButton;
    Chars: array [1 .. 9] of string;
    function Shouhai(player: Boolean; items: array of integer): Boolean;
    function IsGameOver(player: Boolean; var res: integer): Boolean;
    procedure GameOver(res: integer);
    procedure InitGame;
    function Execute(player: Boolean; level: integer = 0): integer;
    function NeededScore(player: Boolean; ints: TArray<integer>): integer;
    procedure HitButton(score: integer; player: Boolean); overload;
    procedure HitButton(spd: TSpeedButton; player: Boolean); overload;
    function ButtonNumber(score: integer): integer;
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.Math;

const
  Hantei: array of array of integer = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]];

function TForm1.ButtonNumber(score: integer): integer;
begin
  result := 0;
  for var i := 1 to 9 do
    if (Caps[i].Caption = '') and (score = Caps[i].Tag) then
      result := i;
end;

function TForm1.Execute(player: Boolean; level: integer): integer;
var
  num: integer;
  ints: TArray<integer>;
begin
  if IsGameOver(player, num) then
  begin
    case num of
      2:
        result := -1;
    else
      result := num;
    end;
    Exit;
  end;
  ints := [];
  for var i := 1 to 9 do
    if Chars[i] = '' then
    begin
      if player then
        Chars[i] := 'Åõ'
      else
        Chars[i] := 'Å~';
      num := Execute(not player, level + 1);
      ints := ints + [num];
      Chars[i] := '';
      if level = 0 then
        Caps[i].Tag := num;
    end;
  result := NeededScore(player, ints);
  Finalize(ints);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caps[1] := SpeedButton1;
  Caps[2] := SpeedButton2;
  Caps[3] := SpeedButton3;
  Caps[4] := SpeedButton4;
  Caps[5] := SpeedButton5;
  Caps[6] := SpeedButton6;
  Caps[7] := SpeedButton7;
  Caps[8] := SpeedButton8;
  Caps[9] := SpeedButton9;
  InitGame;
end;

procedure TForm1.GameOver(res: integer);
begin
  case res of
    0:
      Showmessage('à¯Ç´ï™ÇØ');
    1:
      Showmessage('Åõ èüóò');
    2:
      Showmessage('Å~ èüóò');
  end;
end;

procedure TForm1.HitButton(spd: TSpeedButton; player: Boolean);
var
  c: string;
begin
  if player then
    c := 'Åõ'
  else
    c := 'Å~';
  for var i := 1 to 9 do
    if spd = Caps[i] then
    begin
      Caps[i].Caption := c;
      Chars[i] := c;
    end;
end;

procedure TForm1.HitButton(score: integer; player: Boolean);
begin
  for var cap in Caps do
    if (cap.Caption = '') and (score = cap.Tag) then
    begin
      HitButton(cap, player);
      break;
    end;
end;

procedure TForm1.InitGame;
var
  score: integer;
begin
  Sente := RadioButton1.Checked;
  for var i := 1 to 9 do
  begin
    Caps[i].Caption := '';
    Chars[i] := '';
  end;
  score := Execute(Sente);
  if not Sente then
  begin
    HitButton(score, false);
    Sente := true;
  end;
  score := Execute(Sente);
  Caps[ButtonNumber(score)].Caption := 'ok'
end;

function TForm1.IsGameOver(player: Boolean; var res: integer): Boolean;
begin
  if player then
    res := 1
  else
    res := 2;
  for var arr in Hantei do
    if Shouhai(player, arr) then
      Exit(true);
  for var c in Chars do
    if c = '' then
      Exit(false);
  res := 0;
  result := true;
end;

function TForm1.NeededScore(player: Boolean; ints: TArray<integer>): integer;
begin
  if player then
    result := MaxIntValue(ints)
  else
    result := MinIntValue(ints);
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  InitGame;
end;

function TForm1.Shouhai(player: Boolean; items: array of integer): Boolean;
var
  c: string;
begin
  if player then
    c := 'Åõ'
  else
    c := 'Å~';
  for var item in items do
    if Chars[item] <> c then
      Exit(false);
  result := true;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  spd: TSpeedButton;
  score: integer;
  res: integer;
begin
  for var i := 1 to 9 do
    if Caps[i].Caption = 'ok' then
      Caps[i].Caption := '';
  if IsGameOver(true, res) or IsGameOver(false, res) then
  begin
    InitGame;
    Exit;
  end;
  spd := Sender as TSpeedButton;
  if spd.Caption = '' then
  begin
    HitButton(spd, Sente);
    if IsGameOver(Sente, res) then
      GameOver(res)
    else
    begin
      score := Execute(not Sente);
      HitButton(score, not Sente);
      if IsGameOver(not Sente, res) then
        GameOver(res)
      else
      begin
        score := Execute(Sente);
        Caps[ButtonNumber(score)].Caption := 'ok';
      end;
    end;
  end;
end;

procedure TForm1.SpeedButton6MouseEnter(Sender: TObject);
begin
  Label1.Caption := (Sender as TSpeedButton).Tag.ToString;
end;

end.
