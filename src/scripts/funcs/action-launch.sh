#!/bin/bash
####################################################################
# 
# action-launch.sh
#
####################################################################


#------------------------------------------------------------------#
# MAKE ACTION
#------------------------------------------------------------------#

source $CURRENT_CONFIG

export BUILD_DIR="$BUILD_DIR"
export INSTALLROOT="$INSTALLROOT"
export JHALFS_DIR="$INSTALLROOT}/jhalfs"
export BLFS_FULL_XML="${BUILD_DIR}$BLFS_FULL_XML"
export BLFS_PKGLIST_XML="${BUILD_DIR}$BLFS_PKGLIST_XML"
export BOOK_BLFS_DEPS="${BUILD_DIR}$BOOK_BLFS_DEPS"
export BOOK_BLFS_SCRIPTS="${BUILD_DIR}$BOOK_BLFS_SCRIPTS"
export SETUP_LFS_JHALFS="${INSTALLROOT}$SETUP_LFS_JHALFS"
export SETUP_LFS_DIFFLOG="${INSTALLROOT}$SETUP_LFS_DIFFLOG"
export SETUP_LFS_CHROOT="${INSTALLROOT}$SETUP_LFS_CHROOT"

echo
echo "Launching $ACTION"
echo

make $ACTION
