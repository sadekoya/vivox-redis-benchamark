-module(mget). 
-export([start/0]).

start() ->
    {ok, C} = eredis:start_link(),

    make_kv(C),
    Keys = [integer_to_list(X) || X <- lists:seq(1, 1000000, 2)],

    %benchmark begins here
    statistics(runtime),
    statistics(wall_clock),
    {ok, Result} = eredis:q(C, ["MGET" |  Keys]),

    {_, Time2} = statistics(wall_clock),
    io:format("MGET Benchmark elapsed time=~p ms, (~p)seconds~n", [Time2, Time2/1000]),
    Result.

make_kv(C) ->
    KeyValuePairs = [integer_to_list(X) || X <- lists:seq(1, 1000000)],
    {ok, <<"OK">>} = eredis:q(C, ["MSET" | KeyValuePairs]).
   
