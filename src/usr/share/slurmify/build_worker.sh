#!/bin/bash

node="$1"
hosts="$2"
mount_dir="$3"
env_script="$4"

#---UPDATE HOSTNAME--- 
sudo hostname $node  
sudo sed -i 2d /etc/hosts
sudo sed -i "2i $hosts" /etc/hosts 
sudo sed -i "s/.*/$node/" /etc/hostname
sudo sed -i 's/^preserve_hostname: false$/preserve_hostname: true/' /etc/cloud/cloud.cfg
#---------------------

#------NTPDATE--------
sudo NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install ntpdate -y
#---------------------

#-------SLURM---------
sudo NEEDRESTART_MODE=l apt-get -o DPkg::Lock::Timeout=60 install slurmd slurm-client -y
sudo cp $mount_dir/munge.key /etc/munge/munge.key
sudo cp -r $mount_dir/slurm/* /etc/slurm/
sudo systemctl enable munge
sudo systemctl start munge
sudo systemctl enable slurmd
sudo systemctl start slurmd
#---------------------

#--------ENV----------
source $env_script $mount_dir
#---------------------