#!/bin/bash

# Restores the backup
#
# BACKUP_DIR is a path to a dir with uncompressed backup

# tar xvf backup-2017-07-31-fisikal_staging.tar.gz

xtrabackup --prepare \
           --target-dir=$BACKUP_DIR;

mkdir /root/data.copy
mv /root/data/* /root/data.copy

xtrabackup --move-back \
           --target-dir=$BACKUP_DIR
           --datadir=/root/data
           --password=$PASSWORD \
           --host=$HOST \
           --user=$USER;

# mysql_upgrade -u root -p --force
