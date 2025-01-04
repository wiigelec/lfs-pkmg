#!/bin/bash
####################################################################
# 
# list-create-deps.sh
#
####################################################################

set -e
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
for p in $(cat $WORK_PKGS_TREE);
do
	# SKIP PASS1
	[[ $p == *"-pass1" ]] && pass1=$p && p=${p%-pass1} 

	# GET PACKAGE VERSION
	version=$(xmllint --xpath "//package[id='$p']/version/text()" $BLFS_PKGLIST_XML 2>/dev/null)

	# SETUP PACKAGE NAME
	write="$p--$version--$(uname -m)--blfs-${BOOK_VERS}-$REV.txz"
	echo $write | as_root tee -a $listfile
done

### SORT UNIQUE ###
list=$(cat $listfile | sort -u)
as_root sed -i '/.*/d' $listfile
for l in $list;
do
	echo $l | as_root tee -a $listfile > /dev/null
done


echo

