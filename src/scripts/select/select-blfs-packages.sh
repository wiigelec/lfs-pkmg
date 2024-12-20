#!/bin/bash
####################################################################
# 
# select-blfs-packages.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 

BUILD_XML=$BUILD_DIR/xml
BLFS_PKGLIST_XML=$BUILD_XML/$BLFS_PKGLIST_XML

#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

xsltproc -o $BLFSPKGS_CONFIG_IN $SELECT_BLFSPKGS_XSL $BLFS_PKGLIST_XML


#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$BLFSPKGS_CONFIG_OUT $MENU_CONFIG $BLFSPKGS_CONFIG_IN


#------------------------------------------------------------------#
# WRITE PACKAGE LIST
#------------------------------------------------------------------#

grep CONFIG_CONFIG.*=y $BLFSPKGS_CONFIG_OUT | sed 's/CONFIG_CONFIG_//g' | sed 's/=y//g' > $BLFS_PKGS_LIST
