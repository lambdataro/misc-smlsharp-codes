SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main
Main: FunctionTest.smi Main.smi FunctionTest.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
FunctionTest.o: FunctionTest.sml FunctionTest.smi
	$(SMLSHARP) $(SMLFLAGS) -o FunctionTest.o -c FunctionTest.sml
Main.o: Main.sml FunctionTest.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
