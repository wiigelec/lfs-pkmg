#!/bin/bash
####################################################################
# 
# package-install.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# INSTALL PACKAGES
#------------------------------------------------------------------#

# CONFIRM
installpkglist=$(cat $INST_PKGS_LIST | xargs)
repopath=$(head -n1 $INST_PKGS_LIST)
repopath=${repopath%/*}
installpkglist=${installpkglist//$repopath\//}

echo
echo "Installing:"
echo
echo "$installpkglist"
echo
echo "from $repopath"
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

# ITERATE INSTALL PACKAGE LIST
while IFS= read -r line;
do
	# CHECK INSTALLED
	ifl=${line%.txz}
	ifl=${ifl##*/}
	ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl
	[[ -f $ifl ]] && echo "Skipping ${line##*/}: INSTALLED" && continue

	as_root $INST_PKG_SH $line

done < $INST_PKGS_LIST
