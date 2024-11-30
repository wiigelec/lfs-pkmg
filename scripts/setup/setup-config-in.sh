#!/bin/bash
####################################################################
# 
# setup-config-in.sh
#
####################################################################


### UPDATE LFS BOOK ###
pushd $LFS_BOOK_DIR > /dev/null
git pull
popd > /dev/null

$UTIL_SETUP_CONFIG_IN_SH > $SETUP_CONFIG_IN
