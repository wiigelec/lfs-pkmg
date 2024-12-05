#!/bin/bash
####################################################################
# 
# action-launch-action.sh
#
####################################################################

### GET BUILD TYPE ###
source $ACTION_CURRENT_CONFIG

env=$(cat $ACTION_CURRENT_CONFIG | xargs)

case $BUILD_TYPE in

	LFS) make $env build-lfs ;;

esac
