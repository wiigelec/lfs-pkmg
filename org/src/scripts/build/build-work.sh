#!/bin/bash
####################################################################
# 
# build-work.sh
#
####################################################################

set -e

### GET ASROOT ###

source <(echo $ASROOT)
export f as_root


## #GET LFS VERSION ###

LFS_VER=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed -e 's/Version //' -e 's/-/\./')
export LFS_VER="$LFS_VER"


### MAKE WORK DIR ###

make  -C $BUILD_DIR/work


### BUILD ARCHIVES ###

as_root $UTIL_CREATE_PKGLOG_SH
as_root $UTIL_CREATE_ARCHIVE_SH
