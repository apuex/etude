# libmatheval

## install from source

### fedora

1. install dependencies

```
dnf -y install guile guile-devel gnutls-guile guile-lib
dnf -y install compat-guile18-devel compat-guile18 guile22 guile22-devel
dnf -y install bison-devel bison  byacc
dnf -y install flex flex-devel
```

2. compile & install

```
wget -c http://ftp.gnu.org/gnu/libmatheval/libmatheval-1.1.11.tar.gz
tar xf libmatheval-1.1.11.tar.gz
cd libmatheval-1.1.11
./configure
make
make install

```
