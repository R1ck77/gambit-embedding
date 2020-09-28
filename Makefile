.PHONY: clean run all

LDFLAGS_OPENGL=`pkg-config --libs opengl`
LDFLAGS_SDL=`pkg-config --libs sdl2`
CFLAGS= `pkg-config --cflags opengl sdl2` -fPIC
LDFLAGS= $(LDFLAGS_SDL) $(LDFLAGS_OPENGL)

run: all opengl.o1
	./sdl

all: sdl opengl.o1

opengl.o1: opengl.o opengl.o1.o
	gcc -shared -o $@ $^ $(LDFLAGS_OPENGL) 

opengl.o1.o: opengl.o1.c
	gsc -obj -cc-options "-fPIC -D___DYNAMIC" -o $@ $^

opengl.o: opengl.o1.c
	gsc -obj -cc-options "-fPIC -D___DYNAMIC" -o $@ opengl.c

opengl.o1.c: opengl.scm
	gsc -link -flat -o $@ $^

sdl: sdl.scm
	gsc -exe -o $@ -cc-options "$(CFLAGS)" -ld-options "$(LDFLAGS_SDL)" $<

clean:
	rm -f sdl opengl.o opengl.o1.o opengl.c opengl.o1.* opengl.o1
