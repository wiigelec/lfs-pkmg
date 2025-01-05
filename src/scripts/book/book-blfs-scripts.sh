#!/bin/bash
####################################################################
# 
# book-blfs-scripts.sh
#
####################################################################

set -e


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


if [[ -f $CUSTOM_FIX_SCRIPTS_SH ]]; then 

	echo
	echo "Fixing scripts..."
	echo
	
	$CUSTOM_FIX_SCRIPTS_SH
fi

exit
