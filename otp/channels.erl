-module(channels).
-behaviour(gen_server).

-export([start/0, stop/0]).
-export([alloc/0, free/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

start() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop() ->
    gen_server:cast(?MODULE, stop).

%% client interface
alloc() -> gen_server:call(?MODULE, alloc).
free(Ch) -> gen_server:cast(?MODULE, {free, Ch}).

%% callback
init(_Args) ->
    % process_flag(trap_exit, true),
    {ok, channels()}.

handle_call(alloc, _From, Chs) ->
    {Ch, NewChs} = alloc(Chs),
    {replay, Ch, NewChs}.

handle_cast({free, Ch}, Chs) ->
    NewChs = free(Ch, Chs),
    {noreplay, NewChs}.

terminate(_Reason, _State) ->
    ok.

handle_info(_Msg, State) -> {noreplay, State}.
code_change(_OldVsn, State, _Extra) -> {ok, State}.


%% 
channels() ->
    {_Allocated = [], _Free = lists:seq(1, 100)}.

alloc({Allocated, [H|T]}) ->
    {H, {[H|Allocated], T}}.
    
free(Ch, {Allocated, Free}) ->
    case lists:member(Ch, Allocated) of
        true ->
            {lists:delete(Ch, Allocated), [Ch|Free]};
        false ->
            {Allocated, Free}
    end.
