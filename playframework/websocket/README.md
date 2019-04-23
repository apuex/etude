# websocket test


## list open files

```
wangxy@concerto:~# ps -ef | grep java | grep websocket | awk '{print $2}' | xargs -I {} lsof -p {} | grep \.jar$
```

