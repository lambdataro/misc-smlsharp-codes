SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS = -lSDL2 -lSDL2_ttf -lSDL2_gfx ../../sdl2/SDL2_stub.o ../qsort/mt19937-64.o
all: Main GuiMain
Main: Game.smi Cpu.smi Main.smi Game.o Cpu.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
GuiMain: Game.smi Cpu.smi ../../sdl2/SDL2.smi ../../sdl2/SDL2_ttf.smi \
 ../../sdl2/SDL2_gfx.smi GuiMain.smi Game.o Cpu.o ../../sdl2/SDL2.o \
 ../../sdl2/SDL2_ttf.o ../../sdl2/SDL2_gfx.o GuiMain.o
	$(SMLSHARP) $(LDFLAGS) -o GuiMain GuiMain.smi $(LIBS)
Game.o: Game.sml Game.smi
	$(SMLSHARP) $(SMLFLAGS) -o Game.o -c Game.sml
Cpu.o: Cpu.sml Game.smi Cpu.smi
	$(SMLSHARP) $(SMLFLAGS) -o Cpu.o -c Cpu.sml
Main.o: Main.sml Game.smi Cpu.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
../../sdl2/SDL2.o: ../../sdl2/SDL2.sml ../../sdl2/SDL2.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../../sdl2/SDL2.o -c ../../sdl2/SDL2.sml
../../sdl2/SDL2_ttf.o: ../../sdl2/SDL2_ttf.sml ../../sdl2/SDL2.smi \
 ../../sdl2/SDL2_ttf.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../../sdl2/SDL2_ttf.o -c \
 ../../sdl2/SDL2_ttf.sml
../../sdl2/SDL2_gfx.o: ../../sdl2/SDL2_gfx.sml ../../sdl2/SDL2.smi \
 ../../sdl2/SDL2_gfx.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../../sdl2/SDL2_gfx.o -c \
 ../../sdl2/SDL2_gfx.sml
GuiMain.o: GuiMain.sml Game.smi Cpu.smi ../../sdl2/SDL2.smi \
 ../../sdl2/SDL2_ttf.smi ../../sdl2/SDL2_gfx.smi GuiMain.smi
	$(SMLSHARP) $(SMLFLAGS) -o GuiMain.o -c GuiMain.sml
