#!/bin/bash
####################################################################
# 
# list-install.sh
#
####################################################################

set -e
source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/get-list-pkgs.func
source $SCRIPTS_FUNCS/install-list-files.func

# GET ASROOT

source <(echo $ASROOT)
export -f as_root

echo "Reading list packages..."

lists=$(cat $REPO_LIST_LIST)


#------------------------------------------------------------------#
# PRE-INSTALL SCRIPTS
#------------------------------------------------------------------#

echo "Running list pre-install scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_LIST/$each.pre-install
        [[ -f $script ]] && $script
done

### SYSTEM ###
for each in $lists; do

        each=${each##*/}
        script=$SYSTEM_LIST/$each.pre-install
        [[ -f $script ]] && $script
done


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

echo
echo "Running list post-install scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_LIST/$each.post-install
        [[ -f $script ]] && $script
done

### SYSTEM ###
for each in $lists; do

        each=${each##*/}
        script=$SYSTEM_LIST/$each.post-install
	echo $script
        [[ -f $script ]] && $script
done



#------------------------------------------------------------------#
# INSTALL LIST FILES
#------------------------------------------------------------------#

echo "Installing list files..."

install-list-files

