# version

## Cross compiling with mingw

### Fedora

```
mkdir -p build && cd build
mingw64-configure ..
make
```

### Ubuntu

```
mkdir -p build && cd build
../configure --host=x86_64-w64-mingw32
make
```

