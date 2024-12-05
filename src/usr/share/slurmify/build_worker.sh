#!/bin/bash

node="$1"
hosts="$2"
mount_dir="$3"
env_script="$4"

#---UPDATE HOSTNAME--- 
hostname $node  
sed -i 2d /etc/hosts
sed -i "2i $hosts" /etc/hosts 
sed -i "s/.*/$node/" /etc/hostname
sed -i 's/^preserve_hostname: false$/preserve_hostname: true/' /etc/cloud/cloud.cfg
#---------------------

#------NTPDATE--------
NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install ntpdate -y
#---------------------

#-------SLURM---------
NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install slurmd slurm-client -y
cp $mount_dir/munge.key /etc/munge/munge.key
cp -r $mount_dir/slurm/* /etc/slurm/
systemctl enable munge
systemctl start munge
systemctl enable slurmd
systemctl start slurmd
#---------------------

#--------ENV----------
source $env_script $mount_dir
#---------------------