#!/bin/bash
####################################################################
# 
# bb-build-list.sh
#
####################################################################

set -e

### GET SELECTED PACKAGES ###

grep CONFIG_CONFIG.*=y $BB_CONFIG_OUT | sed 's/CONFIG_CONFIG_//g' | sed 's/=y//g' > $BB_BUILD_LIST


### CONFIRM ###
echo
echo "Building the following packages and their dependencies:"
echo

for each in $(cat $BB_BUILD_LIST);
do
	echo $each
done

echo
read -p "Continue? (y) " confirm

if [[ $confirm != "y" ]]; then exit 1; fi

