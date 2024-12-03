#!/bin/bash
####################################################################
# 
# bl-jhalfs-mnt.sh
#
####################################################################o

set -e

pushd $JHALFS_MNT > /dev/null
make
popd > /dev/null

touch $JHALFS_BUILD
