-module(input).

-export([listOfBinaryStrings/1]).

listOfBinaryStrings(File) ->
    file:truncate(File),
    {ok, Binary} = file:read_file(File),
    string:lexemes(Binary, [$\r, $\n] ).
