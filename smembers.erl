-module(smembers). 
-export([start/0]).

start() ->
    {ok, C} = eredis:start_link(),

    make_setdata(C),

    %benchmark begins here
    statistics(runtime),
    statistics(wall_clock),
    {ok, Result} = eredis:q(C, ["SMEMBERS", mytestset]),

    {_, Time2} = statistics(wall_clock),
    io:format("SMEMBERS Benchmark elapsed time=~p ms, (~p)seconds~n", [Time2, Time2/1000]),
    Result.

make_setdata(C) ->
    {ok, _R} = eredis:q(C, ["SADD", mytestset| lists:seq(1, 1000000)]).
