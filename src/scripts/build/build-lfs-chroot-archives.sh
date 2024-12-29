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
sudo chroot $INSTALLROOT bash -e -c "LPM_DIFFLOG=$LPM_DIFFLOG \
	LPM_PKGLOG=$LPM_PKGLOG \
	/jhalfs/lpm-scripts/build-pkglogs.sh"


#------------------------------------------------------------------#
# BUILD ARCHIVES
#------------------------------------------------------------------#

echo
echo "Creating archives..."
echo
sudo chroot $INSTALLROOT bash -e -c "LPM_PKGLOG=$LPM_PKGLOG \
	LPM_ARCHIVE=$LPM_ARCHIVE \
	BOOK_VERS=$lfsver \
	LFS_BLD=lfs \
	/jhalfs/lpm-scripts/build-archives.sh"


