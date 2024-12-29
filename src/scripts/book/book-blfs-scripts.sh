#!/bin/bash
####################################################################
# 
# book-blfs-scripts.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/fix-scripts.func
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

[[ ! -d $BUILD_SCRIPTS ]] && mkdir -p $BUILD_SCRIPTS
xsltproc --stringparam files true \
        --stringparam pkglist $BLFS_PKGLIST_XML \
        --stringparam scriptsdir $BUILD_SCRIPTS/ \
        $BLFS_SCRIPTS_XSL $BLFS_FULL_XML


#------------------------------------------------------------------#
# FIX SCRIPTS
#------------------------------------------------------------------#

echo
echo "Fixing scripts..."
echo
fix-scripts
