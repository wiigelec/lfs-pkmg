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

[[ ! -d $BLFS_SCRIPTS_DIR ]] && mkdir -p $BLFS_SCRIPTS_DIR
xsltproc --stringparam files true \
        --stringparam pkglist $BLFS_PKGLIST_XML \
        --stringparam scriptsdir $BLFS_SCRIPTS_DIR/ \
        $BLFS_SCRIPTS_XSL $BLFS_FULL_XML


#------------------------------------------------------------------#
# FIX DEPS
#------------------------------------------------------------------#

echo
echo "Fixing scripts..."
echo
fix-scripts
