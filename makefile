CC = gcc
#Using -Ofast instead of -O3 might result in faster code, but is supported only by newer GCC versions
CFLAGS = -lm -pthread -O3 -march=native -Wall -funroll-loops -Wno-unused-result

BUILDDIR := build
SRCDIR := src

all: dir word2vec distance
dir :
	mkdir -p $(BUILDDIR)
word2vec : $(SRCDIR)/word2vec.c
	$(CC) $(SRCDIR)/word2vec.c -o $(BUILDDIR)/word2vec $(CFLAGS)
distance : $(SRCDIR)/distance.c
	$(CC) $(SRCDIR)/distance.c -o $(BUILDDIR)/distance $(CFLAGS)

clean:
	rm -rf word2vec distance build

