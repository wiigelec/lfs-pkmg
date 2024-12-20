#!/bin/bash
####################################################################
# 
# book-blfs-pkglist.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

BUILD_XML=$BUILD_DIR/xml
BLFS_FULL_XML=$BUILD_XML/$BLFS_FULL_XML
BLFS_PKGLIST_XML=$BUILD_XML/$BLFS_PKGLIST_XML

#------------------------------------------------------------------#
# GET VERSION INFO
#------------------------------------------------------------------#

kf6_version=$(grep 'ln -sfv kf6' $BLFS_FULL_XML | sed 's/.* kf6-\(.*\) .*/\1/')


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

xsltproc -o $BLFS_PKGLIST_XML \
	--stringparam book-version $BOOK_VERS \
        --stringparam kf6-version $kf6_version \
        $BLFS_PKGLIST_XSL $BLFS_FULL_XML

# FIX VERSIONS

sed -i 's/\$\$.*-\(.*\)\$\$/\1/' $BLFS_PKGLIST_XML


#------------------------------------------------------------------#
# UNVERSIONED
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# UPDATE INSTALLED
#------------------------------------------------------------------#
