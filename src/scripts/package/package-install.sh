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
installpkglist=$(cat $REPO_PKGS_LIST | xargs)

echo
echo "Installing:"
echo
echo "$installpkglist"
echo
echo "to $INSTALLROOT"
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Installing package files to $INSTALLROOT:"
echo

# ITERATE INSTALL PACKAGE LIST
error="false"
while IFS= read -r line;
do
	# CHECK INSTALLED
	ifl=${line%.txz}
	ifl=${ifl##*/}
	ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl
	[[ -f $ifl ]] && echo "Skipping ${line##*/}: INSTALLED" && continue

	set +e
	as_root $INST_PKG_SH $line
	ret=$?
	set -e

	[ $ret -ne 0 ] && error="true"

done < $REPO_PKGS_LIST

if [[ $error == "true" ]]; then 

	echo
	echo ">>>>> Package install errors occured. <<<<<"
	echo
	exit 1
fi
