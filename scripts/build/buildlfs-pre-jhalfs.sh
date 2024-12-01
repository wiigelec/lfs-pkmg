#!/bin/bash
####################################################################
# 
# buildlfs-pre-jhalfs.sh
#
####################################################################

### PACKAGE MANAGEMENT ###

echo "Installing package management files..."
$UTIL_BUILDLFS_PKGMGT_SH


### FIRST PASS FILE MOVE ###
[[ -f $JHALFS_CONFIGIN.org ]] && mv $JHALFS_CONFIGIN.org $JHALFS_CONFIGIN


### DOWNLOAD KERNEL CONFIG ###

echo
echo "Downloading kernel config..."
echo
pushd $BUILD_DIR
wget https://mirrors.slackware.com/slackware/slackware64-15.0/kernels/huge.s/config
mv config kernel-config
popd


### JHALFS CONFIG IN ###

echo "Generating jhalfs Config.in..."

echo "$($UTIL_BUILDLFS_JHALFS_CONFIGIN_SH)" > $JHALFS_CONFIGIN
