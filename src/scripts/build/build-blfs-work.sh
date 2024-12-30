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

# TIMER SCRIPT
$TIMER_SCRIPT MGR $PPID &
$TIMER_SCRIPT BLD $PPID &

export LPM_DIFFLOG=$LPM_DIFFLOG

make -C $BUILD_WORK

