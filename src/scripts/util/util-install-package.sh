#!/bin/bash
####################################################################
# 
# util-install-package.sh
#
####################################################################

set -e

### INITIALIZE ###
# install package
install=$1

# installed dir
[[ ! -d $INSTALLED_DIR ]] && mkdir -p $INSTALLROOT/$INSTALLED_DIR

# tempdir
tmpdir=/tmp/lfspkmg/$RANDOM
mkdir -p $tmpdir

pushd $INSTALLROOT > /dev/null

### INSTALLED FILE LIST ###
ifl=${install%.txz}
ifl=$INSTALLROOT/$INSTALLED_DIR/$ifl

tmpinstall=$tmpdir/$install

### DOWNLOAD ###
#echo "Downloading $install..."
curl --silent -o $tmpinstall $ARCHIVEPATH/$install

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
