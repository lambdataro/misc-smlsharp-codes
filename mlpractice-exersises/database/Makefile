SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main Setup Update Analyze SelectPrefTest
Main: DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 AnalyzeDB.smi Main.smi DBSchema.o ../jsonImport/JSONImport.o DataSource.o \
 DBSetup.o AnalyzeDB.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
Setup: DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 Setup.smi DBSchema.o ../jsonImport/JSONImport.o DataSource.o DBSetup.o Setup.o
	$(SMLSHARP) $(LDFLAGS) -o Setup Setup.smi $(LIBS)
Update: DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 Update.smi DBSchema.o ../jsonImport/JSONImport.o DataSource.o DBSetup.o \
 Update.o
	$(SMLSHARP) $(LDFLAGS) -o Update Update.smi $(LIBS)
Analyze: DBSchema.smi AnalyzeDB.smi Analyze.smi DBSchema.o AnalyzeDB.o Analyze.o
	$(SMLSHARP) $(LDFLAGS) -o Analyze Analyze.smi $(LIBS)
SelectPrefTest: DBSchema.smi AnalyzeDB.smi SelectPrefTest.smi DBSchema.o \
 AnalyzeDB.o SelectPrefTest.o
	$(SMLSHARP) $(LDFLAGS) -o SelectPrefTest SelectPrefTest.smi $(LIBS)
DBSchema.o: DBSchema.sml DBSchema.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSchema.o -c DBSchema.sml
../jsonImport/JSONImport.o: ../jsonImport/JSONImport.sml \
 ../jsonImport/JSONImport.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../jsonImport/JSONImport.o -c \
 ../jsonImport/JSONImport.sml
DataSource.o: DataSource.sml DBSchema.smi ../jsonImport/JSONImport.smi \
 DataSource.smi
	$(SMLSHARP) $(SMLFLAGS) -o DataSource.o -c DataSource.sml
DBSetup.o: DBSetup.sml DBSchema.smi ../jsonImport/JSONImport.smi \
 DataSource.smi DBSetup.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSetup.o -c DBSetup.sml
AnalyzeDB.o: AnalyzeDB.sml DBSchema.smi AnalyzeDB.smi
	$(SMLSHARP) $(SMLFLAGS) -o AnalyzeDB.o -c AnalyzeDB.sml
Main.o: Main.sml DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi AnalyzeDB.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
Setup.o: Setup.sml DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi Setup.smi
	$(SMLSHARP) $(SMLFLAGS) -o Setup.o -c Setup.sml
Update.o: Update.sml DBSchema.smi ../jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi Update.smi
	$(SMLSHARP) $(SMLFLAGS) -o Update.o -c Update.sml
Analyze.o: Analyze.sml DBSchema.smi AnalyzeDB.smi Analyze.smi
	$(SMLSHARP) $(SMLFLAGS) -o Analyze.o -c Analyze.sml
SelectPrefTest.o: SelectPrefTest.sml DBSchema.smi AnalyzeDB.smi \
 SelectPrefTest.smi
	$(SMLSHARP) $(SMLFLAGS) -o SelectPrefTest.o -c SelectPrefTest.sml
