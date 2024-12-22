#!/bin/bash
####################################################################
# 
# select-repo-lists.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 
source $SCRIPTS_FUNCS/get-lp-listing.func


#------------------------------------------------------------------#
# GET LP LISTING
#------------------------------------------------------------------#

get-lp-listing "LIST" > $REPOLIST_CONFIG_IN


#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$REPOLIST_CONFIG_OUT $MENU_CONFIG $REPOLIST_CONFIG_IN


#------------------------------------------------------------------#
# WRITE PACKAGE LIST
#------------------------------------------------------------------#

grep CONFIG_.*=y $REPOLIST_CONFIG_OUT | sed -e 's/CONFIG_//g' -e 's/=y//g' > $REPO_LIST_LIST
