#!/bin/bash
####################################################################
# 
# util-config-in.sh
#
####################################################################


cmdline=$1

### GET SELECTION ###
selection=${cmdline%% *}
cmdline=${cmdline#* }


### GET MIRROR TYPE ###
file="false"
server="false"
mirrortype=${cmdline%% *}
[[ $mirrortype == "FILE" ]] && file="true"
[[ $mirrortype == "SERVER" ]] && server="true"
cmdline=${cmdline#* }


### ITERATE VERSIONS ###

versions=$cmdline

# select string
selectstring="<UNKNOWN>"
[[ $selection == "PACKAGE" ]] && selectstring="Select packages"
[[ $selection == "LIST" ]] && selectstring="Select lists"

echo "menu \"$selectstring\""
for v in $versions; do
        echo " menu   \"$v\""

        outlist=""
                
	# set path
        [[ $selection == "PACKAGE" ]] && path=$MIRRORPATH/$v/packages/
        [[ $selection == "LIST" ]] && path=$MIRRORPATH/$v/lists/

        ### FROM FILE ###
        if [[ $file == "true" ]]; then
                [[ -d $path ]] && outlist=$(ls $path)
        fi

        ## FROM SERVER ###
        if [[ $server == "true" ]]; then
                outlist="$(curl --silent $path | sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)$/\1/g')"
                path=${path//:/..}
        fi

        ### WRITE CONFIG ###
        for o in $outlist; do

                name=${o##*/}
                [[ -z $name ]] && continue
                echo "   config  ${path}$o"
                echo "     bool  \"$name\""

        done

        echo "  endmenu"
done

echo "endmenu"

