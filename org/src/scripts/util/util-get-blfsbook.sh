#!/bin/bash
####################################################################
# 
# util-get-lfsbook.sh
#
####################################################################

### GIT CLONE LFS BOOK ###

# nogit
[[ ! -z $NOGIT ]] && mkdir -p $BLFS_BOOK && exit 0

mkdir -p $BUILD_GIT_DIR
[[ ! -d $BLFS_BOOK ]] && git clone $BLFS_GIT $BLFS_BOOK
pushd $BLFS_BOOK > /dev/null
git pull
popd > /dev/null

