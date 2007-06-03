-module(build_cpp).
-export([test/0]).

param_func(_Out_file, T, Pname, Pname_type, N) ->
    io_lib:format("\t\t~s ~s = ~s(erl_element(~B, msg));~n", [T, Pname, Pname_type, N]).

body_func(Out_file, Command, Param_names, Param_lines) ->
    Parameters = util:join(",", Param_names),
    io:format(Out_file, "\tif (command == \"" ++ Command ++ "\") {~n",[]),
    io:format(Out_file, "\t\tint iid = ERL_INT_VALUE(erl_element(2, msg));~n", []),
    io:format(Out_file, "\t\tImage image = image_list[iid];~n",[]), 
    lists:foreach(fun(L) -> io:format(Out_file, "~s", [L]) end, Param_lines),
    io:format(Out_file, "\t\timage.~s(~s);~n", [Command, Parameters]),
    io:format(Out_file, "\t\timage_list[iid] = image;~n", []),
    io:format(Out_file, "\t\terl_send(fd, pid, ok);~n",[]),
    io:format(Out_file, "\t}~n",[]),
    ok.

bad_param_func(Out_file, Command, Reason) ->
    io:format(Out_file, "\t\t//~s not implemented because of parameter ~s~n", [Command, Reason]).

test() ->
    case file:open("im_commands.h", write) of
	{ok, Out_file} ->
	    build_server:make_all("image.h", Out_file, fun body_func/4, fun param_func/5, fun bad_param_func/3);
	{error, Reason} ->
	    io:format("couldn't open file ~p~n", [Reason])
    end,
    init:stop().

