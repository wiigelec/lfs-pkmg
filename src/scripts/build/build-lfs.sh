#!/bin/bash
####################################################################
# 
# build-lfs.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# RUN MAKE
#------------------------------------------------------------------#

make -C $INSTALLROOT/jhalfs
