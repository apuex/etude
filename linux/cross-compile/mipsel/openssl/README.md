# Cross Compiling OpenSSL for mipsel

```
git clone https://github.com/openssl/openssl && cd openssl
git checkout OpenSSL_1_0_2t
mkdir -p build && cd build
CC=mipsel-linux-gnu-gcc ../Configure linux-mips32 --prefix=/cross-compile/mipsel/root-fs/usr/local
make -j8
make install
```

