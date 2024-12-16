#!/bin/bash
####################################################################
# 
# bb-build-list.sh
#
####################################################################

set -e

### INITIALIZE ###

[[ ! -d $BUILD_DIR/config ]] && mkdir -p $BUILD_DIR/config


### WRITE PACKAGES ###

echo "wget" > $BB_BUILD_LIST
echo "sudo" >> $BB_BUILD_LIST
echo "git" >> $BB_BUILD_LIST
echo "libxml2" >> $BB_BUILD_LIST
echo "libxslt" >> $BB_BUILD_LIST
echo "DocBook" >> $BB_BUILD_LIST
echo "docbook-xsl" >> $BB_BUILD_LIST

