#!/bin/bash
####################################################################
# 
# list-create-deps.sh
#
####################################################################

set -e
source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/setup-deps.func


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# SETUP DEPS
#------------------------------------------------------------------#

> $WORK_PKGS_TREE
setup-deps


#------------------------------------------------------------------#
# WRITE LIST FILE
#------------------------------------------------------------------#

listfile=$LISTPATH/$LISTNAME
[[ -f $listfile ]] && echo -e "\n>>>>> $listfile exists. <<<<<\n" && exit 1

### GET PACKAGE INFO ###
echo "Getting package info..."
echo
bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
for p in $(cat $WORK_PKGS_TREE);
do
	pass1=""
	[[ $p == *"-pass1" ]] && pass1=$p && p=${p%-pass1} 
	version=$(xmllint --xpath "//package[id='$p']/version/text()" $BLFS_PKGLIST_XML 2>/dev/null)

	[[ ! -z $pass1 ]] && p=$pass1
	write="$p--$version--$(uname -m)--blfs-${bookversion}.txz"
	echo $write | as_root tee -a $listfile
done
echo

