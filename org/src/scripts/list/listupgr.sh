#!/bin/bash
####################################################################
# 
# listinst.sh
#
####################################################################

set -e

### GET ASROOT ###
source <(echo $ASROOT)
export -f as_root


### UPGRADE PACKAGES ###

$PKGUPGR_SH


### LIST FILES ###

listsdir=${INSTALLROOT}$LISTS_DIR
[[ ! -d $listsdir ]] && as_root mkdir -p $listsdir
as_root mv $BUILD_DIR/config/*.list $listsdir/

