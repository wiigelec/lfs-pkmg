#!/bin/bash
####################################################################
# 
# audit-installed-packages.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# AUDIT
#------------------------------------------------------------------#


echo
echo "Auditing installed packages in $LPM_INSTALLED."
echo "Searching for packages not associated with a list..."
echo

installedpkgs=$(ls $LPM_INSTALLED)
[[ -z $installedpkgs ]] && echo -e ">>>>> No packages installed. <<<<<\n" && exit 1

latch=false
for FILE in $installedpkgs;
do
	echo $FILE
	pkg=${FILE##*/}
	found=$(grep $pkg $LPM_LISTS/*)
	if [[ -z "$found" ]]; then
		echo "$pkg"
		latch=true
	fi
done

[[ $latch == false ]] && echo "All installed packages associated with a list."
echo
