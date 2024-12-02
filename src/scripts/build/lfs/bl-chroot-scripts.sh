#!/bin/bash
####################################################################
# 
# bl-chroot-scripts.sh
#
####################################################################

#------------------------------------------------------------------#
# COPY SCRIPTS

### CREATE DIR ###
mkdir -p $CHROOT_SCRIPTS_DIR/custom

### PKGLOG ###
cp $UTIL_CREATE_PKGLOG_SH $CHROOT_SCRIPTS_DIR

### ARCHIVE ###
cp $UTIL_CREATE_ARCHIVE_SH $CHROOT_SCRIPTS_DIR

### LFS CUSTOM ###
cp $LFS_CUSTOM_DIR/* $CHROOT_SCRIPTS_DIR/custom/


touch $CHROOT_SCRIPTS

