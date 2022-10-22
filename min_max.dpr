program min_max;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, System.Math;

const
  none = 0;
  maru = 1;
  peke = 2;

var
  board, free_space: TArray<integer>;
  p: integer;

function win_player(player: integer): integer;
var
  bool: Boolean;
  function check_items(numbers: array of integer): Boolean;
  begin
    result := true;
    for var i in numbers do
      if board[i] <> player then
        result := false;
  end;

begin
  bool := check_items([0, 1, 2]) or check_items([3, 4, 5]) or
    check_items([6, 7, 8]) or //
    check_items([0, 3, 6]) or check_items([1, 4, 7]) or
    check_items([2, 5, 8]) or //
    check_items([0, 4, 8]) or check_items([2, 4, 6]);
  if bool then
  begin
    if player = p then
      result := 1
    else
      result := -1;
  end
  else
    result := 0;
end;

function change_player(player: integer): integer;
begin
  case player of
    maru:
      result := peke;
    peke:
      result := maru;
  else
    result := maru;
  end;
end;

procedure check_free_space;
begin
  free_space := [];
  for var i := 1 to 9 do
    if board[i - 1] = 0 then
      free_space := free_space + [i];
end;

function main_ai(local, level: integer): integer;
var
  min_max, num: integer;
begin
  check_free_space;
  if Length(free_space) = 0 then
    Exit(0);
  if local = p then
    min_max := -100
  else
    min_max := 100;
  for var i in free_space do
  begin
    board[i - 1] := local;
    case win_player(local) of
      - 1:
        result := -(10 - level);
      0:
        result := main_ai(change_player(local), level + 1);
      1:
        result := 10 - level;
    end;
    if local = p then
    begin
      if result > min_max then
      begin
        min_max := result;
        num := i;
      end;
    end
    else if result < min_max then
    begin
      min_max := result;
      num := i;
    end;
    board[i - 1] := none;
  end;
  if level = 1 then
    result := num
  else
    result := min_max;
end;

function return_char(state: integer): Char;
begin
  case state of
    maru:
      result := 'O';
    peke:
      result := 'X';
  else
    result := ' ';
  end;
end;

procedure display;
begin
  for var i := 1 to Length(board) do
  begin
    if i mod 3 = 1 then
    begin
      Writeln;
      Writeln('******');
    end;
    Write(return_char(board[i - 1]), '|');
  end;
  Writeln;
  Writeln('******');
end;

procedure game_over;
begin
  if win_player(p) = 0 then
    Writeln('draw')
  else
    Writeln(return_char(p), ' win!');
  Readln;
end;

begin
  try
    { TODO -oUser -cConsole メイン : ここにコードを記述してください }
    board := [0, 0, 0, 0, 0, 0, 0, 0, 0];
    p := none;
    repeat
      Readln;
      p := change_player(p);
      board[main_ai(p, 1) - 1] := p;
      display;
      check_free_space;
    until (win_player(p) <> 0) or (Length(free_space) = 0);
    game_over;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
