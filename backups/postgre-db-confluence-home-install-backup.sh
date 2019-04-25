#!/bin/bash
D=`date +%Y-%m-%d_%H-%M-%S`
########
BACK_DIR_C="/s3/confluence"
DIR_C="/opt/atlassian/confluence"
DIR_C_HOME="/var/atlassian/application-data/confluence"
########
mkdir $BACK_DIR_C/db
pg_dump --host 127.0.0.1 --port 5432 --username postgres --blobs --quote-all-identifiers --verbose --file /$BACK_DIR_C/db/$D-confluence.psql confluence
tar -czvf $BACK_DIR_C/$D-confluence.psql.tar.gz $BACK_DIR_C/db/$D-confluence.psql
tar -czvf $BACK_DIR_C/$D-confluence-home.tar.gz $DIR_C_HOME \
--exclude=/var/atlassian/application-data/confluence/backups \
--exclude=/var/atlassian/application-data/confluence/restore \
--exclude=/var/atlassian/application-data/confluence/*plugins* \
--exclude=/var/atlassian/application-data/confluence/*logs \
--exclude=/var/atlassian/application-data/confluence/recovery \
--exclude=/var/atlassian/application-data/confluence/temp
tar -czvf $BACK_DIR_C/$D-confluence-opt.tar.gz $DIR_C \
--exclude=/opt/atlassian/confluence/logs \
--exclude=/opt/atlassian/confluence/temp \
--exclude=/opt/atlassian/confluence/work
rm -rf $BACK_DIR_C/db
