#!/bin/bash
####################################################################
# 
# build-archives.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# build-archives
#------------------------------------------------------------------#

LFS_BLD=${LFS_BLD:-blfs}
rev=$(echo $REV | tr '[:upper:]' '[:lower:]')

# PACKAGE INFO
PKG_ARCH=$(uname -m)
[[ ! -z $BUILD_PRETEND ]] && PKG_LFS="PRETEND$PKG_LFS"
PKG_EXT=txz


### CHECK PKGLOGS ###

if [[ ! -d $LPM_PKGLOG ]] || [[ -z $(ls $LPM_PKGLOG) ]]; then
	echo ">>>>> Nothing to be done. <<<<<"
        [[ $ACTION == "BUILDCUSTOM" ]] && exit 0
        exit 1
fi


### PACKAGE ARCHIVE ###
[[ -z $(ls -A $LPM_PKGLOG) ]] && exit
[[ ! -d $LPM_ARCHIVE ]] && mkdir -p $LPM_ARCHIVE


for FILE in $LPM_PKGLOG/*.pkglog;
do
    	echo -ne "Archiving $FILE...\033[0K\r"

    	### TAR FILES ###
    	pkg=${FILE%.pkglog}
    	pkg=${pkg##*/}


	### CHECK BOOK ###
	[[ -f $LFS_PKGLIST_XML ]] && set +e && lfsbook=$(grep ">${pkg%--*}<" $LFS_PKGLIST_XML) && set -e
	[[ ! -z $lfsbook ]] && LFS_BLD="lfs"

	PKG_LFS=$LFS_BLD-$BOOK_VERS-$rev

	archivename=$pkg--$PKG_ARCH--$PKG_LFS.$PKG_EXT

	ARCHIVE_NAME=$LPM_ARCHIVE/$archivename

    	tar --no-recursion -cJpf $ARCHIVE_NAME -T $FILE > /dev/null 2>&1

	### STRIP ###

    	echo -ne "Stripping $FILE...\033[0K\r"

	tmpdir=/tmp/lfspkmg$RANDOM
	mkdir $tmpdir
	pushd $tmpdir > /dev/null

	tar -xpf $ARCHIVE_NAME

	{
	find | xargs file | grep -e "executable" -e "shared object" | grep ELF | \
	cut -f 1 -d : | xargs | strip --strip-unneeded
	} > /dev/null 2>&1 || true

	tar -cJpf $ARCHIVE_NAME .

	popd > /dev/null
	rm -rf $tmpdir

done

echo -ne "\033[0K\r"
