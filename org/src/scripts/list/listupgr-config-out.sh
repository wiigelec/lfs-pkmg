#!/bin/bash
####################################################################
# 
# listupgr-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$LISTUPGR_CONFIG_OUT $MENU_CONFIG $LISTUPGR_CONFIG_IN


### INSTALL PACKAGE LIST ###

[[ -f $UPGRADE_PKG_LIST ]] && rm $UPGRADE_PKG_LIST

list=$(grep =y $LISTUPGR_CONFIG_OUT)

rm $BUILD_DIR/config/*.list 2> /dev/null || true

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

	### SAVE LIST ###
	listsave=$BUILD_DIR/config/${listfile##*/}
	[[ -f $listsave ]] && rm $listsave


	### WRITE INSTALL PACKAGE LIST ###
	for line in $readlist;
	do
		echo $listpath/$line >> $UPGRADE_PKG_LIST
	
		# write save list
		echo $line >> $listsave

	done


done

