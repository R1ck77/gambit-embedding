.PHONY: clean run all

run: all
	./sdl

all: sdl

sdl: sdl.scm
	gsc -exe -o $@ -cc-options "`pkg-config --cflags sdl2 opengl`" -ld-options "`pkg-config --libs sdl2 opengl`" $<

clean:
	rm -f sdl
