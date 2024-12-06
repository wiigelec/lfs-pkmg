#!/bin/bash
####################################################################
# 
# install-launch-install.sh
#
####################################################################


case $INSTALL_TYPE in

        PKG_IND) make install-individual ;;
        PKG_DEPS) make install-deps ;;
        PKG_LIST) make install-list ;;

esac

