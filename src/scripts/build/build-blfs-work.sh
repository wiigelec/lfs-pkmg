#!/bin/bash
####################################################################
# 
# build-blfs-work.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# RUN MAKE
#------------------------------------------------------------------#

export BUILD_DIR="$BUILD_DIR"
export WORK_DIR=${BUILD_DIR}$WORK_DIR

# TIMER SCRIPT
$TIMER_SCRIPT MGR $PPID &
$TIMER_SCRIPT BLD $PPID &

make -C $WORK_DIR

