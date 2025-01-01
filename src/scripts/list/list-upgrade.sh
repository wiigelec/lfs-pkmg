#!/bin/bash
####################################################################
# 
# list-upgrade.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/get-list-pkgs.func
source $SCRIPTS_FUNCS/install-list-files.func


# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# GET LIST PACKAGES
#------------------------------------------------------------------#

echo "Reading list packages..."

lists=$(cat $REPO_LIST_LIST)


#------------------------------------------------------------------#
# PRE-UPGRADE SCRIPTS
#------------------------------------------------------------------#

echo "Running list pre-upgrade scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_SCRIPT_DIR/$each.pre-upgrade
        [[ -f $script ]] && $script
done

### ADMIN ###
for each in $lists; do

        each=${each##*/}
        script=$ADMIN_SCRIPT_DIR/$each.pre-upgrade
        [[ -f $script ]] && $script
done


#------------------------------------------------------------------#
# WRITE UPGRADE LIST
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

as_root $PACKAGE_UPGRADE_SH


#------------------------------------------------------------------#
# POST-UPGRADE SCRIPTS
#------------------------------------------------------------------#

echo
echo "Running list post-upgrade scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_SCRIPT_DIR/$each.post-upgrade
        [[ -f $script ]] && $script
done

### ADMIN ###
for each in $lists; do

        each=${each##*/}
        script=$ADMIN_SCRIPT_DIR/$each.post-upgrade
        [[ -f $script ]] && $script
done



#------------------------------------------------------------------#
# INSTALL LIST FILES
#------------------------------------------------------------------#

echo "Installing list files..."

install-list-files

for each in $lists;
do
	listname=${each##*/}
	listfile=${INSTALLROOT}$LPM_LISTS/$listname
        as_root rm $listfile
done

