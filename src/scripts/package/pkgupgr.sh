#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e

### INITIALIZE ###

# sudo
if [[ ! -z $NOSUDO ]]; then sudo="";
else sudo="sudo -E"; fi


### CONFIRM ###
echo
echo "Upgrading:"
echo
echo "$(cat $UPGRADE_PKG_LIST | xargs)"
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

### ITERATE INSTALL PACKAGE LIST ###
while IFS= read -r line;
do
	### CHECK INSTALLED ###
	installed_dir=${INSTALLROOT}$INSTALLED_DIR
        iff=${line%.txz}
	ifl=$installed_dir/$iff
        #[[ -f $ifl ]] && echo "Skipping $line: INSTALLED" && continue

	upgrpkg=$MIRRORPATH/$line

	### VOLATILE FILES SPECIAL HANDLING ###
	if [[ $line == "aa_volatile-files"* ]]; then

		# destdir rename and copy
		destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
		export DESTDIR=$destdir
		$sudo $UTIL_INSTALL_PKG_SH $upgrpkg
		for f in $destdir/etc/*; do $sudo mv $f $f.new; done
		$sudo cp -a $destdir/* $INSTALLROOT
		rm -rf $destdir


	### VOLATILE DIRS SPECIAL HANDLING ###
	elif [[ $line == "aa_volatile-dirs"* ]]; then
		
		# destdir and copy
		destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
		export DESTDIR=$destdir
		$sudo $UTIL_INSTALL_PKG_SH $upgrpkg
		$sudo cp -a $destdir/* $INSTALLROOT
		rm -rf $destdir


	### INSTALL NEW PACKAGE ###
	else
		$sudo $UTIL_INSTALL_PKG_SH $upgrpkg
	fi

	### KERNEL SPECIAL HANDLING NO REMOVE ###
	[[ $line == "kernel"* ]] && continue


	### REMOVE OLD PACKAGE ###
	findpkg=${line%%--*}
	for p in $(find $installed_dir -name $findpkg--*); 
	do
		test=${p##*/}
		[[ $test == $iff ]] && continue

		oldpkg=$test
		$sudo $UTIL_REMOVE_PKG_SH $oldpkg
	done	

	echo

done < $UPGRADE_PKG_LIST



