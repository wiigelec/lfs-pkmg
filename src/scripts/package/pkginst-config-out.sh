#!/bin/bash
####################################################################
# 
# pkginst-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$PKGINST_CONFIG_OUT $MENU_CONFIG $PKGINST_CONFIG_IN


### INSTALL PACKAGE LIST ###
instpkg=$(grep =y $PKGINST_CONFIG_OUT)

[[ -f $INSTALL_PKG_LIST ]] && rm $INSTALL_PKG_LIST

for ip in $instpkg; do

	write=${ip#CONFIG_}
	write=${write%=y}

	echo $write >> $INSTALL_PKG_LIST
done


