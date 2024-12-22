#!/bin/bash
####################################################################
# 
# build-blfs-versiondir.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# VERSION BUILD DIR
#------------------------------------------------------------------#

#bookversion=$BOOK_VERSION
#versionbuilddir=$BUILD_DIR

### GET TRUNK BOOK VERSION ###
#if [[ $BOOK_VERS == "trunk" ]]; then
#bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML_NV | sed 's/Version //' | sed 's/-/\./')
#	versionbuilddir=$BLD_DIR/$bookversion-$REV
#fi

### CREATE BUILD DIR ###
if [[ ! -d $BUILD_DIR ]]; then

	mkdir -p $BUILD_DIR

	mv -v $BLD_XML $BUILD_DIR
fi

