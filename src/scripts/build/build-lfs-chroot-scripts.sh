#!/bin/bash
####################################################################
# 
# build-lfs-chroot-scripts.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# GET JHALFS BOOK VERSION
#------------------------------------------------------------------#

lfsver=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $JHALFS_DIR/prbook.xml | sed 's/.* \(.*\)-.*/\1/')


#------------------------------------------------------------------#
# CUSTOM SCRIPTS
#------------------------------------------------------------------#

echo
echo "Running custom scripts..."
echo

sudo chroot $INSTALLROOT bash -e -c "for f in /jhalfs/lpm-scripts/lfs/*; \\
	do echo \"Running \$f...\"; LPM_ARCHIVE=$LPM_ARCHIVE LFS_VER=$lfsver \$f; done"

