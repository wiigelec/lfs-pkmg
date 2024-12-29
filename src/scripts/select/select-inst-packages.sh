#!/bin/bash
####################################################################
# 
# select-inst-packages.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 


#------------------------------------------------------------------#
# GET INSTALLED PACKAGES
#------------------------------------------------------------------#

installedlist=$(ls ${INSTALLROOT}$LPM_INSTALLED | sort)

if [[ -z $installedlist ]]; then
        echo
        echo ">>>>> Nothing to be done. <<<<<"
        echo
        exit 1
fi

[[ -f $INSTPKGS_CONFIG_IN ]] && rm $INSTPKGS_CONFIG_IN

for i in $installedlist; do

        echo "config    ${INSTALLROOT}$LPM_INSTALLED/$i" >> $INSTPKGS_CONFIG_IN
        echo "  bool \"$i\"" >> $INSTPKGS_CONFIG_IN

done


#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$INSTPKGS_CONFIG_OUT $MENU_CONFIG $INSTPKGS_CONFIG_IN


#------------------------------------------------------------------#
# WRITE PACKAGE LIST
#------------------------------------------------------------------#

grep CONFIG_.*=y $INSTPKGS_CONFIG_OUT | sed -e 's/CONFIG_//g' -e 's/=y//g' > $REMV_PKGS_LIST
