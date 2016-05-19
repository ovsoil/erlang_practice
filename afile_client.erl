-module(afile_client).
-export([ls/1, get_file/2]).

ls(ServerName) ->
    Server:rpc(list_dir).

get_file(Server, File) ->
    Server:rpc({get_file, File}).
