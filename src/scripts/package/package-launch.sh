#!/bin/bash
####################################################################
# 
# install-launch-install.sh
#
####################################################################


case $ACTION in

        PKGINSTALL) make package-install ;;
        PKGREMOVE) make package-remove ;;
        PKGUPGRADE) make package-upgrade ;;

esac

