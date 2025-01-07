####################################################################
#
# defs.makefile
#
####################################################################


#------------------------------------------------------------------#
# DISPLAY OUTPUT
#------------------------------------------------------------------#

BOLD= "[0;1m"
NORMAL= "[0;0m"
BLUE= "[1;34m"

define bold_message
  @echo $(BOLD)"===================================================================="
  @echo $(BLUE)"--------------------------------------------------------------------"
  @echo  $(BOLD)$(1)
  @echo $(BLUE)"--------------------------------------------------------------------"$(NORMAL)
  @echo
endef

define done_message
  @echo $(BOLD)"===================================================================="
  @echo $(BLUE)"--------------------------------------------------------------------"
  @echo  $(BOLD)$(1) $(BLUE)$(2)
  @echo "--------------------------------------------------------------------"
  @echo $(BOLD)"===================================================================="$(NORMAL)
  @echo
endef


#------------------------------------------------------------------#
# AS ROOT
#------------------------------------------------------------------#

define ASROOT
as_root() 
{ 
	if [ $$EUID = 0 ]; then $$*;
	elif [ -x /usr/bin/sudo ]; then sudo -E $$*;
	else su -c \\"$$*\\"; 
	fi 
}
endef


#------------------------------------------------------------------#
# DIRECTORIES
#------------------------------------------------------------------#

TOPDIR = $(shell pwd)

#------------------------------------------------------------------#
# VERSION

BUILD_XML = $(BUILD_DIR)/xml
BUILD_DEPTREE = $(BUILD_DIR)/deptree
DEPTREE_DEPS = $(BUILD_DEPTREE)/deps
DEPTREE_TREES = $(BUILD_DEPTREE)/trees

BUILD_SCRIPTS = $(BUILD_DIR)/blfs-scripts
BUILD_WORK = $(BUILD_DIR)/work
WORK_SCRIPTS = $(BUILD_WORK)/scripts
WORK_LOGS = $(BUILD_WORK)/logs

#------------------------------------------------------------------#
# NONVERSION

# build
BLD_DIR = $(TOPDIR)/build
BLD_CONFIG = $(BLD_DIR)/config
BLD_XML = $(BLD_DIR)/xml

# custom
CUSTOM_DIR = $(TOPDIR)/custom
CUSTOM_LIST = $(CUSTOM_DIR)/list
CUSTOM_BUILD = $(CUSTOM_DIR)/build
CUSTOM_GROUP = $(CUSTOM_DIR)/group
CUSTOM_PACKAGE = $(CUSTOM_DIR)/package
CUSTOM_SCRIPTS = $(CUSTOM_DIR)/scripts

# docs
DOC_DIR = $(TOPDIR)/doc

# jhalfs
JHALFS_DIR = $(INSTALLROOT)/jhalfs

# lpm
LPM_DIR = /var/lib/lpm
LPM_BUILD = $(LPM_DIR)/build
LPM_ARCHIVE = $(LPM_BUILD)/packages
LPM_DIFFLOG = $(LPM_BUILD)/difflog
LPM_DOWNLOADS = $(LPM_DIR)/downloads
LPM_INSTALLED = $(LPM_DIR)/installed
LPM_LISTS = $(LPM_DIR)/lists
LPM_PKGLOG = $(LPM_BUILD)/pkglog

# misc
SRC_MISC = $(SRC_DIR)/misc
MISC_LFS = $(SRC_MISC)/lfs
LFS_BUILD = $(MISC_LFS)/build
LFS_GROUP = $(MISC_LFS)/group
LFS_JHALFS = $(MISC_LFS)/jhalfs
MISC_SYSTEM = $(SRC_MISC)/system
SYSTEM_BUILD = $(MISC_SYSTEM)/build
SYSTEM_LIST = $(MISC_SYSTEM)/list
SYSTEM_PACKAGE = $(MISC_SYSTEM)/package

# src
SRC_DIR = $(TOPDIR)/src
SRC_MAKE = $(SRC_DIR)/make
SRC_SCRIPTS = $(SRC_DIR)/scripts
SCRIPTS_FUNCS = $(SRC_SCRIPTS)/funcs
SCRIPTS_UTIL = $(SRC_SCRIPTS)/util
SRC_XSL = $(SRC_DIR)/xsl


#------------------------------------------------------------------#
# FILES
#------------------------------------------------------------------#

# bootstrap
BOOTSTRAP_GROUP_LIST = $(LFS_GROUP)/bootstrap.group

#------------------------------------------------------------------#
# CONFIGS

# action
ACTION_CONFIG_IN = $(BLD_CONFIG)/action-config-in
ACTION_CONFIG_OUT = $(BLD_CONFIG)/action-config-out
CURRENT_CONFIG = $(BLD_CONFIG)/current-config.makefile

# custom packages
CSTMPKGS_CONFIG_IN = $(BLD_CONFIG)/cstmpkfgs-config-in
CSTMPKGS_CONFIG_OUT = $(BLD_CONFIG)/cstmpkgs-config-out
CSTM_BLDS_LIST = $(BLD_CONFIG)/cstm-blds-list

# blfs packages
BLFSPKGS_CONFIG_IN = $(BLD_CONFIG)/blfspkfgs-config-in
BLFSPKGS_CONFIG_OUT = $(BLD_CONFIG)/blfspkgs-config-out
BLFS_PKGS_LIST = $(BLD_CONFIG)/blfs-pkgs-list

# build work
WORK_PKGS_TREE = $(BLD_CONFIG)/work-pkgs-tree

# installed lists
INSTLISTS_CONFIG_IN = $(BLD_CONFIG)/instlists-config-in
INSTLISTS_CONFIG_OUT = $(BLD_CONFIG)/instlists-config-out
REMV_LISTS_LIST = $(BLD_CONFIG)/remv-lists-list

# installed packages
INSTPKGS_CONFIG_IN = $(BLD_CONFIG)/instpkgs-config-in
INSTPKGS_CONFIG_OUT = $(BLD_CONFIG)/instpkgs-config-out
REMV_PKGS_LIST = $(BLD_CONFIG)/remv-pkgs-list

# repository lists
REPOLIST_CONFIG_IN = $(BLD_CONFIG)/repolist-config-in
REPOLIST_CONFIG_OUT = $(BLD_CONFIG)/repolist-config-out
REPO_LIST_LIST = $(BLD_CONFIG)/repo-list-list

# repository packages
REPOPKGS_CONFIG_IN = $(BLD_CONFIG)/repopkgs-config-in
REPOPKGS_CONFIG_OUT = $(BLD_CONFIG)/repopkgs-config-out
REPO_PKGS_LIST = $(BLD_CONFIG)/repo-pkgs-list

# END CONFIGS
#------------------------------------------------------------------#

# custom
CUSTOM_FIX_DEPS_SH = $(CUSTOM_SCRIPTS)/fix-deps.sh
CUSTOM_FIX_SCRIPTS_SH = $(CUSTOM_SCRIPTS)/fix-scripts.sh

# jhalfs
JHALFS_CONFIG = $(JHALFS_GIT_DIR)/configuration

# scripts
UTIL_MOUNT_KERNFS_SH = $(SCRIPTS_UTIL)/util-mount-kernfs.sh
UTIL_UMOUNT_KERNFS_SH = $(SCRIPTS_UTIL)/util-umount-kernfs.sh

# xml
BLFS_FULL_XML_NV = $(BLD_XML)/blfs-full.xml

# xsl
BLFS_DEPS_XSL = $(SRC_XSL)/blfs-deps.xsl
BLFS_PKGLIST_XSL = $(SRC_XSL)/blfs-pkglist.xsl
BLFS_PKGLIST_ADDINST_XSL = $(SRC_XSL)/blfs-pkglist-addinst.xsl
BLFS_SCRIPTS_XSL = $(SRC_XSL)/blfs-scripts.xsl
SELECT_BLFSPKGS_XSL = $(SRC_XSL)/select-blfspkgs.xsl


#------------------------------------------------------------------#
# MISC
#------------------------------------------------------------------#

MENU_CONFIG = python3 $(TOPDIR)/kconfiglib/menuconfig.py

