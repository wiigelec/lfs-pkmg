#!/bin/bash
####################################################################
# 
# book-blfs-deps.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/fix-deps.func


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

[[ ! -d $DEPTREE_DEPS ]] && mkdir -p $DEPTREE_DEPS
xsltproc --stringparam required true \
        --stringparam recommended true \
        --stringparam files true \
        --stringparam depsdir $DEPTREE_DEPS/ \
        $BLFS_DEPS_XSL $BLFS_FULL_XML


#------------------------------------------------------------------#
# FIX DEPS
#------------------------------------------------------------------#

echo
echo "Fixing deps..."
echo
fix-deps

