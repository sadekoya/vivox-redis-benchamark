-module(sscan). 
-export([start/0]).
-define(MAX_SCAN_COUNT, 100).

start() ->
    {ok, C} = eredis:start_link(),

    %generates sample test set data
    make_setdata(C),

    %benchmark test begins here
    statistics(runtime),
    statistics(wall_clock),
    Result = process_sscan(0, C),

    {_, Time2} = statistics(wall_clock),
    io:format("SSCAN Benchmark elapsed time=~p ms, (~p)seconds~n", [Time2, Time2/1000]),
    Result.
    
 


process_sscan(Cursor, C) ->
    {ok, [New_cursor, Sessions]} = eredis:q(C, ["SSCAN", mytestset, Cursor, "COUNT", ?MAX_SCAN_COUNT]),

    case New_cursor of
        <<"0">> ->
            R = Sessions;
        _ ->
            R = Sessions,
            process_sscan(New_cursor, C)
    end,
    R.
    
make_setdata(C) ->
    {ok, _R} = eredis:q(C, ["SADD", mytestset| lists:seq(1, 1000000)]).
