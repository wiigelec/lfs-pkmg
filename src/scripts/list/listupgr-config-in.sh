#!/bin/bash
####################################################################
# 
# listupgr-config-in.sh
#
####################################################################

set -e


### WRITE CONFIG IN ###

$UTIL_LIST_CONFIG_IN_SH "$($UTIL_GET_MIRROR_VERSIONS_SH)" > $LISTUPGR_CONFIG_IN

