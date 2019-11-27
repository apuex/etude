# Cross Compiling libwebsockets for mipsel linux

```
git clone https://libwebsockets.org/repo/libwebsockets && cd libwebsockets
```

add the following lines to CMakeLists.txt

```
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR mipsel)

set(CMAKE_SYSROOT /cross-compile/mipsel-rootfs)
set(CMAKE_STAGING_PREFIX /cross-compile/mipsel/root-fs/usr/local)

set(tools /usr/mipsel-linux-gnu/bin)
set(CMAKE_C_COMPILER mipsel-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER mipsel-linux-gnu-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

```


```


mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/cross-compile/mipsel/root-fs/usr/local \
      -DLWS_OPENSSL_INCLUDE_DIRS=/cross-compile/mipsel/root-fs/usr/local/include \
      -DLWS_OPENSSL_LIBRARIES=/cross-compile/mipsel/root-fs/usr/local/lib \
      -DLWS_ZLIB_INCLUDE_DIRS=/cross-compile/mipsel/root-fs/usr/local/include \
      -DLWS_ZLIB_LIBRARIES=/cross-compile/mipsel/root-fs/usr/local/lib \
      -DLWS_LIBUV_INCLUDE_DIRS=/cross-compile/mipsel/root-fs/usr/local/include \
      -DLWS_LIBUV_LIBRARIES=/cross-compile/mipsel/root-fs/usr/local/lib \
      ..
make -j8 && make install
```


