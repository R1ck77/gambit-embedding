.PHONY: clean run all

CFLAGS_OPENGL=`pkg-config --cflags opengl` -fPIC -D___DYNAMIC
LDFLAGS_OPENGL=`pkg-config --libs opengl`

CFLAGS_SDL=`pkg-config --cflags sdl2` -fPIC -D___DYNAMIC
LDFLAGS_SDL=`pkg-config --libs sdl2`

CFLAGS=$(CFLAGS_SDL) $(CFLAGS_OPENGL)
LDFLAGS= $(LDFLAGS_SDL) $(LDFLAGS_OPENGL)

run: all
	./demo

all: demo

## This blocks repeats with SDL!
opengl.o1: opengl.o opengl.o1.o
	gcc -shared -o $@ $^ $(LDFLAGS_OPENGL) 

opengl.o1.o: opengl.o1.c
	gsc -obj -cc-options "-fPIC -D___DYNAMIC" -o $@ $^

opengl.o: opengl.o1.c
	gsc -obj -cc-options "-fPIC -D___DYNAMIC" -o $@ opengl.c

opengl.o1.c: opengl.scm
	gsc -link -flat -o $@ $^
### End of OpenGL block

## Duplicated with OpenGL
sdl.o1: sdl.o sdl.o1.o
	gcc -shared -o $@ $^ $(LDFLAGS_SDL) 

sdl.o1.o: sdl.o1.c
	gsc -obj -cc-options "$(CFLAGS_SDL)" -o $@ $^

sdl.o: sdl.o1.c
	gsc -obj -cc-options "$(CFLAGS_SDL)" -o $@ sdl.c

sdl.o1.c: sdl.scm 
	gsc -link -flat -o $@ $^
## end of duplicated bloc

demo: demo.scm opengl.o1 sdl.o1
	gsc -exe -o $@  demo.scm

c-demo: c-demo.c
	gsc -exe c-demo.c 

clean:
	rm -f *.o *.o1 *.o1.* opengl*.c sdl*.c demo
