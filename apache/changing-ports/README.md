# Change httpd port

```
Listen 8081
```

```
<VirtualHost *:8081>
```

```
# yum install policycoreutils
# semanage port -l | grep http

```

```
# semanage port -a -t http_port_t -p tcp 8081
# semanage port -m -t http_port_t -p tcp 8081
# systemctl restart httpd
```



