#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e

### INITIALIZE ###

# sudo
source <(echo $ASROOT)
export -f as_root

### CONFIRM ###
installpkglist=$(cat $INSTALL_PKG_LIST | xargs)
mirrorpath=$(head -n1 $INSTALL_PKG_LIST)
mirrorpath=${mirrorpath%/*}
installpkglist=${installpkglist//$mirrorpath\//}

echo
echo "Installing:"
echo
echo "$installpkglist"
echo
echo "from $mirrorpath"
echo
echo "to $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Installing package files to $INSTALLROOT:"
echo

### ITERATE INSTALL PACKAGE LIST ###
while IFS= read -r line;
do
	### CHECK INSTALLED ###
	ifl=${line%.txz}
	ifl=${ifl##*/}
	ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl
	[[ -f $ifl ]] && echo "Skipping ${line##*/}: INSTALLED" && continue 

	as_root $UTIL_INSTALL_PKG_SH $line

done < $INSTALL_PKG_LIST



