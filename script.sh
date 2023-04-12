#!/bin/bash
#Cormac O'Riordan 12/04/2023
#Backup script to be run nightly, logs successes/failures

dat="$(date +"%d-%m-%y")"
ldat="$(date +"%H:%M:%S %d-%m-%y")"
name="$(eval 'echo backup.$dat.sql.gz')"
dest="/mnt/share/backup"
file=${dest}/${name}

mysqldump --set-gtid-purged=OFF --routines --triggers SugarCRM | gzip  > $file

if [ "$?" -eq 0 ]
then
    echo "Dump successful "$ldat >> /logging/backup.log
else
    echo "Dump failed, check mysql logs "$ldat >> /logging/backup.log
fi

if [ -f "$name" ]
then
    echo "Dump looks OK "$ldat >> /logging/backup.log
else
    echo "Dump not found, check mysql logs "$ldat >> /logging/backup.log
fi
