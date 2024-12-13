#!/bin/bash
####################################################################
# 
# listinst-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$LISTINST_CONFIG_OUT $MENU_CONFIG $LISTINST_CONFIG_IN


### INSTALL PACKAGE LIST ###

[[ -f $INSTALL_PKG_LIST ]] && rm $INSTALL_PKG_LIST

list=$(grep =y $LISTINST_CONFIG_OUT)

for lf in $list; do

	listfile=${lf#CONFIG_}
	listfile=${listfile%=y}

	listpath=${listfile%/*}
	listpath=${listpath/lists/packages}

	while IFS= read -r line;
	do
		echo $listpath/$line >> $INSTALL_PKG_LIST

	done < $listfile
done
