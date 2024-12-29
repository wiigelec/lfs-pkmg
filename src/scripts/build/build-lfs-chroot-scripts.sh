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

# kernel config
echo "Getting kernel config..."
sourcedir=$INSTALLROOT/sources
pushd $sourcedir > /dev/null
wget https://mirrors.slackware.com/slackware/slackware64-15.0/kernels/huge.s/config
mv -v config kernel-config
popd > /dev/null

sudo chroot $INSTALLROOT bash -e -c "for f in /jhalfs/lpm-scripts/lfs/*; \\
	do echo \"Running \$f...\"; ARCHIVE_DIR=$LPM_ARCHIVE LFS_VER=$lfsver \$f; done"

