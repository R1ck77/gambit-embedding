.PHONY: clean run all

run: all
	./test

all: test

test: test.scm
	gsc -exe -o $@ -cc-options "`pkg-config --cflags sdl2`" -ld-options "`pkg-config --libs sdl2`" $<

clean:
	rm -f test
