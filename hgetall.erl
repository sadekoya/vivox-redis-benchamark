-module(hgetall). 
-export([start/0]).

start() ->
    {ok, C} = eredis:start_link(),

    create_hashdata(C),

    %benchmark begins here
    statistics(runtime),
    statistics(wall_clock),
    {ok, Result} = eredis:q(C, ["HGETALL", mytesthash]),

    {_, Time2} = statistics(wall_clock),
    io:format("HGETALL Benchmark elapsed time=~p ms, (~p)seconds~n", [Time2, Time2/1000]),
    Result.

create_hashdata(C) ->
    HashObj = [integer_to_list(X) || X <- lists:seq(1, 1000000)],
    eredis:q(C, ["HMSET", "mytesthash" | HashObj]).
