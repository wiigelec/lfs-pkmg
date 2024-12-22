#!/bin/bash
####################################################################
# 
# list-install.sh
#
####################################################################

set -e
source $CURRENT_CONFIG
source $SCRIPTS_FUNCS/get-list-pkgs.func

# GET ASROOT

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# PRE-INSTALL SCRIPTS
#------------------------------------------------------------------#



#------------------------------------------------------------------#
# WRITE INSTALL LIST
#------------------------------------------------------------------#

# INITIALIZE
listsdir=${INSTALLROOT}$LISTS_DIR
[[ ! -d $listsdir ]] && as_root mkdir -p $listsdir
> $REPO_PKGS_LIST

# ITERATE LISTS
for l in $(cat $REPO_LIST_LIST);
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



#------------------------------------------------------------------#
# INSTALL LIST FILES
#------------------------------------------------------------------#

echo "Installing list files..."

install-list-files
