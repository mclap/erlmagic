-module(example2).
-compile(export_all).

do_one(Source_dir, Dest_dir, Name) ->
    io:format("copy " ++ Source_dir ++ "/" ++ Name ++ " to " ++ Dest_dir ++ "/" ++ Name ++ "~n", []).

start() ->
    Source_dir = ".",
    Dest_dir = ".",
    MakeDoOne = fun(Source, Dest) -> (fun(N) -> do_one(Source, Dest, N) end) end,
    DoOne = MakeDoOne(Source_dir, Dest_dir),
    lists:foreach(DoOne, [filename:basename(X) || X <- filelib:wildcard(Source_dir ++ "/*.jpg")]).
 
			
