#!/bin/bash
####################################################################
# 
# util-mount-kernfs.sh
#
####################################################################

# unmount first
$UTIL_UMOUNT_KERNFS_SH

mount -v --bind /dev $INSTALLROOT/dev
mount -vt devpts devpts -o gid=5,mode=0620 $INSTALLROOT/dev/pts
mount -vt proc proc $INSTALLROOT/proc
mount -vt sysfs sysfs $INSTALLROOT/sys
mount -vt tmpfs tmpfs $INSTALLROOT/run
if [ -h $INSTALLROOT/dev/shm ]; then
	install -v -d -m 1777 $INSTALLROOT$(realpath /dev/shm)
else
	mount -vt tmpfs -o nosuid,nodev tmpfs $INSTALLROOT/dev/shm
fi
