#!/bin/bash
####################################################################
# 
# util-remove-package.sh
#
####################################################################

set -e

### INTIALIZE ###
remove=$1

# tempdir
tmpdir=$INSTALLROOT/tmp/lfspkmg$RANDOM
mkdir -p $tmpdir

# installed file list
installed_dir=$INSTALLROOT/$INSTALLED_DIR
ifl=$installed_dir/$remove
lfi=$tmpdir/lfi
tac $ifl > $lfi # reverse for proper dir removal

# output formatting
cnt=1
filecnt=$(wc -l < $lfi)
toggle="false"
	

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

#------------------------------------------------------------------#
delete_file() {

	rm "$1" 2> /dev/null || true
}
#------------------------------------------------------------------#

#------------------------------------------------------------------#
delete_dir() {

	rm -d "$1" 2> /dev/null || true
}
#------------------------------------------------------------------#

#------------------------------------------------------------------#
delete_wrap() {

	local deleteme=$1

	# update progress
	update_progress $remove $cnt $filecnt
	if [[ $toggle == "true" ]]; then ((cnt++)); toggle="false";
	else toggle="true"; fi

	# parse symlinks
	deleteme=${deleteme/ ->*/}

	# check dir
	[[ -d $deleteme && $2 == "FILE" ]] && return

	# check installed in other package
	ex=${ifl##*/}
	[[ ! -z $(grep -r --exclude $ex "$remove" $installed_dir 2>/dev/null) ]] && return

	# delete from install root
	deleteme=${deleteme#/}
	deleteme=$INSTALLROOT/$deleteme

	if [[ $2 == "FILE" ]]; then delete_file $deleteme; fi
	if [[ $2 == "DIR" ]]; then delete_dir $deleteme; fi
}
#------------------------------------------------------------------#


### ITERATE INSTALLED FILE LIST ###


### PASS 1  DELETE FILES ###
while IFS= read -r line;
do
	delete_wrap $line "FILE"

done < $lfi


### PASS 2 DELETE EMPTY DIRS ###
while IFS= read -r line;
do
	delete_wrap $line "DIR"

done < $lfi
        

### CLEANUP ###

echo

rm $lfi
rm $ifl

rm -rf $tmpdir

