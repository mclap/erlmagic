-module(build_server).
-export([make_all/4]).

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
	    throw({"Bad param", Rval});
	_ ->
	    Rval
    end.
	 
param_name(H) ->
    R = chp2:param_name(H),
    case R of
	nil ->
	    nil;
        [$*|_] ->
	    throw({"Bad param", R});
	_ ->
	    string:strip(string:strip(R, both, $&), both, $_)
    end.

make_param(L, N, Param_fun) ->
    make_param(L, N, Param_fun, [], []).

make_param([], _, _, Acc1, Acc2) ->
    {lists:reverse(Acc1), lists:reverse(Acc2)};
make_param([H|L], N, Param_fun, Acc1, Acc2) ->
    Pname = param_name(H),
    T = get_type(chp2:param_type(H)),
    case param_base_type(chp2:param_type(H)) of 
	"void" ->
	    Acc21 = Acc2,
	    Acc11 = Acc1;
	Pname_type ->
	    Acc21 = [lists:flatten(Param_fun(T, Pname, Pname_type, N))|Acc2],
	    Acc11 = [param_name(H) | Acc1]
    end,
    make_param(L, N + 1, Param_fun, Acc11, Acc21).

bad_cmd(Command) ->
    lists:member(Command, ["compose", "read"]).


make_one(Row, Body_fun, Param_fun, Bad_param_fun) ->
    %io:format("~p~n", [Row]),
    Command = chp2:name(Row),
    try 
	case bad_cmd(Command) of 
	    false ->
		{Param_names, Param_lines} = make_param(chp2:param_vals(Row), 3, Param_fun), 
		Body_fun(Command, Param_names, Param_lines);
	    true ->
		io:format("\t\t//~s not implemented~n", [Command])
	end
    catch
	throw:{"Bad param", Reason} ->
	    Bad_param_fun(Command, Reason)
    end.

make_all(F, Body_fun, Param_fun, Bad_param_fun) ->
    MakeFunc =  fun(Bf, Pf, Bpf) -> (fun(Row) -> make_one(Row, Bf, Pf, Bpf) end) end,
    Func = MakeFunc(Body_fun, Param_fun, Bad_param_fun),
    lists:foreach(Func, chp2:parse_file(F)).

	      
