-module(e3_1).
-export([sum/1, sum/2]).

% sum(N) when N > 0 ->
%     N + sum(N - 1);
% sum(_) ->
%     0.

sum(N) ->
    sum(1, N).

sum(N, M) when is_integer(N), is_integer(M), N =< M ->
    sum(N, M, M).

sum(M, M, Sum) -> Sum;
sum(N, M, Sum) ->
    sum(N + 1, M, Sum + N).
