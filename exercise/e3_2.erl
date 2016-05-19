-module(e3_2).
-export([create/1, reverse_create/1]).

create(N) when is_integer(N) ->
    create(N, []).

reverse_create(N) when is_integer(N) ->
    % reverse_create(N, []).
    reverse_create(1, N, []).


create(N, R) when N > 0 ->
    create(N - 1, [N | R]);
create(_, R) ->
    R.

reverse_create(N, R) when N > 0 ->
    lists:reverse(create(N - 1, [N | R]));
reverse_create(_, R) ->
    R.

reverse_create(M, N, R) when N > 0, M =< N ->
    reverse_create(M + 1, N, [M | R]);
reverse_create(_, _, R) ->
    R.
