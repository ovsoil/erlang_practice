-module(snail).
-export([climb/1]).

climb(0) ->
    0;
climb(H) when H =< 3 ->
    1;
climb(H) ->
    1 + climb(H - 1).
