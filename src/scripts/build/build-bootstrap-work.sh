#!/bin/bash
####################################################################
# 
# build-bootstrap-work.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# RUN CHROOT MAKE
#------------------------------------------------------------------#

### MOUNT KERNFS ###

sudo UTIL_UMOUNT_KERNFS_SH=$UTIL_UMOUNT_KERNFS_SH LFS=$INSTALLROOT $UTIL_MOUNT_KERNFS_SH

### RESOLV.CONF ###

resolvconf=$INSTALLROOT/etc/resolv.conf
[[ -f $resolvconf ]] && sudo rm $resolvconf
echo "nameserver 8.8.8.8" | sudo tee -a $resolvconf > /dev/null

sudo chroot $INSTALLROOT make -C /sources/work

sudo LFS=$INSTALLROOT $UTIL_UMOUNT_KERNFS_SH
