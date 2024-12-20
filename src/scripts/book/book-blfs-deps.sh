#!/bin/bash
####################################################################
# 
# book-blfs-deps.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/fix-deps.func
source $CURRENT_CONFIG

DEPS_DIR=$BUILD_DIR/$DEPS_DIR
BUILD_XML=$BUILD_DIR/xml
BLFS_FULL_XML=$BUILD_XML/$BLFS_FULL_XML

#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

[[ ! -d $DEPS_DIR ]] && mkdir -p $DEPS_DIR
xsltproc --stringparam required true \
        --stringparam recommended true \
        --stringparam files true \
        --stringparam depsdir $DEPS_DIR/ \
        $BLFS_DEPS_XSL $BLFS_FULL_XML


#------------------------------------------------------------------#
# FIX DEPS
#------------------------------------------------------------------#

echo
echo "Fixing deps..."
echo
fix-deps
