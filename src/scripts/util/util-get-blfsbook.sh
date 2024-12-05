#!/bin/bash
####################################################################
# 
# util-get-lfsbook.sh
#
####################################################################

### GIT CLONE LFS BOOK ###

mkdir -p $BUILD_XML_DIR
[[ ! -d $LFS_BOOK ]] && git clone $BLFS_GIT $BLFS_BOOK
pushd $BLFS_BOOK > /dev/null
git pull
popd > /dev/null

