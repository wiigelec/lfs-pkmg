#!/bin/bash
####################################################################
# 
# remove-package.sh
#
####################################################################

set -e

### INITIALIZE ###

# sudo
if [[ ! -z $NOSUDO ]]; then sudo="";
else sudo="sudo -E"; fi

### CONFIRM ###
echo
echo "Removing:"
echo
echo "$(cat $REMOVE_PKG_LIST | xargs)"
echo
echo "from $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Removing package files from $INSTALLROOT:"
echo


### ITERATE REMOVE PACKAGE LIST ###
while IFS= read -r line;
do
        $sudo $UTIL_REMOVE_PKG_SH $line

done < $REMOVE_PKG_LIST
