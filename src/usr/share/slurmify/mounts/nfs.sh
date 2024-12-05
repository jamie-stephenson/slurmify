#!/bin/bash

fs="$1"

mount=${fs[mount]}
addr=${fs[addr]}

#-----MOUNT DRIVE-----
apt-get update
apt-get -o DPkg::Lock::Timeout=20 -y install nfs-common 
mkdir -p $mount
echo "$addr:/ $mount nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0" | tee -a /etc/fstab >/dev/null
mount $mount
#---------------------

# Verify the mount was successful
if mount | grep $mount > /dev/null; then
    echo "NFS successfully mounted to $mount"
else
    echo "Failed to mount NFS $addr"
    exit 1
fi


