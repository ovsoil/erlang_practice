-module(dist_demo).
-export([start/1, rpc/4]).

start(Node) ->
    spawn(Node, fun() -> loop() end).

rpc(ServerNode, M, F, A) ->
    ServerNode ! {rpc, self(), M, F, A},
    receive
        {_Pid, Reply} ->
            Reply
    end.


loop() ->
    receive
        {rpc, From, M, F, A} ->
            From ! {self(), (catch apply(M, F, A))},
            loop()
    end.
