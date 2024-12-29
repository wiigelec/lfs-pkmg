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

mkdir -p $BLD_XML
make -C $BLFS_GIT_DIR RENDERTMP=$BLD_XML REV=$rev validate
if [[ "$rev" == "systemd" ]]; then mv -v $BLD_XML/blfs-systemd-full.xml $BLFS_FULL_XML_NV; fi


#------------------------------------------------------------------#
# CREATE VERSION DIR
#------------------------------------------------------------------#

### CREATE BUILD DIR ###
[[ ! -d $BUILD_DIR ]] && mkdir -p $BUILD_DIR
mv -v $BLD_XML $BUILD_DIR
