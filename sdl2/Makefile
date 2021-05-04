SMLSHARP = smlsharp
SMLFLAGS = -O2
CC = gcc
CFLAGS = -O2
LIBS = -lSDL2 SDL2_stub.o
all: Test01
Test01: SDL2.smi Test01.smi SDL2.o SDL2_stub.o Test01.o
	$(SMLSHARP) $(LDFLAGS) -o Test01 Test01.smi $(LIBS)
SDL2.o: SDL2.sml SDL2.smi
	$(SMLSHARP) $(SMLFLAGS) -o SDL2.o -c SDL2.sml
SDL2_stub.o: SDL2_stub.c
	$(CC) $(CFLAGS) -o SDL2_stub.o -c SDL2_stub.c
Test01.o: Test01.sml SDL2.smi Test01.smi
	$(SMLSHARP) $(SMLFLAGS) -o Test01.o -c Test01.sml

clean:
	rm -f *.o Test01
