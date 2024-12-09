#!/bin/bash
####################################################################
# 
# upgrade-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$UPGRADE_CONFIG_OUT $MENU_CONFIG $UPGRADE_CONFIG_IN


### INSTALL PACKAGE LIST ###
upgrpkg=$(grep =y $UPGRADE_CONFIG_OUT)

[[ -f $UPGRADE_PKG_LIST ]] && rm $UPGRADE_PKG_LIST

for ip in $upgrpkg; do

	write=${ip#CONFIG_}
	write=${write%=y}

	echo $write >> $UPGRADE_PKG_LIST
done

