#!/bin/bash
####################################################################
# 
# bl-run-chroot.sh
#
####################################################################

set -e

### PKGLOG ###
echo
echo "Creating pkglogs..."
echo
# cleanup not used
cleanup=$LFS/$DIFFLOG_DIR/cleanup-*
stripping=$LFS/$DIFFLOG_DIR/stripping-*
[[ -f $LFS/$DIFFLOG_DIR/cleanup-.difflog1 ]] && sudo rm $cleanup
[[ -f $LFS/$DIFFLOG_DIR/stripping-.difflog1 ]] && sudo rm $stripping
sudo chroot $LFS bash -e -c "DIFFLOG_DIR=$DIFFLOG_DIR PKGLOG_DIR=$PKGLOG_DIR /jhalfs/lfspkmg-scripts/util-create-pkglog.sh"

### ARCHIVE ###
echo
echo "Creating archives..."
echo
sudo chroot $LFS bash -e -c "PKGLOG_DIR=$PKGLOG_DIR ARCHIVE_DIR=$ARCHIVE_DIR /jhalfs/lfspkmg-scripts/util-create-archive.sh"

### CUSTOM ###
echo
echo "Running custom scripts..."
echo
# kernel config
cp $MISC_DIR/kernel-config $LFS/sources
sudo chroot $LFS bash -e -c "for f in /jhalfs/lfspkmg-scripts/custom/*; do ARCHIVE_DIR=$ARCHIVE_DIR ./\$f; done"
