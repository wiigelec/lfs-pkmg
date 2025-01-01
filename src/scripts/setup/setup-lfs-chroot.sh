#!/bin/bash
####################################################################
# 
# setup-lfs-chroot.sh
#
####################################################################

set -e


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


JHALFS_CHROOT_SCRIPTS=$INSTALLROOT/jhalfs/lpm-scripts


#------------------------------------------------------------------#
# COPY SCRIPTS
#------------------------------------------------------------------#

### CREATE DIR ###
mkdir -p $JHALFS_CHROOT_SCRIPTS/lfs

### PKGLOG ###
cp $BUILD_PKGLOGS_SH $JHALFS_CHROOT_SCRIPTS

### ARCHIVE ###
cp $BUILD_ARCHIVES_SH $JHALFS_CHROOT_SCRIPTS

### LFS CUSTOM ###
cp $LFS_BUILD/* $JHALFS_CHROOT_SCRIPTS/lfs


#------------------------------------------------------------------#
# INITIALIZE DIRS
#------------------------------------------------------------------#

as_root mkdir -p ${INSTALLROOT}$LPM_PKGLOG
as_root mkdir -p ${INSTALLROOT}$LPM_ARCHIVE
