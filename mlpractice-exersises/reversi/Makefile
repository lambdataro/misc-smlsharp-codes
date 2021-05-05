SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main
Main: Game.smi Cpu.smi Main.smi Game.o Cpu.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
Game.o: Game.sml Game.smi
	$(SMLSHARP) $(SMLFLAGS) -o Game.o -c Game.sml
Cpu.o: Cpu.sml Game.smi Cpu.smi
	$(SMLSHARP) $(SMLFLAGS) -o Cpu.o -c Cpu.sml
Main.o: Main.sml Game.smi Cpu.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
