#!/bin/bash
####################################################################
# 
# list-createdir.sh
#
####################################################################


source <(echo $ASROOT)
export -f as_root

[[ -z $(ls -A $LISTDIRPATH/) ]] && echo -e "\n>>>>> Nothing to do. <<<<<\n" && exit 1

listdir=${LISTNAME%/*}/
[[ ! -d $listdir ]] && as_root mkdir -p $listdir

# list file
[[ -f $LISTNAME ]] && echo -e "\n>>>>> List file $LISTNAME exists. <<<<<\n" && exit 1

for FILE in $LISTDIRPATH/*;
do
	package=${FILE##*/}
	echo $package | as_root tee -a $LISTNAME > /dev/null
done
