#!/bin/bash
####################################################################
# 
# build-launch.sh
#
####################################################################


### SET BUILD DIR ###
BUILD_DIR=$BUILD_DIR/$BLFSBRANCH-$REV


### RUN BUILD ###

case $ACTION in

	BUILDLFS) make build-lfs ;;
	BUILDBLFS) make build-blfs ;;
	BUILDBOOTSTRAP) make build-bootstrap ;;

esac
