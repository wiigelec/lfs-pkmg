#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###

KCONFIG_CONFIG=$BL_CONFIG_OUT $MENU_CONFIG $BL_CONFIG_IN
