#!/bin/bash
####################################################################
# 
# util-get-jhalfs.sh
#
####################################################################

### GIT CLONE LFS JHALFS ###

# nogit
[[ ! -z $NOGIT ]] && mkdir -p $JHALFS_GIT_DIR && exit 0

mkdir -p $JHALFS_GIT_DIR
git clone $JHALFS_GIT $JHALFS_GIT_DIR
