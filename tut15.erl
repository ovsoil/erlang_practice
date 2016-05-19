-module(tut15).
-export([ping/2, pong/0, start/0]).

ping(0, Pong_ID) ->
    Pong_ID ! finished,
    io:format("ping finished~n", []);
ping(N, Pong_ID) ->
    Pong_ID ! {ping, self()},
    receive
        pong ->
            io:format("ping received pong~n", [])
    end,
    ping(N - 1, Pong_ID).

pong() ->
    receive
        finished ->
            io:format("pong finished~n", []);
        {ping, Ping_ID} ->
            Ping_ID ! pong,
            io:format("pong received ping~n", []),
            pong()
    end.

start() ->
    Pong_ID = spawn(tut15, pong, []),
    spawn(tut15, ping, [3, Pong_ID]).
