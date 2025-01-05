#!/bin/bash
####################################################################
# 
# list-install.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/get-list-pkgs.func
source $SCRIPTS_FUNCS/install-list-files.func


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# Get list packages
#------------------------------------------------------------------#

echo "Reading list packages..."

lists=$(cat $REPO_LIST_LIST)


#------------------------------------------------------------------#
# PRE-INSTALL SCRIPTS
#------------------------------------------------------------------#

if [[ -d $CUSTOM_LIST ]]; then

	echo "Running list pre-install scripts..."

	for each in $lists; do

        	each=${each##*/}
        	script=$CUSTOM_LIST/$each.pre-install
        	[[ -f $script ]] && echo $script && $script
	done
fi



#------------------------------------------------------------------#
# WRITE INSTALL LIST
#------------------------------------------------------------------#

# INITIALIZE
listsdir=${INSTALLROOT}$LPM_LISTS
[[ ! -d $listsdir ]] && as_root mkdir -p $listsdir
> $REPO_PKGS_LIST

# ITERATE LISTS
for l in $lists;
do

	get-list-pkgs $l >> $REPO_PKGS_LIST
done

# SORT UNIQUE
listpackages=$(cat $REPO_PKGS_LIST | sort -u)
> $REPO_PKGS_LIST
for lp in $listpackages; do
	echo "$lp" >> $REPO_PKGS_LIST
done


#------------------------------------------------------------------#
# INSTALL PACKAGES
#------------------------------------------------------------------#

as_root $PACKAGE_INSTALL_SH


#------------------------------------------------------------------#
# POST-INSTALL SCRIPTS
#------------------------------------------------------------------#

if [[ -d $CUSTOM_LIST ]]; then

	echo -e "\nRunning list post-install scripts..."

	for each in $lists; do

        	each=${each##*/}
        	script=$CUSTOM_LIST/$each.post-install
        	[[ -f $script ]] && echo $script && $script
	done
fi


#------------------------------------------------------------------#
# INSTALL LIST FILES
#------------------------------------------------------------------#

echo "Installing list files..."

install-list-files

