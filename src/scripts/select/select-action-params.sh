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

echo "Initializing $CURRENT_CONFIG..."

rev=$(cfg-val "REV")
lfsbranch=$(cfg-val "LFSBRANCH")
blfsbranch=$(cfg-val "BLFSBRANCH")
installroot=$(cfg-val "INSTALLROOT")

[[ ! -z $lfsbranch ]] && branch=$lfsbranch
[[ ! -z $blfsbranch ]] && branch=$blfsbranch && builddir=$BLD_DIR/$blfsbranch-$rev

[[ -f $CURRENT_CONFIG ]] && rm $CURRENT_CONFIG
	
cp $ACTION_CONFIG_OUT $CURRENT_CONFIG

sed -i '/^#/d' $CURRENT_CONFIG
sed -i 's/CONFIG_//g' $CURRENT_CONFIG
sed -i 's/=y//g' $CURRENT_CONFIG
sed -i 's/__/=/g' $CURRENT_CONFIG
sed -i 's/"//g' $CURRENT_CONFIG


### CURRENT CONFIG MAKEFILE ###

cp $CURRENT_CONFIG_MAKE.org $CURRENT_CONFIG_MAKE

# rev
if [[ ! -z $rev ]]; then 
	sed -i "s/\(REV = \).*/\1$rev/" $CURRENT_CONFIG_MAKE; 
fi

# branch
if [[ ! -z $branch ]]; then 
	sed -i "s/\(BRANCH = \).*/\1$branch/" $CURRENT_CONFIG_MAKE; 
fi

# build dir
if [[ ! -z $builddir ]]; then
	builddir=${builddir//\//\\/}
	sed -i "s/\(BUILD_DIR = \).*/\1$builddir/" $CURRENT_CONFIG_MAKE; 
fi

# installroot
if [[ ! -z $installroot ]]; then 
	installroot=${installroot##CONFIG_}
	installroot=${installroot##INSTALLROOT=}
	installroot=${installroot//\"/}
	installroot=${installroot//\//\\/}
	sed -i "s/\(INSTALLROOT = \).*/\1$installroot/" $CURRENT_CONFIG_MAKE; 
fi

