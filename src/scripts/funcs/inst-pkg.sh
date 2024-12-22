#!/bin/bash
####################################################################
# 
# inst-pkg.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# INITIALIZE
#------------------------------------------------------------------#

installpkg=$1

installed_dir=$INSTALLROOT/$INSTALLED_DIR
[[ ! -d $installed_dir ]] && mkdir -p $installed_dir

# TEMP DIR
tmpdir=/tmp/lfspkmg$RANDOM
mkdir -p $tmpdir

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

	download=$tmpdir/$file
	curl --silent -o $download $installpkg

### FILE ###
else
	download=$installpkg
fi

### CHECK DOWNLOAD ###
if [[ ! -f $download ]]; then

	echo "SKIPPING: $installpkg not found."
	rm  -rf $tmpdir
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


### CLEANUP ###

popd > /dev/null

rm -rf $tmpdir