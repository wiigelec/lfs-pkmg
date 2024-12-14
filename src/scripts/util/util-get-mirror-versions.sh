#!/bin/bash
####################################################################
# 
# get-mirror-versions.sh
#
####################################################################

set -e

### GET VERION DIRS ###
FILE="false"
SERVER="false"
if [[ $MIRRORPATH == "http://"* || $MIRRORPATH == "https://"* ]]; then

	versionlist=$(curl --silent $MIRRORPATH | \
	       sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)\//\1/g' \
	       | sort)

	SERVER="true"

else
	[[ ! -d $MIRRORPATH ]] && echo -e "\n>>>>> $MIRRORPATH does not exist. <<<<<\n" && exit 1

	versionlist=$(ls ${MIRRORPATH} | sort)

	FILE="true"
fi

[[ $SERVER == "true" ]] && echo -n "SERVER "
[[ $FILE == "true" ]] && echo -n "FILE "

echo $versionlist
