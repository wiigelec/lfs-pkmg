#!/bin/bash
####################################################################
# 
# buildlfs-get-jhalfs.sh
#
####################################################################

### GIT CLONE LFS JHALFS ###

mkdir -p $LFS_JHALFS_DIR
git clone $JHALFS_GIT $LFS_JHALFS_DIR

mv $JHALFS_CONFIGIN $JHALFS_CONFIGIN.org
