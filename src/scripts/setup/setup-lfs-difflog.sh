#!/bin/bash
####################################################################
# 
# setup-lfs-difflog.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


JHALFS_CH08=$INSTALLROOT/jhalfs/lfs-commands/chapter08

#------------------------------------------------------------------#
# CONVERT CHO08
#------------------------------------------------------------------#

diffdir=$DIFFLOG_DIR

for FILE in $JHALFS_CH08/*;
do
        ### GET PACKAGE NAME AND VERSION ##
        echo -ne "Converting $FILE...\033[0K\r"

        package=${FILE##*\/}
        package=${package#*-}

	### SPECIAL PACKAGE HANDLING ###

	# DBUS
	[[ $package == "dbus" ]] && package=$package-base
	
	# PYTHON
	[[ $package == "Python" ]] && package=$package-base
	
	# SHADOW
	[[ $package == "shadow" ]] && package=$package-base

	# SYSTEMD
	[[ $package == "systemd" ]] && package=$package-base
	
	# CLEANUP
	[[ $package == "cleanup" ]] && continue

	# STRIPPING
	[[ $package == "stripping" ]] && continue

        # version
        version=$(grep VERSION= $FILE | sed 's/.*=//')

        # diff logs
        difflog1="$diffdir/$package"--"$version".difflog1
        difflog2="$diffdir/$package"--"$version".difflog2

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

echo -ne "\033[0K\r"


#------------------------------------------------------------------#
# INITIALIZE DIFFLOG
#------------------------------------------------------------------#

as_root mkdir -pv $INSTALLROOT/$DIFFLOG_DIR

