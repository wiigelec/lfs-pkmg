#!/bin/bash
####################################################################
# 
# list-create-dir.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# GET PACKAGES
#------------------------------------------------------------------#

archives=$(ls $LISTDIRPATH)

[[ -z $archives ]] && echo -e "\n>>>>> Nothing to do. <<<<<\n" && exit 1


#------------------------------------------------------------------#
# WRITE LIST FILE
#------------------------------------------------------------------#

listfile=$LISTFILE
listpath=${listfile%/*}

[[ -f $listfile ]] && echo -e "\n>>>>> $listfile exists. <<<<<\n" && exit 1
[[ ! -d $listpath ]] && as_root mkdir -p $listpath

for a in $archives;
do
	echo $a | as_root tee -a $listfile

done

### SORT UNIQUE ###
list="$(cat $listfile | sort -u)"
as_root sed -i '/.*/d' $listfile
echo "$list" | as_root tee $listfile > /dev/null


echo
