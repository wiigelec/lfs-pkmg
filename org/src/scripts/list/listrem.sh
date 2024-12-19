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


### INSTALL PACKAGES ###

$PKGREM_SH


### LIST FILES ###

listsdir=${INSTALLROOT}$LISTS_DIR
listsfiles=$(ls $BUILD_DIR/config/*.list)
for each in $listsfiles; do

	as_root rm ${INSTALLROOT}$LISTS_DIR/${each##*/}
done

