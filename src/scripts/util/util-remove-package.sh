#!/bin/bash
####################################################################
# 
# util-remove-package.sh
#
####################################################################

set -e

### INTIALIZE ###
remove=$1

# installed file list
ifl=$INSTALLROOT/$INSTALLED_DIR/$1

# output formatting
cnt=1
filecnt=$(wc -l < $ifl)
	

### FUNCTIONS ###
#------------------------------------------------------------------#
update_progress()
{
	percomp="( $(printf %3.0f "$((10**4 * $2/$3))e-2") % )"
	a="$1"
	b="+$2"
	message=$(printf "%-80s %6s" "$a" "$b")
	message=${message// /.}
	message=${message//+/ }
	d="$3"
	message=$(printf "%-80s / %-6s %9s" "$message" "$d" "$percomp")
	echo -ne "$message\033[0K\r"
}
#------------------------------------------------------------------#


### ITERATE INSTALLED FILE LIST ###

while IFS= read -r line;
do
	# update progress
	[ $((cnt%250)) -eq 0 ] || [ $cnt -eq $filecnt ] || [ $cnt -eq 1 ] && update_progress $remove $cnt $filecnt
	((cnt++))

	# parse symlinks
	deleteme=${line/ ->*/}

	# lib
	[[ $deleteme == "/lib/"* ]] && deleteme=/usr$deleteme

	# check installed in other package
	#echo "grep -r --exclude ${ifl##*/} ^$deleteme$ ${INSTALLROOT}$INSTALLED_DIR"
	[[ ! -z $(grep -r --exclude ${ifl##*/} ^$deleteme$ ${INSTALLROOT}$INSTALLED_DIR 2>/dev/null) ]] && continue

	rm -d "${INSTALLROOT}$deleteme" 2> /dev/null || true
	#rm -d "${INSTALLROOT}$deleteme" || true

done < <(tac $ifl)


### CLEANUP ###

echo

rm $ifl

