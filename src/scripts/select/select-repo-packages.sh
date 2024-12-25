#!/bin/bash
####################################################################
# 
# select-repo-packages.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 
source $SCRIPTS_FUNCS/get-lp-listing.func


#------------------------------------------------------------------#
# GET LP LISTING
#------------------------------------------------------------------#

get-lp-listing "PACKAGE" > $REPOPKGS_CONFIG_IN


#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$REPOPKGS_CONFIG_OUT $MENU_CONFIG $REPOPKGS_CONFIG_IN


#------------------------------------------------------------------#
# WRITE PACKAGE LIST
#------------------------------------------------------------------#

grep CONFIG_.*=y $REPOPKGS_CONFIG_OUT | sed -e 's/CONFIG_//g' -e 's/=y//g' > $REPO_PKGS_LIST
sed -i 's/\.\./:/g' $REPO_PKGS_LIST
sed -i 's/\(http.*:\)\/\//\1/g' $REPO_PKGS_LIST
sed -i 's/\/\//\//g' $REPO_PKGS_LIST
sed -i 's/\(http[s]*:\)/\1\/\//g' $REPO_PKGS_LIST
