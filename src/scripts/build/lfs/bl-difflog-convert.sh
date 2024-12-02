#!/bin/bash
####################################################################
# 
# bl-difflog-convert.sh
#
####################################################################

#------------------------------------------------------------------#
# DIFFLOG CONVERT

diffdir=$DIFFLOG_DIR

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

### INITIALIZE DIFFLOG DIR ###
sudo mkdir -pv $LFS/$DIFFLOG

touch $DIFFLOG_CONVERT
