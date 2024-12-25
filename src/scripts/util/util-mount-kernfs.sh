#!/bin/bash
####################################################################
# 
# util-mount-kernfs.sh
#
####################################################################

LFS=${LFS:-/mnt/lfs}

# unmount first
$UTIL_UMOUNT_KERNFS_SH

echo "Mounting virtual kernfs..."

mount -v --bind /dev $LFS/dev
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
	install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
	mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi