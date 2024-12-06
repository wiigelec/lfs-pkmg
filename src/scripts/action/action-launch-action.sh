#!/bin/bash
####################################################################
# 
# action-launch-action.sh
#
####################################################################


source $ACTION_CURRENT_CONFIG

env=$(cat $ACTION_CURRENT_CONFIG | xargs)

make $env $ACTION
