import os

student = open('students')


for line in student.readlines():
	line = line[:-1]
	print line
	cmd = "sudo chown -R %s:%s /home/pp2016/%s" % (line, line, line)
	print cmd
	assert os.system(cmd) == 0
#	bash = "chsh -s /bin/bash %s" % line
#	print bash
#	assert os.system(bash) == 0

	
