#!/bin/bash
####################################################################
# 
# bb-build-list.sh
#
####################################################################

set -e

### GET ASROOT ###
source <(echo $ASROOT)
export -f as_root


### GET SELECTED PACKAGES ###

grep CONFIG_CONFIG.*=y $LISTDEPS_CONFIG_OUT | sed 's/CONFIG_CONFIG_//g' | sed 's/=y//g' > $BUILD_TREES_IN


### BUILD TREES ###

$UTIL_BUILD_TREES_SH $BUILD_TREES_IN
echo

$UTIL_ROOT_TREE_SH $BUILD_TREES_IN $BUILD_TREES_OUT
echo

### CREATE LIST FILE ###
echo 
echo "Creating list file $LISTNAME..."
echo

[[ -f $LISTNAME ]] && echo -e "\n>>>>> $LISTNAME exists. <<<<<\n" && exit 1
listdir=${LISTNAME%/*}
[[ ! -d $listdir ]] && as_root mkdir -p $listdir

while IFS= read -r line;
do
	name=$line
	version=$(xmllint --xpath "//package[id='$name']/version/text()" $PKG_BLFS_XML 2>/dev/null) || true
	lfsver=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')

	package=$name--$version--$(uname -m)--blfs$lfsver.txz
	echo $package | as_root tee -a $LISTNAME


done < $BUILD_TREES_OUT

echo
