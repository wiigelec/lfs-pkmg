#!/bin/bash
####################################################################
# 
# listinst-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$LISTDEPS_CONFIG_OUT $MENU_CONFIG $LISTDEPS_CONFIG_IN

