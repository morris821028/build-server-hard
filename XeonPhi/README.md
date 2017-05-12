## Install Xeon Phi MIC module ##

安裝 Xeon Phi 的 MIC 模組

```
sudo apt-get install build-essential linux-headers-generic
```

請用 `uname -a` 確定 Linux kernel 版本，對應下列的 mpss 模組。

* Linux 3.13 kernel `git clone https://github.com/pentschev/mpss-modules`
* Linux 3.19 kernel `git clone https://github.com/gjvdbraak/mpss-modules`

下載完畢，執行下列指令進行安裝和更新。

```
cd mpss-modules && make && sudo make install
sudo depmod
```

這時候應該針測到有一個名為 `mic` 的模組，如果這時候系統已經有 `mic_host` 模組，建議將其移除並加入黑名單，改用 `mic` 模組取代。

```
# lsmod | grep -i mic
# sudo remod mic_host
# vim /etc/modprobe.d/blacklist.conf
#     add line "blacklist mic_host"
sudo modprobe mic
```

MIC 相當於一個獨立的節點，因此系統架構可以視為不一致的，檔案系統採用 NFS 的方式進行掛載，這部份要設置在 `/etc/exports`，以下操作都需要 root 權限。

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

## 安裝 Xeon Phi 編譯工具

上網搜尋關鍵字 `intel parallel student`，找到類似標題 [Qualify for Free Software - Student | Intel® Software](https://software.intel.com/en-us/qualify-for-free-software/student) 的網頁，點選後選擇 Parallel Studio 學生版下載，用學生信箱申請，原則上可以申請多次取得安裝序號，所以不用太擔心。

> 特別注意，這個安裝軟體解除安裝非常危險，他會把整個 `/bin` 移除掉，請指定空的目錄給他安裝，否則就會像我一樣整台伺服器重灌。

## 設定 Xeon Phi 環境變數

假設我們安裝 Intel Parallel Studio XE 目錄為 `/tools/intel`，現在要將編譯器工具以及函數庫加到環境變數中，`find . -name "icc"` 和 `find . -name "*liboffload.so*"` 可以幫你找到相對應的路徑。

```
sudo vim /etc/bash.bashrc
```

在 `bash.bashrc` 增加下列幾行，路徑可能會附帶一些版本號，請用上述指令確定位置正確。

```
export PATH="/tools/intel/bin:$PATH"
export LD_LIBRARY_PATH="/tools/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/compiler/lib/intel64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/tools/intel//srallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/mkl/lib/intel64:$LD_LIBRARY_PATH"
export SINK_LD_LIBRARY_PATH="/tools/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/compiler/lib/mic"
```


## 設置存取權限

一開始我們安裝 Xeon Phi 後，只有 root 權限可以抓到 MIC 卡，可以下達 `micinfo` 看出來，其他帳號是沒辦法抓到 MIC 任何一項資訊，非得要執行 `sudo micinfo` 才看得到。為了解決這問題，我們先創立一個群名為 `research`，`groupadd research`、以及把使用者加入進去 `usermod -aG rearch morris1028`。接著，要去 Linux 下的 `/dev/mic` 將權限開放給群組 `research` 使用。

```
cd /dev && ls -la | grep -i mic
sudo chgrp -R research /dev/mic
sudo chmod 660 /dev/mic/*
sudo chgrp -R research /dev/mic0
# if you have more mic
# sudo chgrp -R research /dev/mic*
```

## MIC 執行 OpenMP ##

MIC 模組根據版本的不同，通常沒有附上 OpenMP 的 library，要從主機端將 `libiomp5.so` 複製一份到 MIC 端。

```
sudo su
scp /tools/intel/parallel_studio_xe_2016/compilers_and_libraries_2016.3.210/linux/compiler/lib/intel64_lin_mic/libiomp5.so mic0:/lib64
```

## OpenCL ##

參考 [Getting Started with the Intel Xeon Phi on Ubuntu 14.04/Linux Kernel 3.13.0](https://arrayfire.com/getting-started-with-the-intel-xeon-phi-on-ubuntu-14-04linux-kernel-3-13-0/)

到 Intel [OpenCL™ Drivers and Runtimes for Intel® Architecture](https://software.intel.com/en-us/articles/opencl-drivers) 下載 OpenCL™ Runtime 14.2 for Intel® CPU and Intel® Xeon Phi™ Coprocessors 之類的驅動程式。並且新增檔案 `/etc/OpenCL/vendors/intel64.icd`，裡面包含一行 `/opt/intel/opencl-1.2-4.5.0.8/lib64/libintelocl.so`，必要時請更改路徑。


接著，你可以到 [Monte Carlo Method for Stock Options Pricing Sample](https://software.intel.com/en-us/articles/monte-carlo) 下載 Intel 提供的蒙地卡羅的應用程式，並且設定相關的平台。

```
./montecarlo --device 1 --platform 0
```

大部分的情況，應該會看到

```
root@Mermaid /h/m/I/MonteCarlo# ./montecarlo --device 0 --platform 0
Platforms (2):
    [0] Intel(R) OpenCL [Selected]
    [1] NVIDIA CUDA
Devices (3):
    [0] Intel(R) Many Integrated Core Acceleration Card [Selected]
    [1] Intel(R) Many Integrated Core Acceleration Card
    [2]       Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
Build program options: "-D__DO_FLOAT__ -cl-denorms-are-zero -cl-fast-relaxed-math -cl-single-precision-constant -DNSAMP=262144"
...
```

> 特別注意使用者，一般使用者可能抓不到 Xeon Phi 裝置，請切換到 root 嘗試。

在 Ubuntu 14.04 使用 `$ clinfo` 發生錯誤，但是從蒙地卡羅的程式中卻抓得到，應該是官方預設的 `clinfo` 中的 Bug。