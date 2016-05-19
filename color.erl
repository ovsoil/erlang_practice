-module(color).
-export([new/4, blend/2]).

-define(is_channel(V), (is_float(V) andalso V >= 0.0 andalso V =< 1.0)).

new(R,G,B,A) when ?is_channel(R), ?is_channel(G),
                     ?is_channel(B), ?is_channel(A) ->
    #{red => R, green => G, blue => B, alpha => A}.

blend(Src, Dst) ->
    blend(Src, Dst, alpha(Src, Dst)).

blend(Src, Dst, Alpha) when Alpha > 0.0 ->
    Dst#{
        red     := red(Src, Dst) / Alpha,
        green   := green(Src, Dst) / Alpha,
        blue    := blue(Src, Dst) / Alpha,
        alpha   := Alpha
    };
blend(_, Dst, _) ->
    Dst#{
        red     := 0.0,
        green   := 0.0,
        blue    := 0.0,
        alpha   := 0.0 
    }.

alpha(#{alpha := SA}, #{alpha := DA}) ->
    SA + DA * (1 - SA).

red(#{red := SR, alpha := SA}, #{red := DR, alpha := DA}) ->
    SA * SR + DA * DR * (1 - SA).

green(#{green := SG, alpha := SA}, #{green := DG, alpha := DA}) ->
    SA * SG + DA * DG * (1 - SA).

blue(#{blue := SB, alpha := SA}, #{blue := DB, alpha := DA}) ->
    SA * SB + DA * DB * (1 - SA).
