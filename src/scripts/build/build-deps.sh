#!/bin/bash
####################################################################
# 
# build-deps.sh
#
####################################################################

set -e


### GEN DEPS ###

echo
echo "Reading book dependencies..."
echo
[ ! -d $DEPS_DIR ] && mkdir -p $DEPS_DIR
xsltproc --stringparam required true \
	--stringparam recommended true \
	--stringparam files true \
	--stringparam depsdir $DEPS_DIR/ \
	$BLFS_DEPS_XSL $BLFS_FULL_XML


### FIX DEPS ###

$BB_FIX_DEPS_SH


### DONE ###

touch $BLFS_DEPS_DONE
