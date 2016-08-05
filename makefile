CC = gcc
#Using -Ofast instead of -O3 might result in faster code, but is supported only by newer GCC versions
CFLAGS = -lm -pthread -O3 -march=native -Wall -funroll-loops -Wno-unused-result

BUILDDIR := bin
SRCDIR := src

all: dir single double distance
dir :
	mkdir -p $(BUILDDIR)
single2vec : $(SRCDIR)/single2vec.c
	$(CC) $(SRCDIR)/single2vec.c -o $(BUILDDIR)/single2vec $(CFLAGS)
double2vec : $(SRCDIR)/double2vec.c
	$(CC) $(SRCDIR)/double2vec.c -o $(BUILDDIR)/double22vec $(CFLAGS)
distance : $(SRCDIR)/distance.c
	$(CC) $(SRCDIR)/distance.c -o $(BUILDDIR)/distance $(CFLAGS)

clean:
	rm -rf bin

