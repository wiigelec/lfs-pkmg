#!/bin/bash
####################################################################
# 
# package-config-in.sh
#
####################################################################


### GET PACKAGE LIST ###

if [[ $MIRRORPATH == "file://"* ]]; then

	packagelist=$(ls ${MIRRORPATH#file://} | sort)
else

	packagelist=$(curl --silent $ARCHIVEPATH | sort)
fi



### BUILD CONFIG IN ###

[[ -f $PKGINST_CONFIG_IN ]] && rm $PKGINST_CONFIG_IN
for p in $packagelist; do

	echo "config	$p" >> $PKGINST_CONFIG_IN
	echo "	bool \"$p\"" >> $PKGINST_CONFIG_IN

done

