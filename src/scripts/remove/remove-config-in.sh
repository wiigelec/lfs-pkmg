#!/bin/bash
####################################################################
# 
# install-config-in.sh
#
####################################################################

mkdir -p $BUILD_DIR/remove

installedlist=$(ls $INSTALLROOT/$INSTALLED_DIR | sort)

if [[ -z $installedlist ]]; then
	echo
	echo ">>>>> Nothing to be done. <<<<<"
	echo
	exit 1
fi

[[ -f $REMOVE_CONFIG_IN ]] && rm $REMOVE_CONFIG_IN

for i in $installedlist; do

	echo "config	$i" >> $REMOVE_CONFIG_IN
	echo "	bool \"$i\"" >> $REMOVE_CONFIG_IN

done

