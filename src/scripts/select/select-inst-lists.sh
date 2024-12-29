#!/bin/bash
####################################################################
# 
# select-inst-lists.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 


#------------------------------------------------------------------#
# GET INSTALLED LISTS
#------------------------------------------------------------------#

installedlist=$(ls ${INSTALLROOT}$LPM_LISTS | sort)

if [[ -z $installedlist ]]; then
        echo
        echo ">>>>> Nothing to be done. <<<<<"
        echo
        exit 1
fi

[[ -f $INSTLISTS_CONFIG_IN ]] && rm $INSTLISTS_CONFIG_IN

for i in $installedlist; do

        echo "config    ${INSTALLROOT}$LPM_LISTS/$i" >> $INSTLISTS_CONFIG_IN
        echo "  bool \"$i\"" >> $INSTLISTS_CONFIG_IN

done


#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$INSTLISTS_CONFIG_OUT $MENU_CONFIG $INSTLISTS_CONFIG_IN


#------------------------------------------------------------------#
# WRITE PACKAGE LIST
#------------------------------------------------------------------#

grep CONFIG_.*=y $INSTLISTS_CONFIG_OUT | sed -e 's/CONFIG_//g' -e 's/=y//g' > $REMV_LISTS_LIST
