#!/bin/bash
####################################################################
# 
# listrem-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$LISTREM_CONFIG_OUT $MENU_CONFIG $LISTREM_CONFIG_IN


### INSTALL PACKAGE LIST ###

[[ -f $REMOVE_PKG_LIST ]] && rm $REMOVE_PKG_LIST

list=$(grep =y $LISTREM_CONFIG_OUT)

rm $BUILD_DIR/config/*.list 2> /dev/null || true

for lf in $list; do

	listpath=${INSTALLROOT}$LISTS_DIR

	listfile=${lf#CONFIG_}
	listfile=${listfile%=y}
	listfile=$listpath/$listfile

	readlist=$(cat $listfile)

	listpath=${INSTALLROOT}$INSTALLED_DIR

	for line in $readlist;
	do
		echo $listpath/${line%.txz} >> $REMOVE_PKG_LIST

	done

	### SAVE LIST ###
	listsave=$BUILD_DIR/config/${listfile##*/}
	[[ -f $listsave ]] && rm $listsave
	echo $line >> $listsave

done

