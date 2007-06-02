-module(test).
-export([start/0]).

read(File) ->
    imagelib:rpc({read, File}).

start() ->
    io:format("before read", []),
    Image = read("test.jpg"),
    %scale(Image, 800, 800),
    imagelib:display(Image),
    imagelib:edge(Image, 5),
    imagelib:negate(Image, 0),
    imagelib:display(Image).




