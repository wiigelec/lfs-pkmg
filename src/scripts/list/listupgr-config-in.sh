#!/bin/bash
####################################################################
# 
# listupgr-config-in.sh
#
####################################################################

set -e


### WRITE CONFIG IN ###

$UTIL_CONFIG_IN_SH "LIST $($UTIL_GET_MIRROR_VERSIONS_SH)" > $LISTUPGR_CONFIG_IN

