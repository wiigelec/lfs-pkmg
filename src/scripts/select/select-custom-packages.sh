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
sed -i 's/^CONFIG_.*_//g' $CSTMPKGS_CONFIG_OUT
sed -i 's/=y//g' $CSTMPKGS_CONFIG_OUT

configout="$(cat $CSTMPKGS_CONFIG_OUT)"


### ITERATE CONFIG ###

while : ;
do
	meta="false"
	for co in $configout;
	do
		case $co in

			#------------------------------------------#
			# META
			*.meta )
		       	meta="true"
			metafile="$(cat $CUSTOM_META/$co)"
			configout=${configout//$co/}
			configout="$configout $metafile"
				;;
			#------------------------------------------#

			#------------------------------------------#
			# GROUP
			*.group )

			# write blfs pkgs list
			cat $CUSTOM_GROUP/$co >> $BLFS_PKGS_LIST
			configout="${configout//$co/}"
				;;
			#------------------------------------------#

			#------------------------------------------#
			# BUILD
			*.build )
				
			# write cstm blds list
			echo $co >> $CSTM_BLDS_LIST
			configout="${configout//$co/}"
				;;
			#------------------------------------------#

			* ) ;;
		esac
	done

	# break
	if [[ $meta == "false" ]]; then break; fi
done


### REMOVE DUPLICATES ###

nodup="$(cat -n $CSTM_BLDS_LIST | sort -uk2 | sort -n | cut -f2-)"
echo "$nodup" > $CSTM_BLDS_LIST

