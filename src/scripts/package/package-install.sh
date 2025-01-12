#!/bin/bash
####################################################################
# 
# package-install.sh
#
####################################################################

set -e


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# CONFIRM
#------------------------------------------------------------------#

installpkglist=$(cat $REPO_PKGS_LIST | xargs)

echo
echo "Installing:"
echo
echo "$installpkglist"
echo
echo "to $INSTALLROOT"
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

echo
echo
echo "Installing package files to $INSTALLROOT:"
echo


packages=$(cat $REPO_PKGS_LIST)


#------------------------------------------------------------------#
# PRE INSTALL SCRIPTS
#------------------------------------------------------------------#

if [[ -d $CUSTOM_PACKAGE ]]; then

	echo "Running package pre-install scripts..."

	for each in $packages; do

        	each=${each##*/}
		each=${each%%--*}

        	script=$CUSTOM_PACKAGE/$each.package.pre-install
        	[[ -f $script ]] && echo $script && $script

	done
fi


#------------------------------------------------------------------#
# INSTALL PACKAGES
#------------------------------------------------------------------#

echo -e "Installing packages...\n"

# ITERATE INSTALL PACKAGE LIST
error="false"
for p in $packages;
do
	# CHECK INSTALLED
	ifl=${p%.txz}
	ifl=${ifl##*/}
	ifl=$INSTALLROOT/$LPM_INSTALLED/$ifl
	[[ -f $ifl ]] && echo "Skipping ${p##*/}: INSTALLED" && continue

	set +e
	as_root $INST_PKG_SH $p
	ret=$?
	set -e

	[ $ret -ne 0 ] && error="true"

done

if [[ $error == "true" ]]; then 

	echo
	echo ">>>>> Package install errors occured. <<<<<"
	echo
	exit 1
fi


#------------------------------------------------------------------#
# POST INSTALL SCRIPTS
#------------------------------------------------------------------#

if [[ -d $CUSTOM_PACKAGE ]]; then

	echo -e "\nRunning package post-install scripts..."

	for each in $packages; do

        	each=${each##*/}
		each=${each%%--*}

        	script=$CUSTOM_PACKAGE/$each.package.post-install
        	if [[ -f $script ]]; then echo $script; $script; fi

	done
fi

