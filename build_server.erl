-module(build_server).
-export([test/0]).

get_type("void") ->
    "";
get_type(T) ->
    hd(lists:reverse(T)).

param_base_type(T) ->
    Rval = case get_type(T) of
	"Blob" ->
	    "??Blob";
	"ChannelType" ->
	    "??ChannelType";
	"Color" ->
	    "??Color";
	"Geometry" ->
	    "??Geometry";
	"Image" ->
	    "??Image";
	"ImageType" ->
	    "??ImageType";
	"MagickEvaluateOperator" ->
	    "??MagickEvaluateOperator";
	"PaintMethod" ->
	    "??PaintMethod";
	"Quantum" ->
	    "??Quantum";
	"StorageType" ->
	    "??StorageType";
	"bool" ->
	    "ERL_INT_VALUE";
	"char" ->
	    "ERL_INT_VALUE";
	"double" ->
	    "ERL_FLOAT_VALUE";
	"int" ->
	    "ERL_INT_VALUE";
	"std::string" ->
	    "erl_iolist_to_string";
	"std::string&" ->
	    "erl_iolist_to_string";
	"void" ->
	    "void";
	[] ->
	    "void";
	"std::list<Magick::Drawable>" ->
	    "??std::list<Magick::Drawable>";
	"Drawable" ->
	    "??Drawable";
	"GravityType" ->
	    "??GravityType";
	"CompositeOperator" ->
	    "??CompositeOperator";
	"DrawableAffine" ->
	    "??DrawableAffine";
	"NoiseType" ->
	    "??NoiseType";
	"unsigned" ->
	    "??unsigned"
    end,
    case string:substr(Rval, 1, 2) of
	"??" ->
	    %io:format("Rval = ~s~n", [Rval]),
	    throw("Bad param");
	_ ->
	    Rval
    end.
	 
param_name(H) ->
    R = chp2:param_name(H),
    case R of
	nil ->
	    nil;
        [$*|_] ->
	    throw("Bad param");
	_ ->
	    string:strip(string:strip(R, both, $&), both, $_)
    end.

make_param(L, N) ->
    make_param(L, N, [], []).

make_param([], _, Acc1, Acc2) ->
    {lists:reverse(Acc1), lists:reverse(Acc2)};
make_param([H|L], N, Acc1, Acc2) ->
    Pname = param_name(H),
    T = get_type(chp2:param_type(H)),
    case param_base_type(chp2:param_type(H)) of 
	"void" ->
	    Acc21 = Acc2,
	    Acc11 = Acc1;
	Pname_type ->
	    Acc21 = [lists:flatten(io_lib:format("\t\t~s ~s = ~s(erl_element(~B, msg));~n", [T, Pname, Pname_type, N]))|Acc2],
	    Acc11 = [param_name(H) | Acc1]
    end,
    make_param(L, N + 1, Acc11, Acc21).

bad_cmd(Command) ->
    lists:member(Command, ["compose", "read"]).

print_param(L) ->
    io:format("~s", [L]).

make_one(Row) ->
    %io:format("~p~n", [Row]),
    Command = chp2:name(Row),
    try 
	case bad_cmd(Command) of 
	    false ->
		{Param_names, Param_lines} = make_param(chp2:param_vals(Row), 3), 
		Parameters = util:join(",", Param_names),
		io:format("\tif (command == \"" ++ Command ++ "\") {~n",[]),
		io:format("\t\tint iid = ERL_INT_VALUE(erl_element(2, msg));~n", []),
		io:format("\t\tImage image = image_list[iid];~n"), 
		lists:foreach(fun print_param/1, Param_lines),
		io:format("\t\timage.~s(~s);~n", [Command, Parameters]),
		io:format("\t\timage_list[iid] = image;~n", []),
		io:format("\t\terl_send(fd, pid, ok);~n",[]),
		io:format("\t}~n",[]);
	    true ->
		io:format("\t\t//~s not implemented~n", [Command])
	end
    catch
	throw:"Bad param" ->
	    io:format("\t\t//~s not implemented because of parameters~n", [Command])
    end.

make_all(F) ->
    lists:foreach(fun make_one/1, chp2:parse_file(F)).

test() ->
    make_all("image.h").


	      
