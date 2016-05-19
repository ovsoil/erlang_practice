-module(new_name_server).
-export([add/2, find/1, all_names/0, delete/1]).
-export([init/0, handle/2]).
-import(server2, [rpc/2]).

%% client reference
add(Name, Place) -> rpc(name_server, {add, Name, Place}).
find(Name) -> rpc(name_server, {find, Name}).
all_names() -> rpc(name_server, allNames).
delete(Name) -> rpc(name_server, {delete, Name}).

%% callback
init() -> dict:new().
handle({add, Name, Place}, Dict) -> {ok, dict:store(Name, Place, Dict)};
handle({find, Name}, Dict) -> {dict:find(Name, Dict), Dict};
handle(allNames, Dict) -> {dict:fetch_keys(Dict), Dict};
handle({delete, Name}, Dict) -> {ok, dict:erase(Name, Dict)}.
