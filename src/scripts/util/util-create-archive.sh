#!/bin/bash
####################################################################
# 
# util-create-archive.sh
#
####################################################################

LFS_BLD=${LFS_BLD:-blfs}
LFS_VER=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')

### PACKAGE INFO ###
PKG_ARCH=$(uname -m)
PKG_LFS=${LFS_BLD}$LFS_VER
PKG_EXT=txz


### PACKAGE ARCHIVE ###
[[ -z $(ls -A $PKGLOG_DIR) ]] && exit
[[ ! -d $ARCHIVE_DIR ]] && mkdir -p $ARCHIVE_DIR


for FILE in $PKGLOG_DIR/*.pkglog;
do
    	echo Processing $FILE...

    	### TAR FILES ###
    	pkg=${FILE%.pkglog}
    	pkg=${pkg##*/}

	ARCHIVE_NAME=$ARCHIVE_DIR/$pkg--$PKG_ARCH--$PKG_LFS.$PKG_EXT
	
    	tar --no-recursion -cJpf $ARCHIVE_NAME -T $FILE > /dev/null 2>&1

	### STRIP ###
	tmpdir=/tmp/lfspkmg$RANDOM
	mkdir $tmpdir
	pushd $tmpdir > /dev/null

	tar -xpf $ARCHIVE_NAME
		
	find | xargs file | grep -e "executable" -e "shared object" | grep ELF | \
		cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null

	tar -cJpf $ARCHIVE_NAME .

	popd > /dev/null
	#rm -rf $tmpdir

done
