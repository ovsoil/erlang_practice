-module(e3_3).
-export([print/1, print_even/1]).

print(N) ->
    io:format("Number:~p~n", [e3_2:create(N)]).

print_even(N) ->
    io:format("Even Number:~p~n", 
        [lists:filter(fun(Num)->Num rem 2 == 0 end, e3_2:create(N))]).
