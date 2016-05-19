-module(tut6).
-export([list_max/1, list_min/1]).

list_max([Head | Rest]) ->
    list_max(Rest, Head).

list_max([], Res) ->
    Res;
list_max([Head | Rest], Result_so_far) when Result_so_far > Head ->
    list_max(Rest, Result_so_far);
list_max([Head | Rest], Result_so_far) ->
    list_max(Rest, Head).

list_min([Head | Rest]) ->
    list_min(Rest, Head).

list_min([], Res) ->
    Res;
list_min([Head | Rest], Result_so_far) when Result_so_far > Head ->
    list_min(Rest, Head);
list_min([Head | Rest], Result_so_far) ->
    list_min(Rest, Result_so_far).
