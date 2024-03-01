-module(day1).

%% -export([first/1]).
-compile(export_all).

-define(BIN_STR_TO_INT,
        #{<<"one">> => <<"1">>,
          <<"two">> => <<"2">>,
          <<"three">> => <<"3">>,
          <<"four">> => <<"4">>,
          <<"five">> => <<"5">>,
          <<"six">> => <<"6">>,
          <<"seven">> => <<"7">>,
          <<"eight">> => <<"8">>,
          <<"nine">> => <<"9">>}).

first(File) ->
    InputList = input:listOfBinaryStrings(File),
    Fun = fun(X, Sum) ->
             Temp = calibrationVals1(X),
             {Temp, Sum + Temp}
          end,
    {_InterMediary, Final} = lists:mapfoldl(Fun, 0, InputList),
    Final.

second(File) ->
    InputList = input:listOfBinaryStrings(File),
    Fun = fun(X, Sum) ->
             Temp = calibration_vals(X),
             {Temp, Sum + Temp}
          end,
    {_InterMediary, Final} = lists:mapfoldl(Fun, 0, InputList),
    Final.

calibration_vals(Bin) ->
    {ok, MP} = re:compile("one|two|three|four|five|six|seven|eight|nine|\\d{1}"),
    {match, Results} = re:run(Bin, MP, [global, {capture, all, binary}]),
    handle_regex_result(lists:flatten(Results)).

calibrationVals1(Bin) ->
    {ok, MP} = re:compile("(?<firstDigit>\\d).*(?<lastDigit>\\d(?!.*\\d))"),
    Res = re:run(Bin, MP, [{capture, all_names, binary}]),
    handleRegexResult1(Res, Bin).

handleRegexResult1({match, Results}, _) ->
    list_to_integer(unicode:characters_to_list(Results));
handleRegexResult1(nomatch, Bin) ->
    {match, [Digit]} = re:run(Bin, "\\d{1}", [{capture, all, binary}]),
    binary_to_integer(binary:copy(Digit, 2)).

handle_regex_result([Head]) ->
    Digit = maps:get(Head, ?BIN_STR_TO_INT, Head),
    binary_to_integer(binary:copy(Digit, 2));
handle_regex_result([Head | Tail]) ->
    First = maps:get(Head, ?BIN_STR_TO_INT, Head),
    Temp = lists:last(Tail),
    Last = maps:get(Temp, ?BIN_STR_TO_INT, Temp),
    list_to_integer(unicode:characters_to_list([First, Last])).
