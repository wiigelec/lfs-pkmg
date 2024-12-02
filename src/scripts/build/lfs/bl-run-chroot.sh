#!/bin/bash
####################################################################
# 
# bl-run-chroot.sh
#
####################################################################o

### PKGLOG ###
echo
echo "Creating pkglogs..."
echo
sudo chroot $LFS bash -c "DIFFLOG_DIR=$DIFFLOG_DIR PKGLOG_DIR=$PKGLOG_DIR /jhalfs/lfspkmg-scripts/util-create-pkglog.sh"

### ARCHIVE ###
echo
echo "Creating archives..."
echo
sudo chroot $LFS bash -c "PKGLOG_DIR=$PKGLOG_DIR ARCHIVE_DIR=$ARCHIVE_DIR /jhalfs/lfspkmg-scripts/util-create-archive.sh"

### CUSTOM ###
echo
echo "Running custom scripts..."
echo
# kernel config
cp $MISC_DIR/kernel-config $LFS/sources
sudo chroot $LFS bash -c "for f in /jhalfs/lfspkmg-scripts/custom/*; do ARCHIVE_DIR=$ARCHIVE_DIR ./\$f; done"
