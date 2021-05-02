SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: Libs.smi PrintInterface.smi main.smi Libs.o PrintInterface.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
Libs.o: Libs.sml Libs.smi
	$(SMLSHARP) $(SMLFLAGS) -o Libs.o -c Libs.sml
PrintInterface.o: PrintInterface.sml PrintInterface.smi
	$(SMLSHARP) $(SMLFLAGS) -o PrintInterface.o -c PrintInterface.sml
main.o: main.sml Libs.smi PrintInterface.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
