-module(test).
-export([start/0]).

	
    
start() ->
    Host = imagelib:start(),
    Image = imagelib:read(Host, "test.jpg"),
    io:format("Image = ~p~n", [Image]),
    %scale(Image, 800, 800),
    imagelib:display(Host, Image),
    imagelib:edge(Host, Image, 5),
    imagelib:negate(Host, Image, 0),
    imagelib:display(Host, Image).






