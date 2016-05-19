-module(count_char).
-export([count_char/1]).

count_char(Str) ->
    count_char(Str, #{}).

count_char([H|T], X) ->
    case maps:is_key(H, X) of 
        false -> count_char(T, X#{ H => 1});
        true -> #{H := Count} = X,
            count_char(T, X#{ H := Count + 1})
    end;
count_char([], X) ->
    X.
