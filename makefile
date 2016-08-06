CC = gcc
#Using -Ofast instead of -O3 might result in faster code, but is supported only by newer GCC versions
CFLAGS = -lm -pthread -O3 -march=native -Wall -funroll-loops -Wno-unused-result

BUILDDIR := bin
SRCDIR := src
ORIGIN := baseline

all: dir single double distance analogy
dir :
	mkdir -p $(BUILDDIR)
single : $(SRCDIR)/single2vec.c
	$(CC) $(SRCDIR)/single2vec.c -o $(BUILDDIR)/single2vec $(CFLAGS)
double : $(SRCDIR)/double2vec.c
	$(CC) $(SRCDIR)/double2vec.c -o $(BUILDDIR)/double2vec $(CFLAGS)
distance : $(ORIGIN)/distance.c
	$(CC) $(ORIGIN)/distance.c -o $(BUILDDIR)/distance $(CFLAGS)
analogy : $(ORIGIN)/compute-accuracy.c
	$(CC) $(ORIGIN)/compute-accuracy.c -o $(BUILDDIR)/compute-accuracy $(CFLAGS)

clean:
	rm -rf bin

