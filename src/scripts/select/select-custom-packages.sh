#!/bin/bash
####################################################################
# 
# select-custom-packages.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# GET DIRECTORY LISTINGS
#------------------------------------------------------------------#

### GROUP ###

[[ -d $CUSTOM_GROUP ]] && groups=$(ls $CUSTOM_GROUP)

cat > $CSTMPKGS_CONFIG_IN << EOF

menuconfig MENU_GROUP
bool "group"
default n

if MENU_GROUP
EOF

for grp in $groups; 
do

	echo "config GROUP_$grp" >> $CSTMPKGS_CONFIG_IN
	echo "  bool \"$grp\"" >> $CSTMPKGS_CONFIG_IN
	echo "  default n" >> $CSTMPKGS_CONFIG_IN
done

echo "endif" >> $CSTMPKGS_CONFIG_IN


### BUILD ###

[[ -d $CUSTOM_BUILD ]] && builds=$(ls $CUSTOM_BUILD)

cat >> $CSTMPKGS_CONFIG_IN << EOF

menuconfig MENU_BUILD
bool "build"
default n

if MENU_BUILD
EOF

for bld in $builds; 
do

	echo "config BUILD_$bld" >> $CSTMPKGS_CONFIG_IN
	echo "  bool \"$bld\"" >> $CSTMPKGS_CONFIG_IN
	echo "  default n" >> $CSTMPKGS_CONFIG_IN
done

echo "endif" >> $CSTMPKGS_CONFIG_IN

#------------------------------------------------------------------#
# LAUNCH MENUCONFIG
#------------------------------------------------------------------#

KCONFIG_CONFIG=$CSTMPKGS_CONFIG_OUT $MENU_CONFIG $CSTMPKGS_CONFIG_IN


#------------------------------------------------------------------#
# WRITE OUTPUT LIST
#------------------------------------------------------------------#

### GROUPS TO BLFS_PKGS_LIST

[[ -f $BLFS_PKGS_LIST ]] && rm $BLFS_PKGS_LIST
touch $BLFS_PKGS_LIST
cfggroups=$(grep ^CONFIG_GROUP $CSTMPKGS_CONFIG_OUT || true)
for cg in $cfggroups;
do
	cg=${cg##CONFIG_GROUP_}
	cg=${cg%=y}
	cat $CUSTOM_GROUP/$cg >> $BLFS_PKGS_LIST
done


### BUILDS TO CSTM_BLDS_LIST

[[ -f $CSTM_BLDS_LIST ]] && rm $CSTM_BLDS_LIST
touch $CSTM_BLDS_LIST
cfgbuilds=$(grep ^CONFIG_BUILD $CSTMPKGS_CONFIG_OUT || true)
for cf in $cfgbuilds;
do
	cf=${cf##CONFIG_BUILD_}
	cf=${cf%=y}
	echo $cf >> $CSTM_BLDS_LIST
done



