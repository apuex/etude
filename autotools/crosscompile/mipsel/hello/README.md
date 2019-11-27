# Cross Compiling GNU hello for mipsel-linux-gnu on x86\_64-linux-gnu

## install gnu autotools

## install mipsel-linux-gnu toolchain

```
sudo apt-get install --install-recommends gcc-mipsel-linux-gnu cpp-mipsel-linux-gnu
```

## cross compile hello

```
tar xf hello-2.10.tar.gz
cd hello-2.10
mkdir -p build/mipsel
cd build/mipsel
../../configure --build=x86_64-linux-gnu --host=mipsel-linux-gnu --target=mipsel-linux-gnu
make -j8
```

