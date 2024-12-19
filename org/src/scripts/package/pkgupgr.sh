#!/bin/bash
####################################################################
# 
# pkgupgr.sh
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
while IFS= read -r url;
do
	file=${url##*/}
	package=${file%.txz}


	### CHECK INSTALLED ###
	installed_dir=${INSTALLROOT}$INSTALLED_DIR
        if [[ -f $installed_dir/$package ]]; then echo "Skipping:   $package INSTALLED";
	else
		echo

		### VOLATILE FILES SPECIAL HANDLING ###
		if [[ $package == "aa_volatile-files"* ]]; then

			# destdir rename and copy
			destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
			export DESTDIR=$destdir
			$sudo $UTIL_INSTALL_PKG_SH $url
			for f in $destdir/etc/*; do $sudo mv $f $f.new; done
			$sudo cp -a $destdir/* $INSTALLROOT
			$sudo rm -rf $destdir


		### VOLATILE DIRS SPECIAL HANDLING ###
		elif [[ $package == "aa_volatile-dirs"* ]]; then
		
			# destdir and copy
			destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
			export DESTDIR=$destdir
			$sudo $UTIL_INSTALL_PKG_SH $url
			$sudo cp -a $destdir/* $INSTALLROOT
			$sudo rm -rf $destdir


		### INSTALL NEW PACKAGE ###
		else
			$sudo $UTIL_INSTALL_PKG_SH $url
		fi
	fi

	### KERNEL SPECIAL HANDLING NO REMOVE ###
	[[ $package == "kernel"* ]] && continue


	### REMOVE OLD PACKAGE ###
	pkgname=${package%%--*}
	for p in $(find $installed_dir -name $pkgname--*); 
	do
		# don't remove upgraded
		[[ ${p##*/} == $package ]] && continue
	
		$sudo $UTIL_REMOVE_PKG_SH $p
	
	done	


done < $UPGRADE_PKG_LIST



