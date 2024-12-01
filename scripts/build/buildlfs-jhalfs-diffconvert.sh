#!/bin/bash
####################################################################
# 
# buildlfs-jhalfs-diffconvert.sh
#
####################################################################

### DIFFLOG CONVERT ###
echo
echo "Converting lfs jhalfs scripts for difflog..."
echo

diffdir=${DIFFLOG_DIR##$LFS}

for FILE in $JHALFS_MNT/lfs-commands/chapter08/*;
do
	### GET PACKAGE NAME AND VERSION ##
	echo "Converting $FILE..."

	package=${FILE##*\/}
	package=${package#*-}

	# version
	version=$(grep VERSION= $FILE | sed 's/.*=//')

	# diff logs
	difflog1="$diffdir/$package"-"$version".difflog1
	difflog2="$diffdir/$package"-"$version".difflog2

	# insert diff log
	sed -i "2 i find / -xdev > $difflog1" $FILE
	sed -i "2 i touch /sources/timestamp-marker" $FILE

	last_line=$(wc -l < $FILE)
	sed -i "$last_line i find / -xdev > $difflog2" $FILE
	last_line=$(wc -l < $FILE)
	sed -i "$last_line i find / -xdev -newer /sources/timestamp-marker >> $difflog2" $FILE
	last_line=$(wc -l < $FILE)
	sed -i "$last_line i rm /sources/timestamp-marker" $FILE
	last_line=$(wc -l < $FILE)

done

touch $JHALFS_DIFFCONVERT


### INSTALL DIFFLOG DIR ###
sudo mkdir -p $DIFFLOG_DIR
