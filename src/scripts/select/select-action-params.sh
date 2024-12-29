#!/bin/bash
####################################################################
# 
# select-action-params.sh
#
####################################################################

set -e
[[ -f $CURRENT_CONFIG ]] && source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/action-config-in.func


#------------------------------------------------------------------#
function cfg-val
{
	cfg=$1
	grep "^CONFIG_$cfg" $ACTION_CONFIG_OUT | sed -e 's/.*__//' -e 's/=y//'
}
#------------------------------------------------------------------#


#------------------------------------------------------------------#
# GENERATE CONFIG IN
#------------------------------------------------------------------#

mkdir -p $BLD_CONFIG
action-config-in > $ACTION_CONFIG_IN


#------------------------------------------------------------------#
# RUN MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$ACTION_CONFIG_OUT $MENU_CONFIG $ACTION_CONFIG_IN


#------------------------------------------------------------------#
# FORMAT CURRENT CONFIG
#------------------------------------------------------------------#

rev=$(cfg-val "REV")
blfsbranch=$(cfg-val "BLFSBRANCH")
[[ ! -z $blfsbranch ]] && builddir=$BLD_DIR/$blfsbranch-$rev 

[[ -f $CURRENT_CONFIG ]] && rm $CURRENT_CONFIG
	
echo "Initializing $CURRENT_CONFIG..."

cp $ACTION_CONFIG_OUT $CURRENT_CONFIG

sed -i '/^#/d' $CURRENT_CONFIG
sed -i 's/CONFIG_//g' $CURRENT_CONFIG
sed -i 's/=y//g' $CURRENT_CONFIG
sed -i 's/__/=/g' $CURRENT_CONFIG
sed -i 's/"//g' $CURRENT_CONFIG

### GET BOOKVERSION ###
[[ ! -z $blfsbranch ]] && echo "BOOK_VERS=$blfsbranch" >> $CURRENT_CONFIG
if [[ ! -z $builddir ]]; then echo "BUILD_DIR=$builddir" >> $CURRENT_CONFIG; fi

