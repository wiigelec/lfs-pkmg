#!/bin/bash
####################################################################
# 
# list-launch.sh
#
####################################################################


case $ACTION in

        LISTDIR) make list-create-dir ;;
        LISTDEPS) BUILD_DIR=$BUILD_DIR/$BLFSBRANCH-$REV make list-create-deps ;;
        LISTINSTALL) make list-install ;;
        LISTREMOVE) make list-remove ;;
        LISTUPGRADE) make list-upgrade ;;

esac

