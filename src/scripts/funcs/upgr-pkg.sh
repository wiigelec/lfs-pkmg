#!/bin/bash
####################################################################
# 
# inst-pkg.sh
#
####################################################################

set -e
source $CURRENT_CONFIG

path=$1

file=${path##*/}
package=${file%.txz}

### CHECK INSTALLED ###
installed_dir=${INSTALLROOT}$LPM_INSTALLED
if [[ -f $installed_dir/$package ]]; then echo "Skipping:   $package INSTALLED";

else
	echo

	### VOLATILE FILES SPECIAL HANDLING ###
	if [[ $package == "aa_volatile-files"* ]]; then

		# destdir rename and copy
		destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
		export DESTDIR=$destdir
		$INST_PKG_SH $path
		for f in $destdir/etc/*; do $sudo mv $f $f.new; done
		cp -a $destdir/* $INSTALLROOT
		rm -rf $destdir


	### VOLATILE DIRS SPECIAL HANDLING ###
	elif [[ $package == "aa_volatile-dirs"* ]]; then
		
		# destdir and copy
		destdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
		export DESTDIR=$destdir
		$INST_PKG_SH $path
		cp -a $destdir/* $INSTALLROOT
		rm -rf $destdir


	### INSTALL NEW PACKAGE ###
	else
		$INST_PKG_SH $path
	fi
fi

### KERNEL SPECIAL HANDLING NO REMOVE ###
[[ $package == "kernel"* ]] && exit 0


### REMOVE OLD PACKAGE ###
pkgname=${package%%--*}
installed_dir=${INSTALLROOT}$LPM_INSTALLED
for p in $(find $installed_dir -name $pkgname--*); 
do
	# don't remove upgraded
	[[ ${p##*/} == $package ]] && continue

	$REMV_PKG_SH $p
	
done
