#!/bin/bash
####################################################################
# 
# install-config-in.sh
#
####################################################################


installedlist=$(ls $INSTALLROOT/$INSTALLED_DIR | sort)

if [[ -z $installedlist ]]; then
	echo
	echo ">>>>> Nothing to be done. <<<<<"
	echo
	exit 1
fi

[[ -f $PKGREM_CONFIG_IN ]] && rm $PKGREM_CONFIG_IN

for i in $installedlist; do

	echo "config	$i" >> $PKGREM_CONFIG_IN
	echo "	bool \"$i\"" >> $PKGREM_CONFIG_IN

done

