#!/bin/bash
####################################################################
# 
# build-pkg-blfs-xml.sh
#
####################################################################

set -e


### GET SOME VERSIONS ###
book_version=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
kf6_version=$(grep 'ln -sfv kf6' $BLFS_FULL_XML | sed 's/.* kf6-\(.*\) .*/\1/')

        
### PROCESS THE XML ###
xsltproc -o $PKG_BLFS_XML --stringparam book-version $book_version \
	--stringparam kf6-version $kf6_version \
	$PKG_BLFS_XSL $BLFS_FULL_XML

# fix versions
sed -i 's/\$\$.*-\(.*\)\$\$/\1/' $PKG_BLFS_XML


### WARN UNVERSIONED ##
unversioned=$(grep -F "$" $PKG_BLFS_XML | sed 's/.*<id>\(.*\)<\/id>.*/\1/')
[[ ! -z $unversioned ]] && echo -e "\nWARNING: the following packages are unversioned:\n"
for each in $unversioned
do
	echo $each
done
