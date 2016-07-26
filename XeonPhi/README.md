## Install Xeon Phi MIC module ##

```
sudo apt-get install build-essential linux-headers-generic
```

* Linux 3.13 kernel `git clone https://github.com/pentschev/mpss-modules`
* Linux 3.19 kernel `git clone https://github.com/gjvdbraak/mpss-modules`

```
cd mpss-modules && make && sudo make install
sudo depmod
```

```
# lsmod | grep -i mic
# sudo remod mic_host
# vim /etc/modprobe.d/blacklist.conf
#     add line "blacklist mic_host"
sudo modprobe mic
```

```
apt-get install alien
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9226/mpss-3.7.1-linux.tar
tar xf mpss-3.7.1-linux.tar
cd mpss-3.7.1 && alien --scripts *.rpm && dpkg -i *.deb
vim /etc/ld.so.conf.d/zz_x86_64-compat.conf 
micctrl --initdefaults
cp /etc/mpss/mpss.ubuntu /etc/init.d/mpss
service mpss stop
update-rc.d mpss defaults 99 10
service mpss start
apt-get install nfs-kernel-server
mkdir /micNfs

vim /etc/exports
# add "/micNfs 172.31.1.1(rw,no_root_squash)" without quotes.
# add "/var/michome 172.31.0.0/16(rw)"
vim /etc/hosts.allow
# add "ALL:172.31.1.1"
micctrl --addnfs=172.31.1.254:/micNfs --dir=/micNfs

useradd -U -m -u 400 micuser
groupmod -g 400 micuser
```

## Install Xeon Phi Compiler

You can google search `intel parallel student`. Choose [Qualify for Free Software - Student | Intel® Software](https://software.intel.com/en-us/qualify-for-free-software/student) page.

## Set Intel Xeon Phi Env

Custom Install path `/tools/intel`

```
sudo vim /etc/bash.bashrc
```

add following setting.

```
export PATH="/tools/intel/bin:$PATH"
export LD_LIBRARY_PATH="/tools/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/compiler/lib/intel64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/tools/intel//srallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/mkl/lib/intel64:$LD_LIBRARY_PATH"
export SINK_LD_LIBRARY_PATH="/tools/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/compiler/lib/mic"
```


## Set Access Authorization

group name `research`

```
cd /dev && ls -la | grep -i mic
sudo chgrp -R research /dev/mic
sudo chmod 660 /dev/mic/*
sudo chgrp -R research /dev/mic0
# if you have more mic
# sudo chgrp -R research /dev/mic*
```
