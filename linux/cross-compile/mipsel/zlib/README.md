# Cross Compiling zlib for mipsel linux


```
git clone https://github.com/madler/zlib && cd zlib
mkdir -p build && cd build
CC=mipsel-linux-gnu-gcc ../configure --prefix=/home/wangxy/cross-compile/mipsel/root-fs/usr/local
make -j8
make install
```

