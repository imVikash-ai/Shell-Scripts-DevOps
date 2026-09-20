#!/bin/bash
<<info
This shell ecripts will take periodic bacups

eg.  ./backup.sh <source> <destination>
info

#src=/mnt/c/Programming/AWS_DEVOPS/Shell_Scripts_TWS/scripts
src=$1
dest=$2

# timestamp=$(date '+%Y-%m-%d')

# zip -r "$dest/backup-$timestamp.zip" $src > /dev/null

echo "Backup Done"
