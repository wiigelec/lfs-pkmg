#!/bin/bash
####################################################################
# 
# build-blfs-acrhives.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# CREATE PKGLOGS
#------------------------------------------------------------------#

echo
echo "Building pkglogs..."
as_root $BUILD_PKGLOGS_SH


#------------------------------------------------------------------#
# CREATE ARCHIVES
#------------------------------------------------------------------#

echo
echo "Building archives..."
as_root $BUILD_ARCHIVES_SH


echo
echo "Done."
