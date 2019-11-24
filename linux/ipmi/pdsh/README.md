# How to read IPMI with pdsh

## pdsh

```
$ ssh-keygen
$ ssh-copy-id master@server1
$ export PDSH_RCMD_TYPE=ssh
$ export export SSH_AUTH_SOCK=0
$ export WCOLL=~/PDSH/hosts
```

read cpu info of remote host:

```
$ pdsh -w master@113.108.158.19 'cat /proc/cpuinfo' | egrep 'bogomips|model|cpu'
113.108.158.19: cpu family  : 6
113.108.158.19: model       : 37
113.108.158.19: model name  : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
113.108.158.19: cpu MHz     : 1463.000
113.108.158.19: cpu cores   : 2
113.108.158.19: cpuid level : 11
113.108.158.19: bogomips    : 6384.00
113.108.158.19: cpu family  : 6
113.108.158.19: model       : 37
113.108.158.19: model name  : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
113.108.158.19: cpu MHz     : 1729.000
113.108.158.19: cpu cores   : 2
113.108.158.19: cpuid level : 11
113.108.158.19: bogomips    : 6383.62
113.108.158.19: cpu family  : 6
113.108.158.19: model       : 37
113.108.158.19: model name  : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
113.108.158.19: cpu MHz     : 2926.000
113.108.158.19: cpu cores   : 2
113.108.158.19: cpuid level : 11
113.108.158.19: bogomips    : 6383.66
113.108.158.19: cpu family  : 6
113.108.158.19: model       : 37
113.108.158.19: model name  : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
113.108.158.19: cpu MHz     : 2261.000
113.108.158.19: cpu cores   : 2
113.108.158.19: cpuid level : 11
113.108.158.19: bogomips    : 6383.64
```

read date of remote host:

```
$ pdsh -w master@113.108.158.19 date
```
or, ^_^
```
$ pdsh -w master@113.108.158.19 "date;sleep 5;date"
```

# References

- [http://www.gnu.org/software/freeipmi/freeipmi-hostrange.txt](http://www.gnu.org/software/freeipmi/freeipmi-hostrange.txt)
