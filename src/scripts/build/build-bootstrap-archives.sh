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
sudo chroot $INSTALLROOT bash -e -c "DIFFLOG_DIR=$DIFFLOG_DIR \
	PKGLOG_DIR=$PKGLOG_DIR \
	/sources/work/build-pkglogs.sh"


#------------------------------------------------------------------#
# BUILD ARCHIVES
#------------------------------------------------------------------#

echo
echo "Creating archives..."
echo
sudo chroot $INSTALLROOT bash -e -c "PKGLOG_DIR=$PKGLOG_DIR \
	ARCHIVE_DIR=$ARCHIVE_DIR \
	BOOK_VERS=$BOOK_VERS \
	/sources/work/build-archives.sh"
