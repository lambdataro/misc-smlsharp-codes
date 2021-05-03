SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: ray
ray: ray.smi ray.o
	$(SMLSHARP) $(LDFLAGS) -o ray ray.smi $(LIBS)
ray.o: ray.sml ray.smi
	$(SMLSHARP) $(SMLFLAGS) -o ray.o -c ray.sml
