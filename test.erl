-module(test).
-export([start/0]).

read(File) ->
    rpc({read, File}).

scale(Image, Width, Height) ->
    rpc({scale, Image, Width, Height}).

edge(Image, Radius) ->
    rpc({edge, Image, Radius}).

display(Image) ->
    rpc({display, Image}).

write(Image, File) ->
    rpc({write, Image, File}).

quit() ->
    rpc({quit}).


rpc(Query) ->
    {any, c1@amddesktop} ! {self(), Query},
    receive
	Reply ->
	    io:format("reply received ~p~n", [Reply]),
	    Reply
    end.

start() ->
    Image = read("girl.gif"),
    %scale(Image, 800, 800),
    display(Image),
    edge(Image, 5),
    display(Image).




