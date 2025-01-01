#!/bin/bash
####################################################################
# 
# package-remove.sh
#
####################################################################

set -e


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# REMOVE PACKAGES
#------------------------------------------------------------------#

### CONFIRM ###
removepkglist=$(cat $REMV_PKGS_LIST | xargs)
instpath=$(head -n1 $REMV_PKGS_LIST)
instpath=${instpath%/*}
removepkglist=${removepkglist//$instpath\//}

echo
echo "Removing:"
echo
echo "$removepkglist"
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
        as_root $REMV_PKG_SH $line

done < $REMV_PKGS_LIST
