#!/bin/bash
####################################################################
# 
# build-lfs-chroot.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# GET JHALFS BOOK VERSION
#------------------------------------------------------------------#

lfsver=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $JHALFS_DIR/prbook.xml | sed 's/.* \(.*\)-.*/\1/')


#------------------------------------------------------------------#
# BUILD PKGLOGS
#------------------------------------------------------------------#

echo
echo "Creating pkglogs..."
echo
sudo chroot $INSTALLROOT bash -e -c "DIFFLOG_DIR=$DIFFLOG_DIR \
	PKGLOG_DIR=$PKGLOG_DIR \
	/jhalfs/lpm-scripts/build-pkglogs.sh"


#------------------------------------------------------------------#
# BUILD ARCHIVES
#------------------------------------------------------------------#

echo
echo "Creating archives..."
echo
sudo chroot $INSTALLROOT bash -e -c "PKGLOG_DIR=$PKGLOG_DIR \
	ARCHIVE_DIR=$ARCHIVE_DIR \
	BOOK_VERS=$lfsver \
	LFS_BLD=lfs \
	/jhalfs/lpm-scripts/build-archives.sh"


#------------------------------------------------------------------#
# CUSTOM SCRIPTS
#------------------------------------------------------------------#

echo
echo "Running custom scripts..."
echo

# kernel config
tmpdir=/tmp/lfspkmg$RANDOM
mkdir $tmpdir
pushd $tmpdir > /dev/null
wget https://mirrors.slackware.com/slackware/slackware64-15.0/kernels/huge.s/config
mv -v config $INSTALLROOT/sources/kernel-config
popd > /dev/null
rm -rf $tmpdir

sudo chroot $INSTALLROOT bash -e -c "for f in /jhalfs/lpm-scripts/lfs/*; do ARCHIVE_DIR=$ARCHIVE_DIR LFS_VER=$lfsver \$f; done"

