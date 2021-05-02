SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: Tree.smi main.smi Tree.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
Tree.o: Tree.sml Tree.smi
	$(SMLSHARP) $(SMLFLAGS) -o Tree.o -c Tree.sml
main.o: main.sml Tree.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
