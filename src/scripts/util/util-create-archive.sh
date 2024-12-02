#!/bin/bash
####################################################################
# 
# util-create-archive.sh
#
####################################################################

### PACKAGE INFO ###
PKG_ARCH=$(uname -m)
PKG_LFS=lfs$LFS_VER
PKG_EXT=txz


### PACKAGE ARCHIVE ###
[[ -z $(ls -A $PKGLOG_DIR) ]] && exit
[[ ! -d $ARCHIVE_DIR ]] && mkdir -p $ARCHIVE_DIR


for FILE in $PKGLOG_DIR/*.pkglog;
do
    	echo Processing $FILE...

    	# tar files
    	pkg=${FILE%.pkglog}
    	pkg=${pkg##*/}

	ARCHIVE_NAME=$ARCHIVE_DIR/$pkg-$PKG_ARCH-$PKG_LFS.$PKG_EXT

    	tar --no-recursion -cJpf $ARCHIVE_NAME -T $FILE > /dev/null 2>&1
done
