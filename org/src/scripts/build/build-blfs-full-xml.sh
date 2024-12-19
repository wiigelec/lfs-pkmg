#!/bin/bash
####################################################################
# 
# build-blfs-full-xml.sh
#
####################################################################

set -e


echo
echo "Processing BLFS book..."
echo

### CHECKOUT BRANCH ###
        
pushd $BLFS_BOOK  > /dev/null
git pull
git checkout $BLFSBRANCH
popd > /dev/null

### SET REV ###
rev=sysv
[[ $REV == "SYSD" ]] && rev=systemd
        
### GENERATE BLFS FULL XML ###
make -C $BLFS_BOOK RENDERTMP=$BUILD_DIR/xml REV=$rev validate
if [ "$rev" = "systemd" ];then
	echo "Renaming systemd book..."
	mv $BUILD_DIR/xml/blfs-systemd-full.xml $BUILD_DIR/xml/blfs-full.xml
fi
