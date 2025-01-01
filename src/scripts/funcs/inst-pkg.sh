#!/bin/bash
####################################################################
# 
# inst-pkg.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# INITIALIZE
#------------------------------------------------------------------#

installpkg=$1

installed_dir=$INSTALLROOT/$LPM_INSTALLED
[[ ! -d $installed_dir ]] && mkdir -p $installed_dir

# DOWNLOAD DIR
downloaddir=${INSTALLROOT}$LPM_DOWNLOADS
[[ ! -d $downloaddir ]] && mkdir -p $downloaddir

# DESTDIR
destdir=${DESTDIR:-$INSTALLROOT}
[[ ! -d $destdir ]] && mkdir -p $destdir 
pushd $destdir > /dev/null


### INSTALLED FILE LIST ###
file=${installpkg##*/}
name=${file%.txz}
ifl=$installed_dir/$name


#------------------------------------------------------------------#
# DOWNLOAD
#------------------------------------------------------------------#

### SERVER ###
if [[ $installpkg == "http"* ]]; then

	download=$downloaddir/$file
	curl --silent -o $download $installpkg
	[[ -z $(file $download | grep XZ) ]] && rm $download

### FILE ###
else
	download=$installpkg
fi

### CHECK DOWNLOAD ###
if [[ ! -f $download ]]; then

	echo "SKIPPING: $installpkg not found."
	exit 1
fi


#------------------------------------------------------------------#
# GET EXTRACTED SIZE
#------------------------------------------------------------------#

exsize=$(xz -l $download | tail -n1 | tr -s ' ' | cut -d' ' -f6-7 \
	| sed 's/\.[0-9 ] //' | sed 's/,//' | sed 's/B$//' | \
	numfmt --from=iec-i --to-unit=1k --grouping)


#------------------------------------------------------------------#
# FORMAT OUTPUT
#------------------------------------------------------------------#

a="Installing:+$file"
b="+$exsize"
message=$(printf "%-80s %10s+K" "$a" "$b")
message=${message// /.}
message=${message//+/ }


#------------------------------------------------------------------#
# INSTALL
#------------------------------------------------------------------#

echo "$message"
tar --keep-directory-symlink -xpf $download

### INSTALLED FILE LIST ###
tar -tf $download | sed 's/^\.//g' | sed '/^\/$/d' > $ifl

chroot $INSTALLROOT ldconfig > /dev/null 2>&1 || true


### CLEANUP ###

popd > /dev/null

