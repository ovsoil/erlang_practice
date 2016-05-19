-module(tut14).
-export([start/0, say_something/2]).

say_something(Word, 0) ->
    done;
say_something(Word, Times) ->
    io:format("~w~n", [Word]),
    say_something(Word, Times - 1).

start() ->
    spawn(tut14, say_something, [hello, 3]),
    spawn(tut14, say_something, [goodbye, 4]).
