#!/bin/bash
####################################################################
# 
# setup-blfs-work.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 
source $SCRIPTS_FUNCS/setup-deps.func
source $SCRIPTS_FUNCS/setup-scripts.func
source $SCRIPTS_FUNCS/setup-makefile.func

# GET ASROOT 

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# INITIALIZE WORK DIR
#------------------------------------------------------------------#

[[ -d $WORK_DIR ]] && rm -rf $WORK_DIR
mkdir -p $WORK_DIR/{scripts,logs}
> $WORK_PKGS_TREE


#------------------------------------------------------------------#
# PACKAGE DEP TREE
#------------------------------------------------------------------#

setup-deps


#------------------------------------------------------------------#
# ORDER BUILD SCRIPTS
#------------------------------------------------------------------#

setup-scripts


#------------------------------------------------------------------#
# GENERATE MAKEFILE
#------------------------------------------------------------------#

setup-makefile


#------------------------------------------------------------------#
# INITIALIZE DIFFLOG DIR
#------------------------------------------------------------------#

[[ ! -d $DIFFLOG_DIR ]] && as_root mkdir -p $DIFFLOG_DIR

