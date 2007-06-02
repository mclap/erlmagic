-module(util).
-export([join/2, capitalize/1, test_join/0]).

join(C, L) ->
    join(C, L, []).
join(_, [], []) ->
    "";
join(_, [], Acc) ->
    lists:flatten(tl(lists:reverse(Acc)));
join(C, [H|L], Acc) ->
    Acc1 = [H, C|Acc],
    join(C, L, Acc1).

capitalize(Word) ->
    FirstLetter = hd(Word),
    if FirstLetter > 96 ->
	    [hd(Word) - 32] ++ tl(Word);
       true ->
	    Word
    end.

test_join() ->
    L = ["this", "that", "the", "other"],
    join(",", L).
