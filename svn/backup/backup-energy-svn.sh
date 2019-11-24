#!/bin/sh



# backup folder

BACKUP_DIR=~/backups

SVN_REPOS=/var/www/svn/Repositories/energy

BACKUP_SVN=${BACKUP_DIR}/svn/energy-



TIME_STAMP=`date "+%Y-%m-%d-%H%M"`

echo "starting "$0" on" `date`

for repos in docs src

do

    DB_STAMP=${repos}_${TIME_STAMP}

    echo ${DB_STAMP}

    FILENAME=${BACKUP_SVN}${DB_STAMP}.gz

    echo ${FILENAME}

    svnadmin dump ${SVN_REPOS}/${repos} | gzip > ${FILENAME}

done

