.PHONY: clean run all

run: all
	./test

all: test

test: test.scm
	gsc -exe -o $@ $<

clean:
	rm -f test
