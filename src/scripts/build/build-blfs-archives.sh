#!/bin/bash
####################################################################
# 
# build-blfs-archives.sh
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
as_root rm $LPM_PKGLOG/* > /dev/null 2>&1 || true
export LPM_PKGLOG=$LPM_PKGLOG
as_root $BUILD_PKGLOGS_SH

### COMBINE PASS1 ###
pass1=$(find $PKGLOG_DIR -name "*-pass1--*")
for p in $pass1;
do
	np=${p/-pass1/}
	write="$(cat $p $np | sort -u)"
		
	echo "$write" | as_root tee $np > /dev/null

	as_root rm $p
done


#------------------------------------------------------------------#
# CREATE ARCHIVES
#------------------------------------------------------------------#

### GET BOOK VERSION ###

bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
[[ ! -z $bookversion ]] && export BOOK_VERS=$bookversion

echo
echo "Building archives..."
export LPM_ARCHIVE=$LPM_ARCHIVE
as_root $BUILD_ARCHIVES_SH


echo
echo "Done."
