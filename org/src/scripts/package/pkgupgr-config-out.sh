#!/bin/bash
####################################################################
# 
# pkgupgr-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$PKGUPGR_CONFIG_OUT $MENU_CONFIG $PKGUPGR_CONFIG_IN


### INSTALL PACKAGE LIST ###
upgrpkg=$(grep =y $PKGUPGR_CONFIG_OUT)

[[ -f $UPGRADE_PKG_LIST ]] && rm $UPGRADE_PKG_LIST

for ip in $upgrpkg; do

	write=${ip#CONFIG_}
	write=${write%=y}

	echo $write >> $UPGRADE_PKG_LIST
done

