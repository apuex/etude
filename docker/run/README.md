# Run

## Start docker:

```
$ docker volume create log
$ docker run -d -v log:/log --restart=always -p 8001:8000 -it apuex/snap-myproject:0.1.0.0
```

## Start & mount custom directory

to mount `log` directory to `$(pwd)/log`,
```
$ docker run -d -v $(pwd)/log:/log --restart=always -p 8001:8000 -it apuex/snap-myproject:0.1.0.0
```
Permission denied to access `$(pwd)/log` if SELinux enabled. 
fixed with
```
# chcon -Rt svirt_sandbox_file_t $(pwd)/log
```

## Inspect container

```
$ docker ps -a
CONTAINER ID        IMAGE                          COMMAND             CREATED              STATUS              PORTS                    NAMES
abe68fab3d58        apuex/snap-myproject:0.1.0.0   "/app/myproject"    About a minute ago   Up About a minute   0.0.0.0:8001->8000/tcp   frosty_ride
$ docker exec -i -t frosty_ride /bin/bash
root@abe68fab3d58:/# ls  
app  bin  boot  dev  etc  home  lib  lib64  log  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@abe68fab3d58:/# ls app
myproject  myproject-tmp
root@abe68fab3d58:/# ls log
access.log  error.log
root@abe68fab3d58:/# 
```

## Inspect volume:

```
$ docker volume inspect log
[
    {
        "CreatedAt": "2019-02-21T11:47:01+08:00",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/log/_data",
        "Name": "log",
        "Options": {},
        "Scope": "local"
    }
]
```

## Docker info
```
$ docker info
Containers: 1
 Running: 1
 Paused: 0
 Stopped: 0
Images: 12
Server Version: 18.06.1-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version:  (expected: 468a545b9edcd5932818eb9de8e72413e616e86e)
runc version: N/A (expected: 69663f0bd4b60df09991c08812a60108003fa340)
init version: v0.18.0 (expected: fec3683b971d9c3ef73f284f176672c44b448662)
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.4.0-142-generic
Operating System: Ubuntu 16.04.5 LTS
OSType: linux
Architecture: x86_64
CPUs: 8
Total Memory: 15.56GiB
Name: concerto
ID: 476W:SITB:LAGL:F52O:BLAN:CENX:RUFL:KHEA:YVYM:Z3JE:4UDE:TUIV
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Username: apuex
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false

WARNING: No swap limit support
```

