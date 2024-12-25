#!/bin/bash
####################################################################
# 
# list-remove.sh
#
####################################################################

set -e
source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/get-list-pkgs.func

# GET ASROOT

source <(echo $ASROOT)
export -f as_root

echo "Reading list packages..."

lists=$(cat $REMV_LISTS_LIST)


#------------------------------------------------------------------#
# PRE-REMOVE SCRIPTS
#------------------------------------------------------------------#

echo "Running list pre-remove scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_SCRIPT_DIR/$each.pre-remove
        [[ -f $script ]] && $script
done

### ADMIN ###
for each in $lists; do

        each=${each##*/}
        script=$ADMIN_SCRIPT_DIR/$each.pre-remove
        [[ -f $script ]] && $script
done


#------------------------------------------------------------------#
# WRITE REMOVE PACKAGES LIST
#------------------------------------------------------------------#

# INITIALIZE
> $REPO_PKGS_LIST

# ITERATE LISTS
for l in $lists;
do

	get-list-pkgs $l >> $REMV_PKGS_LIST
done

# SORT UNIQUE
listpackages=$(cat $REMV_PKGS_LIST | sort -u)
> $REMV_PKGS_LIST
for lp in $listpackages; do

	pkg=${lp##*/}
	pkg=${pkg%.txz}
	pkg=${INSTALLROOT}$INSTALLED_DIR/$pkg
	pkg=${pkg//\/\//\/}
	echo $pkg >> $REMV_PKGS_LIST
done


#------------------------------------------------------------------#
# REMOVE PACKAGES
#------------------------------------------------------------------#

as_root $PACKAGE_REMOVE_SH


#------------------------------------------------------------------#
# POST-REMOVE SCRIPTS
#------------------------------------------------------------------#

echo "Running list post-remove scripts..."

### USER ###
for each in $lists; do

        each=${each##*/}
        script=$USER_SCRIPT_DIR/$each.post-remove
        [[ -f $script ]] && $script
done

### ADMIN ###
for each in $lists; do

        each=${each##*/}
        script=$ADMIN_SCRIPT_DIR/$each.post-remove
        [[ -f $script ]] && $script
done



#------------------------------------------------------------------#
# INSTALL LIST FILES
#------------------------------------------------------------------#

echo "Removing list files..."

for each in $lists;
do
	as_root rm $each
done
