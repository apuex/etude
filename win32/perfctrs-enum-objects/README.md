# version

## Cross compiling with mingw

```
mkdir -p build && cd build
```
copy `C:\Windows\System32\pdh.dll` from Windows Box to `build` directory.

### Fedora

```
mingw32-configure ..
make
```

### Ubuntu

```
../configure --host=i686-w64-mingw32
make
```

