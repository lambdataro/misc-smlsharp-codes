SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: JSONImport.smi main.smi JSONImport.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
JSONImport.o: JSONImport.sml JSONImport.smi
	$(SMLSHARP) $(SMLFLAGS) -o JSONImport.o -c JSONImport.sml
main.o: main.sml JSONImport.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
