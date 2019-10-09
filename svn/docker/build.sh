#!/bin/bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")

cd ${PRG_DIR}
docker build -t svn-server:1.0.0 .

