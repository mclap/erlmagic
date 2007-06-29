-module(example2).
-compile(export_all).

do_one(Source_dir, Dest_dir, Host, Name) ->
    Image = imagelib:read(filename:join(Source_dir, Name)),
    imagelib:scale(Host, Image, "30%"),
    imagelib:border(Host, Image, "2x2"),
    imagelib:sharpen(Host, Image, 0.0, 1.0),
    io:format("copy " ++ Source_dir ++ "/" ++ Name ++ " to " ++ Dest_dir ++ "/" ++ Name ++ "~n", []).

start() ->
    Source_dir = ".",
    Dest_dir = ".",
    MakeDoOne = fun(Source, Dest, Host) -> (fun(N) -> do_one(Source, Dest, Host, N) end) end,
    DoOne = MakeDoOne(Source_dir, Dest_dir, imagelib:start()),
    lists:foreach(DoOne, [filename:basename(X) || X <- filelib:wildcard(Source_dir ++ "/*.jpg")]).
 
			
