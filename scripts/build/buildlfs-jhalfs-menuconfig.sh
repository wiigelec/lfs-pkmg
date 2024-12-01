#!/bin/bash
####################################################################
# 
# buildlfs-jhalfs-menuconfig.sh
#
####################################################################

### RUN JHALFS MENUCONFIG ###

[[ -f $LFS_JHALFS_DIR/configuration ]] && rm $LFS_JHALFS_DIR/configuration

make -C $LFS_JHALFS_DIR


### FIX KERNEL BUILD ###

echo
echo "Fixing kernel build script..."
echo
kernel_script=$JHALFS_MNT/lfs-commands/chapter10/1002-kernel
sed -i 's/make oldconfig/make olddefconfig/' $kernel_script

