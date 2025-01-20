#!/bin/bash
####################################################################
# 
# book-lfs-scripts.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

[[ ! -d $BUILD_SCRIPTS ]] && mkdir -p $BUILD_SCRIPTS
xsltproc --stringparam files true \
        --stringparam pkglist $LFS_PKGLIST_XML \
        --stringparam scriptsdir $BUILD_SCRIPTS/ \
        --stringparam book LFS \
        $BLFS_SCRIPTS_XSL $LFS_FULL_XML


exit
