-module(build_erl).
-export([test/0]).

param_func(_Out_file, _T, _Pname, _Pname_type,_N) ->
    "".


body_func(Out_file, Command, Param_names, _Param_lines) ->
    %Parameters = util:join(",", Param_names),
    Parameters = case length(Param_names) of
		     0 ->
			 "";
		     _ ->
			 ","++util:join(",",lists:map(fun util:capitalize/1, Param_names))
		 end,
    io:format(Out_file, "~s(Host, Image~s) ->~n", [Command, Parameters]),
    io:format(Out_file, "\trpc(Host, {~s,Image~s}).~n~n",[Command, Parameters]),
    ok.

bad_param_func(Out_file, Command, Reason) ->
    io:format(Out_file, "%%~s not implemented because of parameter ~s~n", [Command, Reason]).

test() ->
    case file:open("imagelib.erl", write) of
	{ok, Out_file} ->
	    io:format(Out_file, "-module(imagelib).~n",[]),
	    io:format(Out_file, "-compile(export_all).~n~n",[]),
	    io:format(Out_file, "rpc(Host, Query) ->~n", []),
	    io:format(Out_file, "    {any, Host} ! {self(), Query},~n",[]),
	    io:format(Out_file, "    receive~n",[]),
	    io:format(Out_file, "	Reply ->~n",[]),
	    io:format(Out_file, "	    Reply~n",[]),
	    io:format(Out_file, "    end.~n~n",[]),
	    io:format(Out_file, "start() ->~n",[]),
	    io:format(Out_file, "    {ok, Hostname} = inet:gethostname(),~n",[]),
	    io:format(Out_file, "    list_to_atom(\"c1@\" ++ Hostname).~n~n",[]),
	    io:format(Out_file, "read(Host, File) ->~n",[]),
	    io:format(Out_file, "    rpc(Host, {read, File}).~n~n",[]),
	    build_server:make_all("image.h", Out_file, fun body_func/4, fun param_func/5, fun bad_param_func/3);
	{error, Reason} ->
	    io:format("couldn't open file ~p~n", [Reason])
    end,
    init:stop().


