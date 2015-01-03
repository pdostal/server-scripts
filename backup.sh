#!/bin/sh
. ~/.secrets
DATE=`date +%Y-%m-%d`

test -d /wedos_disk || mkdir /wedos_disk
if ! mountpoint -q /wedos_disk; then mount -t cifs -o username=$WEDOS_USER,password=$WEDOS_PASS //7136.s36.wedos.net/s7136  /wedos_disk; fi

#duplicity --no-encryption /home file:///wedos_disk/home 1> /dev/null
#duplicity remove-older-than 3D file:///wedos_disk/home 1> /dev/null

duplicity --no-encryption /etc file:///wedos_disk/etc 1> /dev/null
duplicity remove-older-than 3D file:///wedos_disk/etc 1> /dev/null

duplicity --no-encryption /root/bin file:///wedos_disk/root_bin 1> /dev/null
duplicity remove-older-than 3D file:///wedos_disk/root_bin 1> /dev/null

mysqldump -u $MYSQL_USER -p$MYSQL_PASS -A --events --ignore-table=mysql.event | gzip -9 > /wedos_disk/mysql/$DATE.sql.gz
find /wedos_disk/mysql/ -mtime +3 -exec rm {} \;

if mountpoint -q /wedos_disk; then umount /wedos_disk; fi
if ! mountpoint -q /wedos_disk; then rmdir /wedos_disk; fi
