# hello-service

Win32 Service Sample.

## compile & install

```
cabal install --only-dependencies
cabal install
```

## install as service

```
sc create hello binPath="%APPDATA%\cabal\bin\hello-service.exe -n 9"
```

## config service to be started automatically

```
sc config hello start= auto
```

## start service

```
sc start hello
```

## stop service

```
sc stop hello
```
