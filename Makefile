.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

.yrl.erl:
	erlc -W $<

ERL = erl -boot start_clean

MODS = chp2 util build_cpp build_erl build_server test example

all: im imagelib.beam

im: im_commands.h im.cpp
	gcc im.cpp -o im `Magick++-config --cppflags --cxxflags --ldflags --libs` -I/usr/lib/erlang/lib/erl_interface-3.5.5.1/include -L/usr/lib/erlang/lib/erl_interface-3.5.5.1/lib -lerl_interface -lei `pkg-config --libs gthread` -fno-stack-limit

im_commands.h: compile
	${ERL} -pa '/home/bill/src/imerl' -s build_cpp start -noshell

imagelib.beam: compile imagelib.in
	${ERL} -pa '/home/bill/src/imerl' -s build_erl start -noshell
	erlc -W imagelib.erl

compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump *.o im

