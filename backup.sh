#!/bin/bash

xtrabackup --backup \
           --databases=$DATABASES \
           --datadir=/root/data \
           --password=$PASSWORD \
           --target-dir=/root/backup \
           --host=$HOST \
           --user=$USER;

BACKUP="/tmp/backup-$(date +%Y-%m-%d)-${DATABASES// /_}.tar.gz";

tar -zcvf $BACKUP /root/backup;
rm -rf /root/backup/*;

# using `cp` + `rm` but not `mv` bacause of
# mv tries to preserve file's ownership which bangs with attached docker volumes for me
#
cp --no-preserve=mode,ownership $BACKUP /root/backups;
rm -f $BACKUP;
