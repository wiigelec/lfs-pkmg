#!/bin/bash
####################################################################
# 
# book-lfs-fullxml.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# GENERATE LFS FULL XML
#------------------------------------------------------------------#
	
[[ -z $BUILD_DIR ]] && echo -e "\n>>>>> BUILD_DIR undefined. <<<<<\n" && exit 1

if [[ ! -f $LFS_FULL_XML ]]; then

	### GET BRANCH ###

	branch=${LFSBRANCH##*=}
	pushd $LFS_GIT_DIR  > /dev/null
	git checkout $branch
	git pull
	popd > /dev/null


	### SET REV ###
	
	rev=sysv
	[[ $REV == "SYSD" ]] && rev=systemd


	#### VALIDATE ###

	mkdir -p $BLD_XML
	make -C $LFS_GIT_DIR RENDERTMP=$BLD_XML REV=$rev validate


	### CREATE BUILD DIR ###

	[[ ! -d $BUILD_DIR ]] && mkdir -p $BUILD_DIR
	mv -v $BLD_XML $BUILD_DIR
fi

#------------------------------------------------------------------#
# GET BOOK VERSION
#------------------------------------------------------------------#

bookversion=$(xmllint --xpath "/book/bookinfo/subtitle[1]/text()" $LFS_FULL_XML | sed -e 's/Version //' -e 's/-sys.*//g')
if [[ ! -z $bookversion ]]; then
        echo "LFS_VERS=$bookversion" >> $CURRENT_CONFIG
fi

