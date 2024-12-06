#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$INSTALL_CONFIG_OUT $MENU_CONFIG $INSTALL_CONFIG_IN


### INSTALL PACKAGE LIST ###
instpkg=$(grep =y $INSTALL_CONFIG_OUT)

[[ -f $INSTALL_PKG_LIST ]] && rm $INSTALL_PKG_LIST

for ip in $instpkg; do

	write=${ip#CONFIG_}
	write=${write%=y}

	echo $write >> $INSTALL_PKG_LIST
done


