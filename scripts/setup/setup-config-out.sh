#!/bin/bash
####################################################################
# 
# setup-config-out.sh
#
####################################################################

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$SETUP_CONFIG_OUT $MENU_CONFIG $SETUP_CONFIG_IN
