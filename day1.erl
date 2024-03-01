-module(day1).

%% -export([first/1]).
-compile(export_all).

first(File) ->
    InputList = input:listOfBinaryStrings(File),
    Fun = fun(X, Sum) ->
             Temp = calibrationVals1(X),
             {Temp, Sum + Temp}
          end,
    {_InterMediary, Final} =
        lists:mapfoldl(Fun, 0, InputList),
    Final.

    %% lists:map(fun(Binary) -> calibrationVals(Binary) end, InputList).

calibrationVals1(Bin) ->
    {ok, MP} = re:compile("(?<firstDigit>\\d).*(?<lastDigit>\\d(?!.*\\d))"),
    Res = re:run(Bin, MP, [{capture, all_names, binary}]),
    handleRegexResult1(Res, Bin).

handleRegexResult1({match, Results}, _) ->
    list_to_integer(unicode:characters_to_list(Results));
handleRegexResult1(nomatch, Bin) ->
    {match, [Digit]} = re:run(Bin, "\\d{1}", [{capture, all, binary}]),
    binary_to_integer(binary:copy(Digit, 2)).
