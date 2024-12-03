#!/bin/bash
####################################################################
# 
# util-get-jhalfs.sh
#
####################################################################

### GIT CLONE LFS JHALFS ###

mkdir -p $JHALFS_GIT_DIR
git clone $JHALFS_GIT $JHALFS_GIT_DIR

# remove prompts
sed -i '/read/d' $JHALFS_GIT_DIR/jhalfs
