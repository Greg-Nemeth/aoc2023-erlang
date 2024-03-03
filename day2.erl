-module(day2).

-compile(export_all).

-type color() :: red | green | blue.
-type draw() :: {integer(), color()}.
-type set() :: [draw()].
-type game() :: {integer(), [set()]}.

first(File) ->
    InputLines = input:listOfBinaryStrings(File),
    Pattern = [<<"Game ">>, <<": ">>, <<"; ">>],
    SplitLines =
        lists:map(fun(Line) -> binary:split(Line, Pattern, [global, trim_all]) end, InputLines).

-spec convert_to_draw(binary()) -> draw().
convert_to_draw(Bin) ->
    Pattern = [<<", ">>],
    Arr = binary:split(Bin, Pattern, [global, trim_all]),
    lists:map(fun(BinDraw) -> [Amount, Color] = binary:split(BinDraw, <<" ">>), 
    case Color of
        "red" | "green" | "blue" -> {binary_to_integer(Amount), binary_to_atom(Color) }
    end
        end, Arr).

-spec convert_to_game([binary()]) -> game().
convert_to_game(BinArray) ->
    {5, [[{3, red}]]}.
