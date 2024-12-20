#!/bin/bash
####################################################################
# 
# book-blfs-deps.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/fix-deps.func
source $CURRENT_CONFIG


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
