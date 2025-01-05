#!/bin/bash
####################################################################
# 
# book-blfs-deps.sh
#
####################################################################

set -e


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


if [[ -f $CUSTOM_FIX_DEPS_SH ]]; then 

	echo
	echo "Fixing deps..."
	echo

	$CUSTOM_FIX_DEPS_SH
fi

exit

