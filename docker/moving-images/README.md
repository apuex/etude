# Moving docker images between hosts

```
$ docker save springio/gs-spring-boot-docker -o spring-boot.tar
$ scp spring-boot.tar master@192.168.0.161:spring-boot.tar
$ ssh master@192.168.0.161
docker load -i ~/spring-boot.tar
```

