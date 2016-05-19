-module(afile_server).
-export([start/2, rpc/1, loop/1]).

start(ServerName, Dir) -> 
    register(ServerName, spawn(afile_server, loop, [Dir])).

rpc({get_file, File}) ->
    afile_server ! {self(), {get_file, File}},
    receive
        {_Pid, Content} ->
            Content
    end;
rpc(Request) ->
    afile_server ! {self(), Request},
    receive
        {_Pid, FileList} ->
            FileList
    end.

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            FullName = filename:join(Dir, File),
            Client ! {self(), file:read_file(FullName)}
    end.
