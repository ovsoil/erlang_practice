-module(ring).
-export([start/3]).

start(M, N, Message) ->
    Pid = start_ring(N, self()),
    [Pid ! Message || _ <- lists:seq(1, M)],
    Pid ! stop,
    wait().

wait() ->
    receive
        stop ->
            ok;
        _ ->
            wait()
    end.

start_ring(0, Pid) ->
    Pid;
start_ring(N, Pid) ->
    % start_ring(N - 1, spawn(?MODULE, loop, [Pid])).
    start_ring(N - 1, spawn(fun() -> loop(Pid) end)).

loop(Pid) ->
    receive
        stop ->
            Pid ! stop,
            ok;
        Msg ->
            io:format("[~p]:~p~n", [self(), Msg]),
            Pid ! Msg,
            loop(Pid)
    end.
