#!/bin/bash
####################################################################
# 
# action-launch.sh
#
####################################################################


source $ACTION_CURRENT_CONFIG

env=$(cat $ACTION_CURRENT_CONFIG | xargs)

make $env $ACTIONGROUP
