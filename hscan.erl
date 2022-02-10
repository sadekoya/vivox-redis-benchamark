-module(hscan). 
-export([start/0]).
-define(MAX_SCAN_COUNT, 100).

start() ->
    {ok, C} = eredis:start_link(),
    
    %generates hash test data
    create_hashdata(C),

    %benchmark test begins here
    statistics(runtime),
    statistics(wall_clock),
    Result = process_hscan(0, C),

    {_, Time2} = statistics(wall_clock),
    io:format("HSCAN Benchmark elapsed time=~p ms, (~p)seconds~n", [Time2, Time2/1000]),
    Result.
    
 


process_hscan(Cursor, C) ->
    {ok, [New_cursor, Sessions]} = eredis:q(C, ["HSCAN", mytesthash, Cursor, "COUNT", ?MAX_SCAN_COUNT]),

    case New_cursor of
        <<"0">> ->
            R = Sessions;
        _ ->
            R = Sessions,
            process_hscan(New_cursor, C)
    end,
    R.

create_hashdata(C) ->
    HashObj = [integer_to_list(X) || X <- lists:seq(1, 1000000)],
    eredis:q(C, ["HMSET", "mytesthash" | HashObj]).
