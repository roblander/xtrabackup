#!/bin/bash

xtrabackup --backup \
           --databases=$DATABASES \
           --datadir=/root/data \
           --password=$PASSWORD \
           --target-dir=/root/backup \
           --host=$HOST \
           --user=$USER;

BACKUP="backup-$(date +%Y-%m-%d)-${DATABASES// /_}.tar.gz";
tar -zcvf $BACKUP /root/backup;
rm -rf /root/backup/*;
mv $BACKUP /root/backups;
