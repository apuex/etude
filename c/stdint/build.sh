#! /bin/bash

PRG_DIR=$(cd $(dirname "$0"); pwd)

cd ${PRG_DIR}
mkdir -p dist
cd dist
cmake \
  -DBoost_DIR=/usr/local/lib/cmake/Boost-1.75.0 \
  -DBoost_INCLUDE_DIR=/usr/local/include \
  -DBoost_LIBRARY_DIRS=/usr/local/lib \
  -Dnanodbc_DIR=/usr/local/lib/nanodbc \
  -DBoost_DEBUG=1 \
  ${PRG_DIR}


