#!/bin/bash
####################################################################
# 
# build-lfs-chroot.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# GET JHALFS BOOK VERSION
#------------------------------------------------------------------#

lfsvers=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $JHALFS_DIR/prbook.xml)
lfsvers=${lfsvers##* }
lfsvers=${lfsvers%-*}


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
	BOOK_VERS=$lfsvers \
	LFS_BLD=lfs REV=$REV \
	/jhalfs/lpm-scripts/build-archives.sh"


