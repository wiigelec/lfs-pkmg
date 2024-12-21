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

bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
[[ -z $bookversion ]] && echo -e "\n>>>>> No book version. <<<<<\n" && exit 1

versionbuilddir=$BUILD_DIR
if [[ ! $BUILD_DIR == *"$bookversion"* ]]; then
	versionbuilddir=$BUILD_DIR/$bookversion-$REV

	mkdir -p $versionbuilddir

	cp -rv $BUILD_XML $versionbuilddir

fi


#------------------------------------------------------------------#
# UPDATE CURRENT CONFIG
#------------------------------------------------------------------#

versionbuilddir=${versionbuilddir//\//\\/}
sed -i "s/BK_VERS=/BOOK_VERS=$bookversion/" $CURRENT_CONFIG
sed -i "s/BLD_DIR=/BUILD_DIR=$versionbuilddir/" $CURRENT_CONFIG



