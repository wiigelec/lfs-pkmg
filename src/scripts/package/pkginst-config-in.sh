#!/bin/bash
####################################################################
# 
# listinst-config-in.sh
#
####################################################################

set -e

### GET VERION DIRS ###
file="false"
server="false"
if [[ $MIRRORPATH == "http://"* || $MIRRORPATH == "https://"* ]]; then

	versionlist=$(curl --silent $MIRRORPATH | \
	       sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)\//\1/g' \
	       | sort)

	server="true"

else
	[[ ! -d $MIRRORPATH ]] && echo -e "\n>>>>> $MIRRORPATH does not exist. <<<<<\n" && exit 1

	versionlist=$(ls ${MIRRORPATH} | sort)

	file="true"
fi

### ITERATE VERSIONS ###

echo "menu \"Select Packages\"" > $PKGINST_CONFIG_IN 
for vl in $versionlist; do

	echo " menu   \"$vl\"" >> $PKGINST_CONFIG_IN 

	path=$MIRRORPATH/$vl/packages/

	### GET FILE LISTS ###
	if [[ $file == "true" ]]; then
		[[ -d $path ]] && pkgdir=$(ls $path)
	fi

	## GET HTTP LISTS ###
	if [[ $server == "true" ]]; then
		pkgdir="$(curl --silent $path | sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)$/\1/g')"
		path=${path//:/..}
	fi

	### WRITE CONFIG ###
	for pf in $pkgdir; do

		pkg=${pf##*/}
		[[ -z $pkg ]] && continue
		echo "   config  ${path}$pf" >> $PKGINST_CONFIG_IN 
		echo "     bool  \"$pkg\"" >> $PKGINST_CONFIG_IN 

	done

	echo "  endmenu" >> $PKGINST_CONFIG_IN 
done

echo "endmenu" >> $PKGINST_CONFIG_IN 

