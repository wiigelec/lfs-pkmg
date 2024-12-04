#!/bin/bash
####################################################################
# 
# bl-jhalfs-mnt.sh
#
####################################################################o

set -e

pushd $JHALFS_GIT_DIR > /dev/null
./jhalfs run
popd > /dev/null

touch $JHALFS_LFS
