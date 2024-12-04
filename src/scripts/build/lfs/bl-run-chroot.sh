#!/bin/bash
####################################################################
# 
# bl-run-chroot.sh
#
####################################################################

set -e

# lfs book version
lfsver=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $JHALFS_MNT/prbook.xml | sed 's/.* \(.*\)-.*/\1/')

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
sudo chroot $LFS bash -e -c "PKGLOG_DIR=$PKGLOG_DIR ARCHIVE_DIR=$ARCHIVE_DIR LFS_VER=$lfsver /jhalfs/lfspkmg-scripts/util-create-archive.sh"

#------------------------------------------------------------------#
### CUSTOM ###
echo
echo "Running custom scripts..."
echo

# kernel config
tmpdir=/tmp/lfspkmg$RANDOM
mkdir $tmpdir
pushd $tmpdir > /dev/null
wget https://mirrors.slackware.com/slackware/slackware64-15.0/kernels/huge.s/config
mv config $LFS/sources/kernel-config
popd
rm -rf $tmpdir

sudo chroot $LFS bash -e -c "for f in /jhalfs/lfspkmg-scripts/custom/*; do ARCHIVE_DIR=$ARCHIVE_DIR LFS_VER=$lfsver ./\$f; done"
