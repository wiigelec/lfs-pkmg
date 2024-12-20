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

blfsfullxml=$BUILD_XML/$BLFS_FULL_XML

bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $blfsfullxml | sed 's/Version //' | sed 's/-/\./')
[[ -z $bookversion ]] && echo -e "\n>>>>> No book version. <<<<<\n" && exit 1

versionbuilddir=$BUILD_DIR
[[ ! $BUILD_DIR == *"$bookversion"* ]] && versionbuilddir=$BUILD_DIR/$bookversion-$REV

mkdir -p $versionbuilddir

cp -rv $BUILD_XML $versionbuilddir


#------------------------------------------------------------------#
# UPDATE CURRENT CONFIG
#------------------------------------------------------------------#

versionbuilddir=${versionbuilddir//\//\\/}
sed -i "s/BK_VERS=/BOOK_VERS=$bookversion/" $CURRENT_CONFIG
sed -i "s/BLD_DIR=/BUILD_DIR=$versionbuilddir/" $CURRENT_CONFIG



