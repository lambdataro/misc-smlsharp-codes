SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main
Main: Game.smi Main.smi Game.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
Game.o: Game.sml Game.smi
	$(SMLSHARP) $(SMLFLAGS) -o Game.o -c Game.sml
Main.o: Main.sml Game.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
