#!/bin/bash

mount=$1
addr=$2
usr=$3
pwd=$4

#-----MOUNT DRIVE-----
apt-get update
apt-get -o DPkg::Lock::Timeout=20 -y install cifs-utils
mkdir $mount
echo "$addr $mount cifs user=$usr,password=$pwd,rw,uid=1000,gid=1000,users 0 0" | tee -a /etc/fstab >/dev/null
mount $mount
#---------------------