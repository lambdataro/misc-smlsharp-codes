SMLSHARP = smlsharp
SMLFLAGS = -O2
CC = gcc
CFLAGS = -O2
LIBS = -lSDL2 -lSDL2_ttf SDL2_stub.o
all: Test01 Test02 Test03 Test04
Test01: SDL2.smi Test01.smi SDL2.o Test01.o SDL2_stub.o
	$(SMLSHARP) $(LDFLAGS) -o Test01 Test01.smi $(LIBS)
Test02: SDL2.smi Test02.smi SDL2.o Test02.o SDL2_stub.o
	$(SMLSHARP) $(LDFLAGS) -o Test02 Test02.smi $(LIBS)
Test03: SDL2.smi Test03.smi SDL2.o Test03.o SDL2_stub.o
	$(SMLSHARP) $(LDFLAGS) -o Test03 Test03.smi $(LIBS)
Test04: SDL2.smi Test04.smi SDL2.o SDL2_ttf.o Test04.o SDL2_stub.o
	$(SMLSHARP) $(LDFLAGS) -o Test04 Test04.smi $(LIBS)
SDL2.o: SDL2.sml SDL2.smi
	$(SMLSHARP) $(SMLFLAGS) -o SDL2.o -c SDL2.sml
SDL2_ttf.o: SDL2_ttf.sml SDL2_ttf.smi SDL2.sml SDL2.smi
	$(SMLSHARP) $(SMLFLAGS) -o SDL2_ttf.o -c SDL2_ttf.sml
SDL2_stub.o: SDL2_stub.c
	$(CC) $(CFLAGS) -o SDL2_stub.o -c SDL2_stub.c
Test01.o: Test01.sml SDL2.smi Test01.smi
	$(SMLSHARP) $(SMLFLAGS) -o Test01.o -c Test01.sml
Test02.o: Test02.sml SDL2.smi Test02.smi
	$(SMLSHARP) $(SMLFLAGS) -o Test02.o -c Test02.sml
Test03.o: Test03.sml SDL2.smi Test03.smi
	$(SMLSHARP) $(SMLFLAGS) -o Test03.o -c Test03.sml
Test04.o: Test04.sml SDL2.smi SDL2_ttf.smi Test04.smi
	$(SMLSHARP) $(SMLFLAGS) -o Test04.o -c Test04.sml
clean:
	rm -f *.o Test01 Test02 Test03
