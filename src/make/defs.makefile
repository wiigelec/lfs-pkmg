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

BUILD_DIR = $(TOPDIR)/build
CONFIG_DIR = $(BUILD_DIR)/config
SRC_DIR = $(TOPDIR)/src

BUILD_CONFIG = $(BUILD_DIR)/config
BUILD_XML = $(BUILD_DIR)/xml
SCRIPTS_DIR = $(SRC_DIR)/scripts
SCRIPTS_FUNCS = $(SCRIPTS_DIR)/funcs

SRC_XSL = $(SRC_DIR)/xsl

DEPTREE_DIR = deptree
DEPS_DIR = $(DEPTREE_DIR)/deps
TREES_DIR = $(DEPTREE_DIR)/trees
BLFS_SCRIPTS_DIR = blfs-scripts

LPM_DIR = /var/lib/lpm
LPM_BUILD = $(LPM_DIR)/build
INSTALLED_DIR = $(LPM_DIR)/installed
DIFFLOG_DIR = $(LPM_BUILD)/difflog
PKGLOG_DIR = $(LPM_BUILD)/pkglog
ARCHIVE_DIR = $(LPM_BUILD)/packages


#------------------------------------------------------------------#
# FILES
#------------------------------------------------------------------#

ACTION_CONFIG_IN = $(CONFIG_DIR)/action-config-in
ACTION_CONFIG_OUT = $(CONFIG_DIR)/action-config-out
CURRENT_CONFIG = $(BUILD_CONFIG)/current-config 

BLFS_FULL_XML = blfs-full.xml
BLFS_PKGLIST_XML = blfs-pkglist.xml
BLFS_PKGLIST_XSL = $(SRC_XSL)/blfs-pkglist.xsl

BLFSPKGS_CONFIG_IN = $(BUILD_CONFIG)/blfspkfgs-config-in
BLFSPKGS_CONFIG_OUT = $(BUILD_CONFIG)/blfspkgs-config-out
SELECT_BLFSPKGS_XSL = $(SRC_XSL)/select-blfspkgs.xsl
BLFS_PKGS_LIST = $(BUILD_CONFIG)/blfs-pkgs-list

BLFS_DEPS_XSL = $(SRC_XSL)/blfs-deps.xsl
BLFS_SCRIPTS_XSL = $(SRC_XSL)/blfs-scripts.xsl

INSTPKGS_CONFIG_IN = $(BUILD_CONFIG)/instpkgs-config-in
INSTPKGS_CONFIG_OUT = $(BUILD_CONFIG)/instpkgs-config-out
REMV_PKGS_LIST = $(BUILD_CONFIG)/remv-pkgs-list

REPOPKGS_CONFIG_IN = $(BUILD_CONFIG)/repopkgs-config-in
REPOPKGS_CONFIG_OUT = $(BUILD_CONFIG)/repopkgs-config-out
INST_PKGS_LIST = $(BUILD_CONFIG)/inst-pkgs-list

WORK_PKGS_TREE = $(BUILD_CONFIG)/work-pkgs-tree

BUILD_PKGLOGS_SH = $(SCRIPTS_FUNCS)/build-pkglogs.sh
BUILD_ARCHIVES_SH = $(SCRIPTS_FUNCS)/build-archives.sh

INST_PKG_SH = $(SCRIPTS_FUNCS)/inst-pkg.sh
REMV_PKG_SH = $(SCRIPTS_FUNCS)/remv-pkg.sh


#------------------------------------------------------------------#
# MISC
#------------------------------------------------------------------#

MENU_CONFIG = python3 $(TOPDIR)/kconfiglib/menuconfig.py

export
