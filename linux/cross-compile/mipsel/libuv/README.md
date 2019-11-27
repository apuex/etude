# Cross Compiling libuv for mipsel linux

```
git clone https://github.com/libuv/libuv && cd libuv
mkdir -p build && cd build
CC=mipsel-linux-gnu-gcc ../configure --prefix=/cross-compile/mipsel/root-fs/usr/local --host=mipsel-linux-gnu
make -j8 && make install
```
