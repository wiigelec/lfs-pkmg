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

echo "menu \"Select Packages\"" > $PKGINST_CONFIG_IN 

for vl in $versionlist; do

	pkgdir=$MIRRORPATH/$vl/packages
	[[ ! -d $pkgdir ]] && continue 
	[[ -z $(ls $pkgdir) ]] && continue 

	echo " menu   \"$vl\"" >> $PKGINST_CONFIG_IN 

	### GET PACKAGES ###
	for pf in $pkgdir/*; do

		pkg=${pf##*/}
		echo "   config  $pf" >> $PKGINST_CONFIG_IN 
		echo "     bool  \"$pkg\"" >> $PKGINST_CONFIG_IN 

	done

	echo "  endmenu" >> $PKGINST_CONFIG_IN 

done

echo "endmenu" >> $PKGINST_CONFIG_IN 

