#!/bin/bash
####################################################################
# 
# action-launch.sh
#
####################################################################


#------------------------------------------------------------------#
# MAKE ACTION
#------------------------------------------------------------------#

source $CURRENT_CONFIG

export BUILD_DIR="$BUILD_DIR"
export BLFS_FULL_XML="${BUILD_DIR}$BLFS_FULL_XML"
export BLFS_PKGLIST_XML="${BUILD_DIR}$BLFS_PKGLIST_XML"
export BOOK_BLFS_DEPS="${BUILD_DIR}$BOOK_BLFS_DEPS"
export BOOK_BLFS_SCRIPTS="${BUILD_DIR}$BOOK_BLFS_SCRIPTS"

echo
echo "Launching $ACTION"
echo

make $ACTION
