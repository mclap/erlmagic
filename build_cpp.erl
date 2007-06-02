-module(build_cpp).
-export([test/0]).

param_func(T, Pname, Pname_type, N) ->
    io_lib:format("\t\t~s ~s = ~s(erl_element(~B, msg));~n", [T, Pname, Pname_type, N]).

body_func(Command, Param_names, Param_lines) ->
    Parameters = util:join(",", Param_names),
    io:format("\tif (command == \"" ++ Command ++ "\") {~n",[]),
    io:format("\t\tint iid = ERL_INT_VALUE(erl_element(2, msg));~n", []),
    io:format("\t\tImage image = image_list[iid];~n"), 
    lists:foreach(fun(L) -> io:format("~s", [L]) end, Param_lines),
    io:format("\t\timage.~s(~s);~n", [Command, Parameters]),
    io:format("\t\timage_list[iid] = image;~n", []),
    io:format("\t\terl_send(fd, pid, ok);~n",[]),
    io:format("\t}~n",[]),
    ok.

bad_param_func(Command, Reason) ->
    io:format("\t\t//~s not implemented because of parameter ~s~n", [Command, Reason]).

test() ->
    build_server:make_all("image.h", fun body_func/3, fun param_func/4, fun bad_param_func/2).
