-module(test).
-compile(export_all).

init() ->	
    Host = imagelib:start(),
    Image = imagelib:read(Host, "test.jpg"),
    io:format("Image = ~p~n", [Image]),
    imagelib:scale(Host, Image, 800, 800),
    imagelib:display(Host, Image),
    {Host, Image}.
    
test1() ->
    {Host, Image} = init(),
    imagelib:edge(Host, Image, 10),
    imagelib:display(Host, Image),
    imagelib:negate(Host, Image, 0),
    imagelib:display(Host, Image).

test2() ->
    {Host, Image} = init(),
    imagelib:roll(Host, Image, 100, 100),
    imagelib:display(Host, Image).

test3() ->
    {Host, Image} = init(),
    imagelib:reduceNoise(Host, Image),
    imagelib:display(Host, Image).

test4() ->
    {Host, Image} = init(),
    Image2 = imagelib:read(Host, "test2.jpg"),
    io:format("Image2 = ~p~n", [Image2]),
    imagelib:scale(Host, Image2, 800, 800),
    imagelib:display(Host, Image2),
    imagelib:composite(Host, Image, Image2, 0, 0, "AddCompositeOp"),
    imagelib:display(Host, Image),
    imagelib:composite(Host, Image, Image2, 0, 0, "MinusCompositeOp"),
    imagelib:display(Host, Image).

test_del(0, _) ->
    ok;
test_del(N, Host) ->
    Image2 = imagelib:read(Host, "test2.jpg"),
    io:format("Image2 = ~p~n", [Image2]),
    imagelib:scale(Host, Image2, 800, 800),
    io:format("Image2 after scale = ~p~n", [Image2]),
    imagelib:display(Host, Image2),
    imagelib:delete(Host, Image2),
    test_del(N-1, Host).

test5() ->
    {Host, _} = init(),
    test_del(10, Host).



