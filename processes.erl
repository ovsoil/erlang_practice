-module(processes).
-export([max/1]).

max(N) ->
    Max = erlang:system_info(process_limit),
    io:format("Maximum allowed processes:~p~n", [Max]),
    statistics(runtime),
    statistics(wall_clock),
    L = [spawn(fun() -> wait() end) || _X <- lists:seq(1, N)],
    % L = for(1, N, fun() -> spawn(fun() -> wait() end) end),
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    lists:foreach(fun(Pid) -> Pid ! die end, L),
    U1 = Time1 * 1000 / N,
    U2 = Time2 * 1000 / N,
    io:format("Process spawn time = ~p(~p) microseconds.~n", [U1, U2]).

wait() ->
    receive
        die -> void
    end.

for(N, N, F) -> [F()];
for(M, N, F) when M < N -> [F() | for(M + 1, N, F)].
