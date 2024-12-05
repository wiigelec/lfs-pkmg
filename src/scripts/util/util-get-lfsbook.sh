#!/bin/bash
####################################################################
# 
# util-get-lfsbook.sh
#
####################################################################

### GIT CLONE LFS BOOK ###

mkdir -p $BUILD_XML_DIR
[[ ! -d $LFS_BOOK ]] && git clone $LFS_GIT $LFS_BOOK
pushd $LFS_BOOK > /dev/null
git pull
popd > /dev/null
