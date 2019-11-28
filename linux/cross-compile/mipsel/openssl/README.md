# Cross Compiling OpenSSL for mipsel

openssl 1.1.x or newer is not supported by libwebsockets, the latest supported version is 1.0.2t.

to compile to STATIC libraries,

```
git clone https://github.com/openssl/openssl && cd openssl
git checkout OpenSSL_1_0_2t
CC=mipsel-linux-gnu-gcc ../Configure linux-mips32 --prefix=/cross-compile/mipsel/root-fs/usr/local
make -j8
make install
```

`mkdir -p build && cd build` and then configure is just not supported for openssl 1.0.x.

adding `shared` to compiling shared libraries is not possible by

```
CC=mipsel-linux-gnu-gcc ../Configure linux-mips32 shared --prefix=/cross-compile/mipsel/root-fs/usr/local --openssldir=.
```

to compile to SHARED libraries, configure with
```
CC=mipsel-linux-gnu-gcc CFLAGS=-fPIC ./Configure linux-mips32 --prefix=/home/wangxy/cross-compile/mipsel/root-fs/usr/local --openssldir=.
```

