#!/bin/bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")

cd ${PRG_DIR}

chcon -Rt svirt_sandbox_file_t /home/svn-store/repositories
chcon -Rt svirt_sandbox_file_t /home/master/public_html

docker run -d \
	--restart=always \
	--name svn-server \
	-v /home/svn-store/repositories:/var/www/svn \
	-v /home/master/public_html:/var/www/html \
	-p 9080:80 \
	svn-server:1.0.2

