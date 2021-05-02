SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: testDict
testDict: MakeDict.smi IntDict.smi StringDict.smi testDict.smi MakeDict.o \
 IntDict.o StringDict.o testDict.o
	$(SMLSHARP) $(LDFLAGS) -o testDict testDict.smi $(LIBS)
MakeDict.o: MakeDict.sml MakeDict.smi
	$(SMLSHARP) $(SMLFLAGS) -o MakeDict.o -c MakeDict.sml
IntDict.o: IntDict.sml MakeDict.smi IntDict.smi
	$(SMLSHARP) $(SMLFLAGS) -o IntDict.o -c IntDict.sml
StringDict.o: StringDict.sml MakeDict.smi StringDict.smi
	$(SMLSHARP) $(SMLFLAGS) -o StringDict.o -c StringDict.sml
testDict.o: testDict.sml MakeDict.smi IntDict.smi StringDict.smi testDict.smi
	$(SMLSHARP) $(SMLFLAGS) -o testDict.o -c testDict.sml
