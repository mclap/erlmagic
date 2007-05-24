-module(util).
-export([join/2, test_join/0]).

join(C, L) ->
    join(C, L, []).
join(_, [], []) ->
    "";
join(_, [], Acc) ->
    lists:flatten(tl(lists:reverse(Acc)));
join(C, [H|L], Acc) ->
    Acc1 = [H, C|Acc],
    join(C, L, Acc1).

test_join() ->
    L = ["this", "that", "the", "other"],
    join(",", L).
