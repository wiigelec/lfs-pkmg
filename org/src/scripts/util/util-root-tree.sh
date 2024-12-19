#!/bin/bash
####################################################################
# 
# util-root-tree.sh
#
####################################################################

set -e

### INITIALIZE ###
FILE_IN=$1
FILE_OUT=$2
> $FILE_OUT


### PROCESS DEPENDENCIES ###

packages=$(cat $FILE_IN)
for p in $packages
do
	treefile=$TREE_DIR/${p}.tree
	while IFS= read -r treeline;
       	do
		echo -ne "$treeline\033[0K\r"

		# check version
		# handle pass1
		pass1=""
		[[ $treeline =~ "-pass1" ]] && pass1=${treeline} && treeline=${treeline%-pass1}
		iv=$(xmllint --xpath "//package[id='$treeline']/installed/text()" $PKG_BLFS_XML 2>/dev/null) || true
		bv=$(xmllint --xpath "//package[id='$treeline']/version/text()" $PKG_BLFS_XML 2>/dev/null)

		if [[ "$iv" == "$bv" ]]; then continue; fi


		[[ ! -z $pass1 ]] && treeline=$pass1
		[[ -z "$(grep -x $treeline $FILE_OUT)" ]] && echo $treeline >> $FILE_OUT
       	done < $treefile

done

