SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: myFirstSMLSharpCommand
myFirstSMLSharpCommand: myFirstSMLSharp.smi myFirstSMLSharpCommand.smi \
 myFirstSMLSharp.o myFirstSMLSharpCommand.o
	$(SMLSHARP) $(LDFLAGS) -o myFirstSMLSharpCommand \
 myFirstSMLSharpCommand.smi $(LIBS)
myFirstSMLSharp.o: myFirstSMLSharp.sml myFirstSMLSharp.smi
	$(SMLSHARP) $(SMLFLAGS) -o myFirstSMLSharp.o -c myFirstSMLSharp.sml
myFirstSMLSharpCommand.o: myFirstSMLSharpCommand.sml myFirstSMLSharp.smi \
 myFirstSMLSharpCommand.smi
	$(SMLSHARP) $(SMLFLAGS) -o myFirstSMLSharpCommand.o -c \
 myFirstSMLSharpCommand.sml
