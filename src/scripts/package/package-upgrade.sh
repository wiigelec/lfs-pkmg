#!/bin/bash
####################################################################
# 
# package-upgrade.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# INSTALL UPGRADE
#------------------------------------------------------------------#

# CONFIRM
upgradepkglist=$(cat $REPO_PKGS_LIST | xargs)
repopath=$(head -n1 $REPO_PKGS_LIST)
repopath=${repopath%/*}
upgradepkglist=${upgradepkglist//$repopath\//}

echo
echo "Upgrading:"
echo
echo "$upgradepkglist"
echo
echo "from $repopath"
echo
echo "on $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Upgrading package files on $INSTALLROOT:"
echo

# ITERATE INSTALL PACKAGE LIST
while IFS= read -r line;
do
	as_root $UPGR_PKG_SH $line

done < $REPO_PKGS_LIST
