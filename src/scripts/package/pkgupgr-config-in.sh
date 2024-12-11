#!/bin/bash
####################################################################
# 
# pkgupgr-config-in.sh
#
####################################################################


if [[ $MIRRORPATH == "file://"* ]]; then
	packagelist=$(ls ${MIRRORPATH##file://} | sort)
else
	packagelist=$(curl --silent $MIRRORPATH | sort)
fi

[[ -f $PKGUPGR_CONFIG_IN ]] && rm $PKGUPGR_CONFIG_IN

for p in $packagelist; do

	echo "config	$p" >> $PKGUPGR_CONFIG_IN
	echo "	bool \"$p\"" >> $PKGUPGR_CONFIG_IN

done

