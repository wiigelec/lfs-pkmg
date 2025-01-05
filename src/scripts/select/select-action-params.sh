#!/bin/bash
####################################################################
# 
# select-action-params.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/action-config-in.func


#------------------------------------------------------------------#
function cfg-val
{
	cfg=$1
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

echo "Initializing $CURRENT_CONFIG..."

cp $ACTION_CONFIG_OUT $CURRENT_CONFIG

sed -i '/^#/d' $CURRENT_CONFIG
sed -i 's/CONFIG_//g' $CURRENT_CONFIG
sed -i 's/=y//g' $CURRENT_CONFIG
sed -i 's/__/=/g' $CURRENT_CONFIG
sed -i 's/"//g' $CURRENT_CONFIG


### SET BUILD DIR ###

rev=$(grep "^CONFIG_REV" $ACTION_CONFIG_OUT | sed -e 's/.*__//' -e 's/=y//')
blfsbranch=$(grep "^CONFIG_BLFSBRANCH" $ACTION_CONFIG_OUT | sed -e 's/.*__//' -e 's/=y//')

[[ ! -z $blfsbranch ]] && branch=$blfsbranch && builddir=$BLD_DIR/$blfsbranch-$rev
[[ ! -z $builddir ]] && echo "BUILD_DIR=$builddir" >> $CURRENT_CONFIG


#------------------------------------------------------------------#
# CHECKOUT LPM BRANCH
#------------------------------------------------------------------#


lfsbranch=$(grep "^CONFIG_LFSBRANCH" $ACTION_CONFIG_OUT | sed -e 's/.*__//' -e 's/=y//')

[[ ! -z $lfsbranch ]] && lpmbranch=$lfsbranch
[[ ! -z $blfsbranch ]] && lpmbranch=$blfsbranch

[[ $lpmbranch == "trunk" ]] && lpmbranch="main"

if [[ ! -z $lpmbranch ]]; then
	set +e
	echo "Getting LPM branch..."
	git checkout $lpmbranch

	if [ $? -ne 0 ]; then echo -e "\n>>>>> Unsported (B)LFS version. <<<<<\n"; exit 1; fi

	git pull
fi

exit
