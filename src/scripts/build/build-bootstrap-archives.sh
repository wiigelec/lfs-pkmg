#!/bin/bash
####################################################################
# 
# build-bootstrap-archives.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# BUILD PKGLOGS
#------------------------------------------------------------------#

echo
echo "Creating pkglogs..."
echo
sudo chroot $INSTALLROOT bash -e -c "LPM_DIFFLOG=$LPM_DIFFLOG \
	LPM_PKGLOG=$LPM_PKGLOG \
	/sources/work/scripts/build-pkglogs.sh"


#------------------------------------------------------------------#
# BUILD ARCHIVES
#------------------------------------------------------------------#

echo
echo "Creating archives..."
echo
sudo chroot $INSTALLROOT bash -e -c "LPM_PKGLOG=$LPM_PKGLOG \
	LPM_ARCHIVE=$LPM_ARCHIVE \
	BOOK_VERS=$BOOK_VERS \
	/sources/work/scripts/build-archives.sh"
