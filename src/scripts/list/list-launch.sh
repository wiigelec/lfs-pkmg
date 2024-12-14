#!/bin/bash
####################################################################
# 
# list-launch.sh
#
####################################################################


case $ACTION in

        LISTDIR) make list-create-dir ;;
        LISTINSTALL) make list-install ;;
        LISTREMOVE) make list-remove ;;
        LISTUPGRADE) make list-upgrade ;;

esac

