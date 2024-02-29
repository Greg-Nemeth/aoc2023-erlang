-module(day1).

%% -export([first/1]).
-compile(export_all).

first(File) ->
    InputList = input:listOfBinaryStrings(File),
    Fun = fun(X, Sum) ->
             Temp = calibrationVals(X),
             {Temp, Sum + Temp}
          end,
    {_InterMediary, Final} =
        lists:mapfoldl(Fun, 0, InputList),
    Final.

    %% lists:map(fun(Binary) -> calibrationVals(Binary) end, InputList).

calibrationVals(Bin) ->
    {ok, MP} = re:compile("(?<firstDigit>\\d).*(?<lastDigit>\\d(?!.*\\d))"),
    Res = re:run(Bin, MP, [{capture, all_names, binary}]),
    handleRegexResult(Res, Bin).

handleRegexResult({match, Results}, _) ->
    list_to_integer(unicode:characters_to_list(Results));
handleRegexResult(nomatch, Bin) ->
    {match, [Digit]} = re:run(Bin, "\\d{1}", [{capture, all, binary}]),
    binary_to_integer(binary:copy(Digit, 2)).
