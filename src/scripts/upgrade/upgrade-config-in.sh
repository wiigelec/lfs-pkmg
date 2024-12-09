#!/bin/bash
####################################################################
# 
# upgrade-config-in.sh
#
####################################################################

mkdir -p $BUILD_DIR/install

packagelist=$(curl --silent $UPGRADEPATH | sort)

[[ -f $UPGRADE_CONFIG_IN ]] && rm $UPGRADE_CONFIG_IN

for p in $packagelist; do

	echo "config	$p" >> $UPGRADE_CONFIG_IN
	echo "	bool \"$p\"" >> $UPGRADE_CONFIG_IN

done

