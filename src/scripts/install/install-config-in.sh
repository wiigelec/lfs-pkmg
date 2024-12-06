#!/bin/bash
####################################################################
# 
# install-config-in.sh
#
####################################################################

mkdir -p $BUILD_DIR/install

packagelist=$(curl --silent $ARCHIVEPATH | sort)

[[ -f $INSTALL_CONFIG_IN ]] && rm $INSTALL_CONFIG_IN

for p in $packagelist; do

	echo "config	$p" >> $INSTALL_CONFIG_IN
	echo "	bool \"$p\"" >> $INSTALL_CONFIG_IN

done

