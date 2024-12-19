#!/bin/bash
####################################################################
# 
# util-umount-kernfs.sh
#
####################################################################


mountpoint -q $INSTALLROOT/dev/shm && umount $INSTALLROOT/dev/shm
umount $INSTALLROOT/dev/pts
umount $INSTALLROOT/{sys,proc,run,dev}
