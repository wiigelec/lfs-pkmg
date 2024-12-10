#!/bin/bash
####################################################################
# 
# upgrade-config-in.sh
#
####################################################################

mkdir -p $BUILD_DIR/install

if [[ $UPGRADEPATH == "file://"* ]]; then
	packagelist=$(ls ${UPGRADEPATH##file://} | sort)
else
	packagelist=$(curl --silent $UPGRADEPATH | sort)
fi

[[ -f $UPGRADE_CONFIG_IN ]] && rm $UPGRADE_CONFIG_IN

for p in $packagelist; do

	echo "config	$p" >> $UPGRADE_CONFIG_IN
	echo "	bool \"$p\"" >> $UPGRADE_CONFIG_IN

done

