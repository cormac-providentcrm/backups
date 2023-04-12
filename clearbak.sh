#!/bin/bash
#Cormac O'Riordan
#Clear backups after 3 days
files="$(find /mnt/share/backup -type f -name '*.gz' -mtime +4)"
ldat="$(date +"%H:%M:%S %d-%m-%y")"
echo "Found the following files for deletion:\n" $files >> /logging/backup.log
find /mnt/share/backup -mtime +4 -type f -name '*.gz' -execdir rm -- '{}' \;

if [ "$?" -eq 0 ]
then
    echo "Deletion successful "$ldat >> /logging/backup.log
else
    echo "Issue encountered when deleting files, share may be inaccessible "$ldat >> /logging/backup.log
fi
