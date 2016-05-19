-module(e3_5).
-export([filter/2]).


filter([H | T], N) when H > N -> filter(T, N);
filter([H | T], N) -> [H | filter(T, N)];
filter([], _) -> [].
    

