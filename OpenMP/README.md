## Intel Profiler ##

Search "intel parallel tool student"

[free software website](https://software.intel.com/en-us/qualify-for-free-software/student)

### Support for Linux ###

WARNING: Chanage process trace setting

```
$ echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
```

### Use ###

Open Vtune Amplifier XE on Windows OS, or

```
$ cd ~/intel/vtune_amplifier_xe
$ ./amplex-gui // for GUI
$ ./amplex-cl // for Command Line
```

