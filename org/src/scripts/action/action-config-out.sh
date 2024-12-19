#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### RUN MENUCONFIG ###



KCONFIG_CONFIG=$ACTION_CONFIG_OUT $MENU_CONFIG $ACTION_CONFIG_IN

