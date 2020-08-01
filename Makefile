.PHONY: run clean all

EXEC=gambit-embedding

run: all
	./$(EXEC)

all: $(EXEC)

$(EXEC): gambit-embedding.c
	gcc -o $@ $<

clean:
	rm -rf $(EXEC)

