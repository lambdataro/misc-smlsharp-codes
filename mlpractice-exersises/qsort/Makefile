SMLSHARP = smlsharp
SMLFLAGS = -O2
CC = gcc
LIBS = mt19937-64.o
all: MTTest
MTTest: MT.smi Qsort.smi MTTest.smi MT.o Qsort.o MTTest.o mt19937-64.o
	$(SMLSHARP) $(LDFLAGS) -o MTTest MTTest.smi $(LIBS)
MT.o: MT.sml MT.smi
	$(SMLSHARP) $(SMLFLAGS) -o MT.o -c MT.sml
Qsort.o: Qsort.sml Qsort.smi
	$(SMLSHARP) $(SMLFLAGS) -o Qsort.o -c Qsort.sml
MTTest.o: MTTest.sml MT.smi Qsort.smi MTTest.smi
	$(SMLSHARP) $(SMLFLAGS) -o MTTest.o -c MTTest.sml
mt19937-64.o: mt19937-64.c mt64.h
	$(CC) -o mt19937-64.o -c mt19937-64.c
