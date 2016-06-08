PROJ=WordCount
JarFile=$(PROJ).jar
MainFunc=edu.ntu.pp2011.$(PROJ)
LocalInDir=./input
LocalOutDir=/tmp/$(USER)/$(PROJ)-output
CopyOutDir=./$(PROJ)-output/$(PROJ)-output/*
dfsInDir=/user/hadoop/$(USER)
dfsinput=/user/hadoop/$(USER)/input
dfsoutput=/user/hadoop/$(USER)/$(PROJ)-output

all: class jar run output peek clean

class:
	-rm -rf $(PROJ)
	mkdir -p $(PROJ)
	hadoop com.sun.tools.javac.Main -d $(PROJ) $(PROJ).java
jar: 
	-rm -f $(JarFile)
	jar cvf $(JarFile) -C $(PROJ) .

run:
	-hadoop fs -rm -r $(dfsinput)	
	-hadoop fs -rm -r $(dfsoutput)
	hadoop fs -mkdir -p $(dfsInDir) 
	-hadoop fs -put $(LocalInDir) $(dfsInDir) 
	hadoop jar $(JarFile) $(MainFunc) $(dfsinput) $(dfsoutput)

output:
	rm -rf $(LocalOutDir)
	mkdir -p $(LocalOutDir)
	hadoop fs -get $(dfsoutput) $(LocalOutDir)
	cp -r $(LocalOutDir) .

peek:
	head $(CopyOutDir)

clean:
	-hadoop fs -rm -r $(dfsinput)	
	hadoop fs -rm -r $(dfsoutput)

help:
	@echo "Usage:"
	@echo " make class   - Compile to class file."
	@echo " make jar     - Build Jar File."
	@echo " make clean   - Clean up Output directory on HDFS."
	@echo " make output  - Download output file."
	@echo " make help    - Show Makefile options."
	@echo " "
	@echo "Example:"
	@echo " make class && make jar && make run && make output && make clean"

