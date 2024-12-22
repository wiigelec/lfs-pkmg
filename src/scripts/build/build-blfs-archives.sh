#!/bin/bash
####################################################################
# 
# build-blfs-acrhives.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# CREATE PKGLOGS
#------------------------------------------------------------------#

echo
echo "Building pkglogs..."
as_root $BUILD_PKGLOGS_SH


#------------------------------------------------------------------#
# CREATE ARCHIVES
#------------------------------------------------------------------#

### GET TRUNK VERSION ###
if [[ $BLFSBRANCH == "trunk" ]]; then

	bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" ${BUILD_DIR}$BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
	[[ ! -z $bookversion ]] && sed -i "s/\(BOOK_VERS=\).*/\1$bookversion/" $CURRENT_CONFIG
fi

echo
echo "Building archives..."
as_root $BUILD_ARCHIVES_SH


echo
echo "Done."
