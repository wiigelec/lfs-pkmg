#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e


### CONFIRM ###
echo
echo "Upgrading:"
echo
echo "$(cat $UPGRADE_PKG_LIST | xargs)"
echo
echo "to $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Upgrading package files on $INSTALLROOT:"
echo

### ITERATE INSTALL PACKAGE LIST ###
while IFS= read -r line;
do
	### CHECK INSTALLED ###
	installed_dir=${INSTALLROOT}$INSTALLED_DIR
        iff=${line%.txz}
	ifl=$installed_dir/$iff
        #[[ -f $ifl ]] && echo "Skipping $line: INSTALLED" && continue


	### VOLATILE FILES SPECIAL HANDLING ###


	### VOLATILE DIRS SPECIAL HANDLING ###


	### INSTALL NEW PACKAGE ###
	upgrpkg=$UPGRADEPATH/$line
	sudo -E $UTIL_INSTALL_PKG_SH $upgrpkg


	### REMOVE OLD PACKAGE ###
	findpkg=${line%%--*}
	for p in $(find $installed_dir -name $findpkg--*); 
	do
		test=${p##*/}
		[[ $test == $iff ]] && continue

		oldpkg=${p##*/}
		sudo -E $UTIL_REMOVE_PKG_SH $oldpkg
	done	

	echo

done < $UPGRADE_PKG_LIST



