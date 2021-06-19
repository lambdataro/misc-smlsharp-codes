SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: animation
animation: animation.sml animation.o
	$(SMLSHARP) $(LDFLAGS) -o animation animation.sml $(LIBS)
animation.o: animation.sml animation.sml
	$(SMLSHARP) $(SMLFLAGS) -o animation.o -c animation.sml
