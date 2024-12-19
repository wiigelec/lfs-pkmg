#!/bin/bash
####################################################################
# 
# bl-config-out.sh
#
####################################################################


### SET CURRENT CONFIG ###

cp $ACTION_CONFIG_OUT $ACTION_CURRENT_CONFIG

# clean file
sed -i '/^#/d' $ACTION_CURRENT_CONFIG
sed -i 's/CONFIG_//g' $ACTION_CURRENT_CONFIG
sed -i 's/=y//g' $ACTION_CURRENT_CONFIG
sed -i 's/__/=/g' $ACTION_CURRENT_CONFIG
sed -i 's/"//g' $ACTION_CURRENT_CONFIG

