#!/bin/bash
####################################################################
# 
# util-list-config-in.sh
#
####################################################################

versionlist=$1


### GET MIRROR TYPE ###
file="false"
server="false"
mirrortype=${versionlist%% *}
[[ $mirrortype == "FILE" ]] && file="true"
[[ $mirrortype == "SERVER" ]] && server="true"
versionlist=${versionlist#* }


### ITERATE VERSIONS ###

echo "menu \"Select List\""
for vl in $versionlist; do
        echo " menu   \"$vl\""

        listdir=""
                
        path=$MIRRORPATH/$vl/lists/

        ### GET FILE LISTS ###
        if [[ $file == "true" ]]; then
                [[ -d $path ]] && listdir=${path}$(ls $path)
        fi

        ## GET HTTP LISTS ###
        if [[ $server == "true" ]]; then
                url=$MIRRORPATH/$vl/lists/
                listdir="$listdir ${url}$(curl --silent $path | sed '/href/!d' | sed 's/.*href=\(.*\)<\/a.*/\1/g' | sed 's/.*>\(.*\)$/\1/g')"
                listdir=${listdir//:/..}
        fi

        ### WRITE CONFIG ###
        for lf in $listdir; do

                list=${lf##*/}
                [[ -z $list ]] && continue
                echo "   config  $lf"
                echo "     bool  \"$list\""

        done

        echo "  endmenu"
done

echo "endmenu"

