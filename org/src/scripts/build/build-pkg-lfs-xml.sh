#!/bin/bash
####################################################################
# 
# build-pkg-lfs-xml.sh
#
####################################################################

set -e


### PROCESS THE XML ###
xsltproc -o $PKG_LFS_XML $PKG_LFS_XSL $LFS_FULL_XML

