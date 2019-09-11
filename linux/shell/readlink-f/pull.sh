#! /bin/bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")

cd ${PRG_DIR}
REPOS=$(ls -d */ | cut -f1 -d'/')

for r in ${REPOS[*]}
do
    echo ${PRG_DIR}/${r}
    cd ${PRG_DIR}/${r}
    git pull
done

