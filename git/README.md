# Git

- How to re-attach to head of the master branch after detached from head?


```
$ git checkout -b origin/master
$ git branch --set-upstream-to=origin/master
```

then test if it is re-attached:

```
$ git pull
```

