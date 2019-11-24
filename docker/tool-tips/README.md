# TOOL TIPS

# list all container names

```
$ docker ps -a | sed -r 's/^.{150}//g' | awk '{print $1}'
```
to skip column header,
```
$ docker ps -a | sed -r 's/^.{150}//g' | awk '{print $1}' | tail -n +2
```
