#!/bin/bash
####################################################################
# 
# book-blfs-fullxml.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

#------------------------------------------------------------------#
# CHECKOUT BRANCH
#------------------------------------------------------------------#

# GET BRANCH
branch=${BLFSBRANCH##*=}
pushd $BLFS_GIT_DIR  > /dev/null
git pull
git checkout $branch
popd > /dev/null


#------------------------------------------------------------------#
# SET REV
#------------------------------------------------------------------#

rev=sysv
[[ $REV == "SYSD" ]] && rev=systemd


#------------------------------------------------------------------#
# VALIDATE
#------------------------------------------------------------------#

blfsfullxml=$BUILD_XML/$BLFS_FULL_XML

mkdir -p $BUILD_XML
make -C $BLFS_GIT_DIR RENDERTMP=$BUILD_XML REV=$rev validate
[[ "$rev" = "systemd" ]] && mv -v $BUILD_XML/blfs-systemd-full.xml $blfsfullxml

