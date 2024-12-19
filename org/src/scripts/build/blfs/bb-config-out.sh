#!/bin/bash
####################################################################
# 
# listinst-config-out.sh
#
####################################################################

set -e

### RUN MENUCONFIG ###

KCONFIG_CONFIG=$BB_CONFIG_OUT $MENU_CONFIG $BB_CONFIG_IN

