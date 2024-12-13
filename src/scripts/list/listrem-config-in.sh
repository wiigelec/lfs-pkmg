#!/bin/bash
####################################################################
# 
# install-config-in.sh
#
####################################################################


lists=$(ls $INSTALLROOT/$LISTS_DIR | sort)

if [[ -z $lists ]]; then
	echo
	echo ">>>>> Nothing to be done. <<<<<"
	echo
	exit 1
fi

[[ -f $LISTREM_CONFIG_IN ]] && rm $LISTREM_CONFIG_IN

for i in $lists; do

	echo "config	$i" >> $LISTREM_CONFIG_IN
	echo "	bool \"$i\"" >> $LISTREM_CONFIG_IN

done

