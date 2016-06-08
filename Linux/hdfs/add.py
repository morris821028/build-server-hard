#!/usr/bin/python
import os

student = open('students')


for line in student.readlines():
	line = line[:-1]
	print line
	cmd = "hdfs dfs -mkdir -p /user/%s"  % (line)
	assert os.system(cmd) == 0
	cmd = "hdfs dfs -chown %s:%s /user/%s" % (line, line, line)
	assert os.system(cmd) == 0

	
