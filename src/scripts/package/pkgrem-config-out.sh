#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$PKGREM_CONFIG_OUT $MENU_CONFIG $PKGREM_CONFIG_IN


### REMOVE PACKAGE LIST ###
rmpkg=$(grep =y $PKGREM_CONFIG_OUT)

[[ -f $REMOVE_PKG_LIST ]] && rm $REMOVE_PKG_LIST

for rp in $rmpkg; do

	write=${rp#CONFIG_}
	write=${write%=y}

	echo ${INSTALLROOT}${INSTALLED_DIR}/$write >> $REMOVE_PKG_LIST
done


