#!/bin/bash
####################################################################
# 
# select-action-params.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/action-config-in.func

#------------------------------------------------------------------#
# GENERATE CONFIG IN
#------------------------------------------------------------------#

mkdir -p $BUILD_CONFIG
action-config-in > $ACTION_CONFIG_IN


#------------------------------------------------------------------#
# RUN MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$ACTION_CONFIG_OUT $MENU_CONFIG $ACTION_CONFIG_IN


#------------------------------------------------------------------#
# FORMAT CURRENT CONFIG
#------------------------------------------------------------------#

cp $ACTION_CONFIG_OUT $CURRENT_CONFIG

sed -i '/^#/d' $CURRENT_CONFIG
sed -i 's/CONFIG_//g' $CURRENT_CONFIG
sed -i 's/=y//g' $CURRENT_CONFIG
sed -i 's/__/=/g' $CURRENT_CONFIG
sed -i 's/"//g' $CURRENT_CONFIG

echo "BK_VERS=" >> $CURRENT_CONFIG
echo "BLD_DIR=" >> $CURRENT_CONFIG

echo "BUILD_XML=\$BUILD_DIR/xml" >> $CURRENT_CONFIG
echo "BLFS_FULL_XML=\$BUILD_XML/\$BLFS_FULL_XML" >> $CURRENT_CONFIG
echo "BLFS_PKGLIST_XML=\$BUILD_XML/\$BLFS_PKGLIST_XML" >> $CURRENT_CONFIG
echo "WORK_DIR=\$BUILD_DIR/work" >> $CURRENT_CONFIG
echo "BLFS_SCRIPTS_DIR=\$BUILD_DIR/\$BLFS_SCRIPTS_DIR" >> $CURRENT_CONFIG
echo "TREES_DIR=\$BUILD_DIR/\$TREES_DIR" >> $CURRENT_CONFIG
echo "DEPS_DIR=\$BUILD_DIR/\$DEPS_DIR" >> $CURRENT_CONFIG
