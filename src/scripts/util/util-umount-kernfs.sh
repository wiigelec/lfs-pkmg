#!/bin/bash
####################################################################
# 
# util-umount-kernfs.sh
#
####################################################################

LFS=${LFS:-/mnt/lfs}

echo "Unmounting virtual kernelfs..."

mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}
