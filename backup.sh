#!/bin/bash
mkdir /root/backups/tmp
mkdir /root/backups/backup

xtrabackup --backup \
           --databases=$DATABASES \
           --datadir=/root/data \
           --password=$PASSWORD \
           --target-dir=/root/backups/backup \
           --host=$HOST \
           --user=$USER;

BACKUP="/root/backups/tmp/backup-$(date +%Y-%m-%d-%H-%M)-${DATABASES// /_}.tar.gz";

tar -zcvf $BACKUP /root/backups/backup;
rm -rf /root/backups/backup/*;

# using `cp` + `rm` but not `mv` bacause of
# mv tries to preserve file's ownership which bangs with attached docker volumes for me
#
cp --no-preserve=mode,ownership $BACKUP /root/backups;
rm -f $BACKUP;
