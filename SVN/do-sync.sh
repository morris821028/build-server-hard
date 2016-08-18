#!/bin/bash

# svnadmin create svn-mirror
# svnsync init svn+ssh://taiji@localhost/home/taiji/svn-mirror svn+ssh://morris1028@taiji.csie.ntu.edu.tw/home/svnroot

date | cat >> sync.log
svnsync synchronize file:///home/taiji/svn-mirror svn+ssh://morris1028@taiji.csie.ntu.edu.tw/home/svnroot 2>> sync.log
