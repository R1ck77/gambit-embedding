.PHONY: run clean all

EXEC=gambit-embedding
GAMBIT_LIBS=-L/usr/lib/x86_64-linux-gnu/gambit4 -lgambit

run: all
	./$(EXEC)

all: $(EXEC)

$(EXEC): gambit-embedding.c
	gcc -o $@ $< $(GAMBIT_LIBS)

clean:
	rm -rf $(EXEC) *.o* *_.c

