#!/bin/bash
####################################################################
# 
# build-pretend.sh
#
####################################################################

set -e

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# INITIALIZE PRETEND
#------------------------------------------------------------------#

[[ ! -d $LPM_PRETEND ]] && as_root mkdir -p $LPM_PRETEND

echo "BUILD_PRETEND=true" >> $CURRENT_CONFIG


#------------------------------------------------------------------#
# CLEAR BUILD SCRIPTS
#------------------------------------------------------------------#

echo
echo "Clearing build commands..."
echo

bs=$(ls $WORK_SCRIPTS)

for f in $bs;
do
	echo $f
	ff=$WORK_SCRIPTS/$f

	### REMOVE DOWNLOAD ###

	line1=$(grep -n "# DOWNLOADS" $ff)
	line1=${line1%%:*}

	line2=$(grep -n "# BUILD COMMANDS" $ff)
	line2=${line2%%:*}

	sed -i "$(($line1+3)),$(($line2-3))d" $ff
	sed -i "$(($line1+3))G" $ff


	### REPLACE BUILD COMMANDS ###

	line1=$(grep -n "### CONFIGURE MAKE INSTALL ###" $ff)
	line1=${line1%%:*}

	line2=$(grep -n "### END CONFIGURE MAKE INSTALL ###" $ff)
	line2=${line2%%:*}
	
	destdir=$(grep ^DESTDIR= $ff)
	echo $detsdir
	[[ ! -z $destdir ]] && LPM_PRETEND="\$DESTDIR$LPM_PRETEND"

	sed -i "$(($line1+2)),$(($line2-2))d" $ff
	if [[ ! -z $destdir ]]; then
		sed -i "$(($line1+2)) i sudo mkdir -p $LPM_PRETEND" $ff
		((line1++))
	fi
	sed -i "$(($line1+2)) i sudo touch $LPM_PRETEND/$f" $ff
done
