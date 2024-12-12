#!/bin/bash
####################################################################
# 
# list-createdir.sh
#
####################################################################


source <(echo $ASROOT)
export -f as_root

[[ -z $(ls -A $LISTDIRPATH/) ]] && echo -e "\n>>>>> Nothing to do. <<<<<\n" && exit 1

# list file
listfile=$LISTS_DIR/$LISTNAME.list
[[ -f $listfile ]] && echo -e "\n>>>>> List file $listfile exists. <<<<<\n" && exit 1

for FILE in $LISTDIRPATH/*;
do
	package=${FILE##*/}
	echo $package | as_root tee -a $listfile > /dev/null
done
