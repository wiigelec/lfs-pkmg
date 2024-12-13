#!/bin/bash
####################################################################
# 
# listinst-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$LISTINST_CONFIG_OUT $MENU_CONFIG $LISTINST_CONFIG_IN


### INSTALL PACKAGE LIST ###

[[ -f $INSTALL_PKG_LIST ]] && rm $INSTALL_PKG_LIST

list=$(grep =y $LISTINST_CONFIG_OUT)

for lf in $list; do

	listfile=${lf#CONFIG_}
	listfile=${listfile%=y}

	### SERVER LIST ###
	if [[ $listfile == "http..//"* ]]; then

		listfile=${listfile//../:}
		readlist=$(curl --silent $listfile)
	else
		readlist=$(cat $listfile)
	fi

	listpath=${listfile%/*}
	listpath=${listpath/lists/packages}

	for line in $readlist;
	do
		echo $listpath/$line >> $INSTALL_PKG_LIST

	done
done
