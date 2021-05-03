SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: ReadIntStream.smi main.smi ReadIntStream.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
ReadIntStream.o: ReadIntStream.sml ReadIntStream.smi
	$(SMLSHARP) $(SMLFLAGS) -o ReadIntStream.o -c ReadIntStream.sml
main.o: main.sml ReadIntStream.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
