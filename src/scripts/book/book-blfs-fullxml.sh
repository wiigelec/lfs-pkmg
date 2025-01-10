#!/bin/bash
####################################################################
# 
# book-blfs-fullxml.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# GENERATE BLFS FULL XML
#------------------------------------------------------------------#
	
[[ -z $BUILD_DIR ]] && echo -e "\n>>>>> BUILD_DIR undefined. <<<<<\n" && exit 1

if [[ ! -f $BLFS_FULL_XML ]]; then

	### GET BRANCH ###

	branch=${BLFSBRANCH##*=}
	pushd $BLFS_GIT_DIR  > /dev/null
	git pull
	git checkout $branch
	popd > /dev/null


	### SET REV ###
	
	rev=sysv
	[[ $REV == "SYSD" ]] && rev=systemd


	#### VALIDATE ###

	mkdir -p $BLD_XML
	make -C $BLFS_GIT_DIR RENDERTMP=$BLD_XML REV=$rev validate
	if [[ "$rev" == "systemd" ]]; then mv -v $BLD_XML/blfs-systemd-full.xml $BLFS_FULL_XML_NV; fi


	### CREATE BUILD DIR ###

	[[ ! -d $BUILD_DIR ]] && mkdir -p $BUILD_DIR
	mv -v $BLD_XML $BUILD_DIR
fi


#------------------------------------------------------------------#
# GET BOOK VERSION
#------------------------------------------------------------------#

bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
if [[ ! -z $bookversion ]]; then
        echo "BOOK_VERS=$bookversion" >> $CURRENT_CONFIG
fi
