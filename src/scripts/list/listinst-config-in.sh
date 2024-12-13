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

echo "menu \"Select List\"" > $LISTINST_CONFIG_IN 
for vl in $versionlist; do
	echo " menu   \"$vl\"" >> $LISTINST_CONFIG_IN 

	listdir=""

	### GET FILE LISTS ###
	skip="false"
	if [[ $file == "true" ]]; then
		path=$MIRRORPATH/$vl/lists/
		[[ -d $path ]] && listdir=${path}$(ls $path)
	fi

	## GET HTTP LISTS ###
	if [[ $server == "true" ]]; then
		url=$MIRRORPATH/$vl/lists/
		listdir="$listdir ${url}$(curl --silent $url | sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)$/\1/g')"
		listdir=${listdir//:/..}
	fi

	### WRITE CONFIG ###
	for lf in $listdir; do

		list=${lf##*/}
		[[ -z $list ]] && continue
		echo "   config  $lf" >> $LISTINST_CONFIG_IN 
		echo "     bool  \"$list\"" >> $LISTINST_CONFIG_IN 

	done

	echo "  endmenu" >> $LISTINST_CONFIG_IN 
done

echo "endmenu" >> $LISTINST_CONFIG_IN 

