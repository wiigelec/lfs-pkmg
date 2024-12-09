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
installed_dir=$INSTALLROOT/$INSTALLED_DIR
[[ ! -d $installed_dir ]] && mkdir -p $installed_dir

# tempdir
tmpdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
mkdir -p $tmpdir

pushd $INSTALLROOT > /dev/null

### INSTALLED FILE LIST ###
install=${installpkg##*/}
ifl=${install%.txz}
ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl

tmpinstall=$tmpdir/$install

### DOWNLOAD ###
#echo "Downloading $installpkg..." && curl -o $tmpinstall $installpkg
curl --silent -o $tmpinstall $installpkg

### GET EXTRACTED SIZE ###
exsize=$(xz -l $tmpinstall | tail -n1 | tr -s ' ' | cut -d' ' -f6-7 \
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
tar --keep-directory-symlink -xpf $tmpinstall

### INSTALLED FILE LIST ###
tar -tf $tmpinstall | sed 's/^\.//g' | sed '/^\/$/d' > $ifl

### CLEANUP ###

popd > /dev/null

rm -rf $tmpdir
