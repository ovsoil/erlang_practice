-module(my_bank).
-behaviour(gen_server).
-export([start/0, stop/0, new_account/1, deposit/2, withdraw/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
stop()  -> gen_server:call(?MODULE, stop).

new_account(Who) -> gen_server:call(?MODULE, {new, Who}).
deposit(Who, Amount) -> gen_server:call(?MODULE, {add, Who, Amount}).
withdraw(Who, Amount) -> gen_server:call(?MODULE, {remove, Who, Amount}).


init([]) -> {ok, ets:new(?MODULE, [])}.

handle_call({new, Who}, _From, Tab) ->
    Replay = case ets:lookup(Tab, Who) of
        [] -> ets:insert(Tab, {Who, 0}),
            {welcome, Who};
        [_] -> {Who, you_already_are_a_customer}
    end,
    {reply, Replay, Tab}.

handle_call({add, Who, Amount}, _From, Tab) ->
    Replay = case ets:lookup(Tab, Who) of
        [] -> not_a_customer;
        [{Who, Balance}] ->
            NewBalance = Balance + Amount,
            ets:insert(Tab, {Who, NewBalance}),
            {thanks, Who, your_balance_is, NewBalance}
    end.


