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

listfile=$LISTPATH/$LISTNAME

[[ -f $listfile ]] && echo -e "\n>>>>> $listfile exists. <<<<<\n" && exit 1

for a in $archives;
do
	echo $a | as_root tee -a $listfile

done

echo
