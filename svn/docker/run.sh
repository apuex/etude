#!/bin/bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")

REPO_DIR=/home/svn-store/repositories

mkdir -p ${REPO_DIR}
chcon -Rt svirt_sandbox_file_t ${REPO_DIR}
chown -R systemd-timesync:master ${REPO_DIR}

cd ${PRG_DIR}
docker run --restart=always --name svn-server -d -v ${REPO_DIR}:/var/www/svn -p 9080:80 svn-server:1.0.0

