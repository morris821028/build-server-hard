#!/usr/bin/python
import os

student = open('students')


for line in student.readlines():
	line = line[:-1]
	print line
	cmd = "useradd -m -s /bin/bash -d /home/pp2016class/%s %s" % (line, line)
	psw = "echo %s:%s | chpasswd" % (line, line)
	print cmd
	print psw
	assert os.system(cmd) == 0
	assert os.system(psw) == 0
#	bash = "chsh -s /bin/bash %s" % line
#	print bash
#	assert os.system(bash) == 0

	
