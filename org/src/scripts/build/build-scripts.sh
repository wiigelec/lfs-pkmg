#!/bin/bash
####################################################################
# 
# build-scripts.sh
#
####################################################################

set -e


### GENERATE BUILD SCRIPTS ###
echo
echo "Generating build scripts..."
echo
[ ! -d $BLFS_SCRIPTS_DIR ] && mkdir -p $BLFS_SCRIPTS_DIR
xsltproc --stringparam files true \
	--stringparam pkglist $PKG_BLFS_XML \
	--stringparam scriptsdir $BLFS_SCRIPTS_DIR/ \
	$BLFS_SCRIPTS_XSL $BLFS_FULL_XML


### FIX SCRIPTS ###

$BB_FIX_SCRIPTS_SH


### DONE ###
touch $BLFS_SCRIPTS_DONE
