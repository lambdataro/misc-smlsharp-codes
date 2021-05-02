SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: ListFunctions.smi main.smi ListFunctions.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
ListFunctions.o: ListFunctions.sml ListFunctions.smi
	$(SMLSHARP) $(SMLFLAGS) -o ListFunctions.o -c ListFunctions.sml
main.o: main.sml ListFunctions.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
