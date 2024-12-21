#!/bin/bash
####################################################################
# 
# build-archives.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# build-archives
#------------------------------------------------------------------#

LFS_BLD=${LFS_BLD:-blfs}

# PACKAGE INFO
PKG_ARCH=$(uname -m)
PKG_LFS=${LFS_BLD}$BOOK_VERS
PKG_EXT=txz


### PACKAGE ARCHIVE ###
[[ -z $(ls -A $PKGLOG_DIR) ]] && exit
[[ ! -d $ARCHIVE_DIR ]] && mkdir -p $ARCHIVE_DIR


for FILE in $PKGLOG_DIR/*.pkglog;
do
    	echo -ne "Processing $FILE...\033[0K\r"

    	# TAR FILES
    	pkg=${FILE%.pkglog}
    	pkg=${pkg##*/}

	ARCHIVE_NAME=$ARCHIVE_DIR/$pkg--$PKG_ARCH--$PKG_LFS.$PKG_EXT

    	tar --no-recursion -cJpf $ARCHIVE_NAME -T $FILE > /dev/null 2>&1

	# STRIP
	tmpdir=/tmp/lfspkmg$RANDOM
	mkdir $tmpdir
	pushd $tmpdir > /dev/null

	tar -xpf $ARCHIVE_NAME

	find | xargs file | grep -e "executable" -e "shared object" | grep ELF | \
		cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null

	tar -cJpf $ARCHIVE_NAME .

	popd > /dev/null
	rm -rf $tmpdir

done

echo -ne "\033[0K\r"
