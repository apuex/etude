#!/bin/sh

PRG=$(readlink -f $0)
PRG_DIR=`dirname "$PRG"`


# backup folder

SVN_REPOS=/var/www/svn/Repositories

BACKUP_SVN=${PRG_DIR}
ARCHIVE_DIR=${BACKUP_SVN}/archive

mv ${BACKUP_SVN}/*.gz ${ARCHIVE_DIR}/

TIME_STAMP=`date "+%Y-%m-%d-%H%M"`

echo "starting "$0" on" `date`

for repos in m2m src wincom cplus docs power-report supervisionUnit tower-fsu  cmcc  dcim  energy  httpd-conf  mstar  

do

    DB_STAMP=${repos}_${TIME_STAMP}

    echo ${DB_STAMP}

    FILENAME=${BACKUP_SVN}/${DB_STAMP}.gz

    echo ${FILENAME}

    svnadmin dump ${SVN_REPOS}/${repos} | gzip > ${FILENAME}

done

