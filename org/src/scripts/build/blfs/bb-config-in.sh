#!/bin/bash
####################################################################
# 
# bb-config-in.sh
#
####################################################################

set -e

### PROCESS XML ###

xsltproc -o $BB_CONFIG_IN $BB_CONFIG_IN_XSL $PKG_BLFS_XML

