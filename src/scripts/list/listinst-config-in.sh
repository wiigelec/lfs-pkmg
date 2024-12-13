#!/bin/bash
####################################################################
# 
# listinst-config-in.sh
#
####################################################################


### GET VERION DIRS ###

if [[ $MIRRORPATH == "http://"* || $MIRRORPATH == "https://"* ]]; then

	versionlist=$(curl --silent $ARCHIVEPATH | sort)
else

	versionlist=$(ls ${MIRRORPATH} | sort)
fi

### ITERATE VERSIONS ###

echo "menu \"Select List\"" > $LISTINST_CONFIG_IN 

for vl in $versionlist; do

	listdir=$MIRRORPATH/$vl/lists
	[[ ! -d $listdir ]] && continue 
	[[ -z $(ls $listdir) ]] && continue 

	echo " menu   \"$vl\"" >> $LISTINST_CONFIG_IN 

	### GET LISTS ###
	for lf in $listdir/*; do

		list=${lf##*/}
		echo "   config  $lf" >> $LISTINST_CONFIG_IN 
		echo "     bool  \"$list\"" >> $LISTINST_CONFIG_IN 

	done

	echo "  endmenu" >> $LISTINST_CONFIG_IN 

done

echo "endmenu" >> $LISTINST_CONFIG_IN 

