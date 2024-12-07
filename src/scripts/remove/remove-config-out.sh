#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$REMOVE_CONFIG_OUT $MENU_CONFIG $REMOVE_CONFIG_IN


### REMOVE PACKAGE LIST ###
rmpkg=$(grep =y $REMOVE_CONFIG_OUT)

[[ -f $REMOVE_PKG_LIST ]] && rm $REMOVE_PKG_LIST

for rp in $rmpkg; do

	write=${rp#CONFIG_}
	write=${write%=y}

	echo $write >> $REMOVE_PKG_LIST
done


