-module(echo).
-export([start/0, stop/0, print/1, loop/0]).

start() ->
    Pid = spawn(?MODULE, loop, []),
    try register(?MODULE, Pid) of
        true -> ok
    catch
        error:badarg -> Pid ! stop
    end.

loop() ->
    receive
        stop ->
            ok;
        {print, Message} ->
            io:format("~p~n", [Message]),
            ?MODULE:loop();
        Msg ->
            io:format("[~p] unexpect message: ~p~n", [?MODULE, Msg]),
            ?MODULE:loop()
    end.

stop() ->
    ?MODULE ! stop,
    ok.

print(Term) ->
    ?MODULE ! {print, Term},
    ok.
