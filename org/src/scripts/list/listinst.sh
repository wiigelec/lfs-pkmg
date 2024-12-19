#!/bin/bash
####################################################################
# 
# listinst.sh
#
####################################################################

set -e

### GET ASROOT ###
source <(echo $ASROOT)
export -f as_root

lists=$(ls $BUILD_DIR/config/*.list)

#------------------------------------------------------------------#
# PRE INSTALL SCRIPTS

# user
for each in $lists; do

	each=${each##*/}
	script=$USER_SCRIPT_DIR/$each.pre-install
	[[ -f $script ]] && $script
done

# admin
for each in $lists; do

	each=${each##*/}
	script=$ADMIN_SCRIPT_DIR/$each.pre-install
	[[ -f $script ]] && $script
done


#------------------------------------------------------------------#
# INSTALL PACKAGES

$PKGINST_SH


#------------------------------------------------------------------#
# POST INSTALL SCRIPTS

# user
for each in $lists; do

	each=${each##*/}
	script=$USER_SCRIPT_DIR/$each.post-install
	[[ -f $script ]] && $script
done

# admin
for each in $lists; do

	each=${each##*/}
	script=$ADMIN_SCRIPT_DIR/$each.post-install
	[[ -f $script ]] && $script
done


#------------------------------------------------------------------#
# LIST FILES

listsdir=${INSTALLROOT}$LISTS_DIR
[[ ! -d $listsdir ]] && as_root mkdir -p $listsdir
as_root mv $BUILD_DIR/config/*.list $listsdir/

