#!/bin/bash
####################################################################
# 
# list-create-cust.sh
#
####################################################################

set -e
source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/setup-deps.func


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# WRITE BLFS PACKAGES
#------------------------------------------------------------------#

echo
$LIST_CREATE_DEPS_SH


#------------------------------------------------------------------#
# WRITE BUILD PACKAGES
#------------------------------------------------------------------#

echo
echo "Processing .build files..."
echo

pkgarch=$(uname -m)
pkglfs=blfs-$BOOK_VERS-$(echo $REV | tr '[:upper:]' '[:lower:]')
pkgext=txz

buildpkgs=$(cat $CSTM_BLDS_LIST)
for bp in $buildpkgs; do
	### GET PACKAGE INFO ###
	pkgname=$(grep ^PKG_NAME= $CUSTOM_BUILD/$bp | sed 's/.*=//')
	pkgver=$(grep ^PKG_VER= $CUSTOM_BUILD/$bp | sed 's/.*=//')
	arcname=$pkgname--$pkgver--$pkgarch--$pkglfs.$pkgext

	echo "$arcname" | as_root tee -a $LISTFILE
done

