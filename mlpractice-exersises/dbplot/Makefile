SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS = -lcairo
all: dbplot
dbplot: Cairo.smi Draw.smi Graph.smi Main.smi dbplot.smi Cairo.o Draw.o \
 Graph.o Main.o dbplot.o
	$(SMLSHARP) $(LDFLAGS) -o dbplot dbplot.smi $(LIBS)
Cairo.o: Cairo.sml Cairo.smi
	$(SMLSHARP) $(SMLFLAGS) -o Cairo.o -c Cairo.sml
Draw.o: Draw.sml Cairo.smi Draw.smi
	$(SMLSHARP) $(SMLFLAGS) -o Draw.o -c Draw.sml
Graph.o: Graph.sml Draw.smi Graph.smi
	$(SMLSHARP) $(SMLFLAGS) -o Graph.o -c Graph.sml
Main.o: Main.sml Draw.smi Graph.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
dbplot.o: dbplot.sml Main.smi dbplot.smi
	$(SMLSHARP) $(SMLFLAGS) -o dbplot.o -c dbplot.sml
