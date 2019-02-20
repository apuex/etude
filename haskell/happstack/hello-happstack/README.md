# hello-happstack


## iptables issue in docker

```
$ vim /etc/sysconfig/docker
```

```
# add '--iptables=false' to 'OPTIONS' 
# Modify these options if you want to change the way the docker daemon runs
OPTIONS='--selinux-enabled --log-driver=journald --iptables=false'
DOCKER_CERT_PATH=/etc/docker
```

