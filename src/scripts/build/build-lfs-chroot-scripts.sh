#!/bin/bash
####################################################################
# 
# build-lfs-chroot-scripts.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# GET JHALFS BOOK VERSION
#------------------------------------------------------------------#

lfsvers=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $JHALFS_DIR/prbook.xml)
lfsvers=${lfsvers##* }


#------------------------------------------------------------------#
# CUSTOM SCRIPTS
#------------------------------------------------------------------#

echo
echo "Running custom scripts..."
echo

sudo chroot $INSTALLROOT bash -e -c "for f in /jhalfs/lpm-scripts/lfs/*; \\
	do echo \"Running LPM_ARCHIVE=$LPM_ARCHIVE LFS_VER=$lfsvers \$f...\"; \
		LPM_ARCHIVE=$LPM_ARCHIVE LFS_VER=$lfsvers REV=$REV \$f; done"

