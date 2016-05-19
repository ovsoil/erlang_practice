-module(permutation).
-export([perms/1]).

perms([]) ->
    [[]];
perms([X|Xs]) ->
    [insert(X, As, Bs) || Ps <- perms(Xs), {As, Bs} <- split(Ps)].

split([]) ->
    [{[], []}];
split([X|Xs] = Ys) ->
    [{[], Ys} | [{[X|As], Bs} || {As, Bs} <- split(Xs)]].

insert(X, As, Bs) ->
    lists:append([As, [X], Bs]).
