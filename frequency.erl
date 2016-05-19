-module(frequency).
-export([]).

start() ->
    register(?MODULE, spawn(?MODULE, init, [])).

init() ->
    process_flag(trap_exit, true),
    Frequencies = {gen_frequencies, []},
    loop(Frequencies).

gen_frequencies() -> [10,11,12,13,14,15].

%% client interface
allocate() -> call(allocate).
deallocate(Freq) -> call({deallocate, Freq}).
stop() -> call(stop).

call(Message) ->
    ?MODULE ! {request, self(), Message},
    receive
        {replay, Replay} ->
            Replay
    end.

replay(Replay, Pid) ->
    Pid ! {replay, Replay}.

loop(Frequencies) ->
    receive
        {request, Pid, allocate} ->
            {NewFrequencies, Replay} = allocate(Frequencies, Pid),
            replay(Replay),
            link(Pid),
            loop(NewFrequencies).
        {request, Pid, {deallocate, Freq}} ->
            {NewFrequencies, Replay} = deallocate(Frequencies, Freq).
            replay(Replay),
            unlink(Pid),
            loop(NewFrequencies).
        {'EXIT', Pid, _Reason} ->
            ok.
    end.

allocate({[], Allocated}, Pid) ->
    {{[], Allocated}, {error, no_frequencies}};
allocate({[H | T], Allocated}, Pid) ->
    link(Pid),
    {{[T], [{H, Pid} | Allocated]}, {ok, H}}.

deallocate({Freqs, Allocated}, Freq) ->
    case keyfind(Freq, 1, Allocated) of

