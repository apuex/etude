#!/bin/bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")

cd ${PRG_DIR}
docker run --restart=always --name svn -d -v /home/wangxy/svn-backups/svn:/var/www/svn -p 9080:80 svn-server:1.0.0

