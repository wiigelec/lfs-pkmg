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

listfile=$LISTFILE
listdir=${listfile%/*}
[[ -f $listfile ]] && echo -e "\n>>>>> $listfile exists. <<<<<\n" && exit 1
[[ ! -d $listdir ]] && as_root mkdir -p $listdir

### GET PACKAGE INFO ###
echo "Getting package info..."
echo
bookversion=$(xmllint --xpath "/book/bookinfo/subtitle/text()" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./')
for p in $(cat $WORK_PKGS_TREE);
do
	# SKIP PASS1
	[[ $p == *"-pass1" ]] && pass1=$p && p=${p%-pass1} 

	# GET PACKAGE VERSION
	version=$(xmllint --xpath "//package[id='$p']/version/text()" $BLFS_PKGLIST_XML 2>/dev/null)

	# SETUP PACKAGE NAME
	write="$p--$version--$(uname -m)--blfs-${bookversion}.txz"
	echo $write | as_root tee -a $listfile
done

### SORT UNIQUE ###
list=$(cat $listfile | sort -u)
as_root sed -i '/.*/d' $listfile
for l in $list;
do
	echo $l | as_root tee -a $listfile
done


echo

