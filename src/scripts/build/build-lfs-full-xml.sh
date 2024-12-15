#!/bin/bash
####################################################################
# 
# build-blfs-full-xml.sh
#
####################################################################

set -e


echo
echo "Processing LFS book..."
echo

### CHECKOUT BRANCH ###
        
pushd $LFS_BOOK  > /dev/null
git pull
git checkout $BLFSBRANCH
popd > /dev/null

### SET REV ###
rev=sysv
[[ $REV == "SYSD" ]] && rev=systemd
        
### GENERATE BLFS FULL XML ###
make -C $LFS_BOOK RENDERTMP=$BUILD_DIR/xml REV=$rev validate

