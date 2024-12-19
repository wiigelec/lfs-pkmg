#!/bin/bash
####################################################################
# 
# pkgupgr-config-in.sh
#
####################################################################


set -e


### WRITE CONFIG IN ###

$UTIL_LPCONFIG_IN_SH "PACKAGE $($UTIL_GET_MIRROR_VERSIONS_SH)" > $PKGUPGR_CONFIG_IN

