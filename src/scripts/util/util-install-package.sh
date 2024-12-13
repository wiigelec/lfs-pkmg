#!/bin/bash
####################################################################
# 
# util-install-package.sh
#
####################################################################

set -e

### INITIALIZE ###

# install package
installpkg=$1

# installed dir
#echo "installed_dir=$INSTALLROOT/$INSTALLED_DIR"
installed_dir=$INSTALLROOT/$INSTALLED_DIR
[[ ! -d $installed_dir ]] && mkdir -p $installed_dir

# tempdir
tmpdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
mkdir -p $tmpdir

# destdir
destdir=${DESTDIR:-$INSTALLROOT}
[[ ! -d $destdir ]] && mkdir -p $destdir 
pushd $destdir > /dev/null


### INSTALLED FILE LIST ###
install=${installpkg##*/}
ifl=${install%.txz}
ifl=$installed_dir/$ifl


### DOWNLOAD ###
download=$tmpdir/$install
#echo "Downloading $installpkg to $download"
if [[ $installpkg == "http://"* || $installpkg == "https://"* ]]; then
	curl --silent -o $download $installpkg
else
	cp $installpkg $tmpdir
fi


### GET EXTRACTED SIZE ###
exsize=$(xz -l $download | tail -n1 | tr -s ' ' | cut -d' ' -f6-7 \
	| sed 's/\.[0-9 ] //' | sed 's/,//' | sed 's/B$//' | \
	numfmt --from=iec-i --to-unit=1k --grouping)

### FORMAT OUTPUT ###
a="$install"
b="+$exsize"
message=$(printf "%-80s %10s+K" "$a" "$b")
message=${message// /.}
message=${message//+/ }

### INSTALL ###
echo "$message"
tar --keep-directory-symlink -xpf $download

### INSTALLED FILE LIST ###
tar -tf $download | sed 's/^\.//g' | sed '/^\/$/d' > $ifl

### CLEANUP ###

popd > /dev/null

rm -rf $tmpdir
