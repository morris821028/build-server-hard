NAME = WordCount
INPUT = /user/hadoop/wordcnt-input/*
OUTPUT = wordcnt-output

CP = "/usr/local/hadoop-2.7/share/hadoop/common/hadoop-common-2.7.2.jar:/usr/local/hadoop-2.7/share/hadoop/common/lib/commons-cli-1.2.jar:/usr/local/hadoop-2.7/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.2.jar"

build:
	mkdir -p classes
#	javac -classpath $(CP) -d ./classes ./src/*.java
	hadoop com.sun.tools.javac.Main -d ./classes ./src/*.java
	jar -cvf $(NAME).jar -C ./classes/ .
run:
	
	hadoop jar $(NAME).jar $(NAME) $(INPUT) $(OUTPUT)
	hadoop dfs -copyToLocal $(OUTPUT) $(OUTPUT)
clean:
	-rm -rf classes
	-rm $(NAME).jar
	-hdfs dfs -rm -r -f $(OUTPUT)

