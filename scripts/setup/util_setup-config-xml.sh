#!/bin/bash
####################################################################
# 
# util_setup-config-xml.sh
#
####################################################################o


### GET REV ###

rev=$(grep CONFIG_SYSD=y $SETUP_CONFIG_OUT)
if [[ ! -z $rev ]]; then
	rev=systemd
else
	rev=sysv
fi


### GET BRANCH ###

branch=$(grep BRANCH_.*=y $SETUP_CONFIG_OUT | sed 's/CONFIG_BRANCH_\(.*\)=y/\1/')
if [[ -z $branch ]]; then echo "ERROR: Branch not configured in $SETUP_CONFIG_OUT!"; exit 1; fi

### OUTPUT XML ###
cat << EOF
<?xml version="1.0"?>

<config>
  <rev>$rev</rev>
  <branch>$branch</branch>
</config>

EOF
