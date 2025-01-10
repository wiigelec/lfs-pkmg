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

### META ###

[[ -d $CUSTOM_META ]] && metas=$(ls $CUSTOM_META)

cat > $CSTMPKGS_CONFIG_IN << EOF

menuconfig MENU_META
bool "Meta"
default n

if MENU_META
EOF

for mts in $metas; 
do

	echo "config META_$mts" >> $CSTMPKGS_CONFIG_IN
	echo "  bool \"$mts\"" >> $CSTMPKGS_CONFIG_IN
	echo "  default n" >> $CSTMPKGS_CONFIG_IN
done

echo "endif" >> $CSTMPKGS_CONFIG_IN


### GROUP ###

[[ -d $CUSTOM_GROUP ]] && groups=$(ls $CUSTOM_GROUP)

cat >> $CSTMPKGS_CONFIG_IN << EOF

menuconfig MENU_GROUP
bool "Group"
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
bool "Build"
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

### CLEAN FILE ###

sed -i '/^#/d' $CSTMPKGS_CONFIG_OUT
sed -i '/^CONFIG_MENU/d' $CSTMPKGS_CONFIG_OUT


### META CONVERT GROUP AND BUILD ###

while IFS= read -r line;
do
	if [[ $line == "CONFIG_META_"* ]]; then
		metafile=${line##CONFIG_META_}
		metafile=${metafile%=y}
		metafile=$CUSTOM_META/$metafile
		metafile=$(cat $metafile)
		tempfile="$metafile "
	else
		tempfile="$line "
	fi

done < $CSTMPKGS_CONFIG_OUT

echo "$tempfile" | sed \
	-e 's/\(.*.group\)/CONFIG_GROUP_\1=y/g' \
	-e 's/\(.*.build\)/CONFIG_BUILD_\1=y/g' \
	> $CSTMPKGS_CONFIG_OUT


### GROUPS TO BLFS_PKGS_LIST ###

[[ -f $BLFS_PKGS_LIST ]] && rm $BLFS_PKGS_LIST
touch $BLFS_PKGS_LIST
cfggroups=$(grep ^CONFIG_GROUP $CSTMPKGS_CONFIG_OUT || true)
for cg in $cfggroups;
do
	cg=${cg##CONFIG_GROUP_}
	cg=${cg%=y}
	cat $CUSTOM_GROUP/$cg >> $BLFS_PKGS_LIST
done


### BUILDS TO CSTM_BLDS_LIST ###

[[ -f $CSTM_BLDS_LIST ]] && rm $CSTM_BLDS_LIST
touch $CSTM_BLDS_LIST
cfgbuilds=$(grep ^CONFIG_BUILD $CSTMPKGS_CONFIG_OUT || true)
for cf in $cfgbuilds;
do
	cf=${cf##CONFIG_BUILD_}
	cf=${cf%=y}
	echo $cf >> $CSTM_BLDS_LIST
done



