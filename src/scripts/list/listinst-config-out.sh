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
		echo $listpath/$line >> $INSTALL_PKG_LIST
	
		# write save list
		echo $line >> $listsave

	done


done

