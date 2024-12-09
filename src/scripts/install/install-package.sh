#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e


### CONFIRM ###
echo
echo "Installing:"
echo
echo "$(cat $INSTALL_PKG_LIST | xargs)"
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
	ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl
	[[ -f $ifl ]] && echo "Skipping $line: INSTALLED" && continue 

	instpkg=$ARCHIVEPATH/$line
	sudo -E $UTIL_INSTALL_PKG_SH $instpkg

done < $INSTALL_PKG_LIST



