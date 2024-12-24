#!/bin/bash

node="$1"
hosts="$2"
mount_dir="$3"

#---UPDATE HOSTNAME--- 
hostname $node  
mkdir /tmp/slurmify
temp_hosts=$(mktemp /tmp/slurmify/hosts.new.XXXXXX)
temp_hostname=$(mktemp /tmp/slurmify/hostname.new.XXXXXX)

cp /etc/hosts $temp_hosts
sed -i 2d $temp_hosts
sed -i "2i $hosts" $temp_hosts
cp -f $temp_hosts /etc/hosts

cp /etc/hostname $temp_hostname
sed -i 's/.*/node00/' $temp_hostname
cp -f $temp_hostname /etc/hostname

sed -i 's/^preserve_hostname: false$/preserve_hostname: true/' /etc/cloud/cloud.cfg
#---------------------

#------NTPDATE--------
NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install ntpdate -y
#---------------------

#-------SLURM---------
NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install slurmd slurm-client -y
cp $mount_dir/munge.key /etc/munge/munge.key
cp -r $mount_dir/slurm/* /etc/slurm/
service munge start
service slurmd start
#---------------------