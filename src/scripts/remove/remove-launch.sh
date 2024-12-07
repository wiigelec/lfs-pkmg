#!/bin/bash
####################################################################
# 
# remove-launch.sh
#
####################################################################


case $INSTALL_TYPE in

        PKG_IND) make remove-individual ;;
        PKG_DEPS) make install-deps ;;
        PKG_LIST) make install-list ;;

esac

