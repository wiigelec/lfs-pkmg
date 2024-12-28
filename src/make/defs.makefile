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

BOOK_BLFS_DEPS = $(DEPTREE_DIR)/book-blfs-deps
DEPTREE_DIR = ${BUILD_DIR}/deptree
DEPS_DIR = $(DEPTREE_DIR)/deps
TREES_DIR = $(DEPTREE_DIR)/trees

BLFS_SCRIPTS_DIR = ${BUILD_DIR}/blfs-scripts

WORK_DIR = ${BUILD_DIR}/work
WORK_SCRIPTS = $(WORK_DIR)/scripts 

#------------------------------------------------------------------#
# NONVERSION

BLD_DIR = $(TOPDIR)/build
BLD_CONFIG = $(BLD_DIR)/config
BLD_XML = $(BLD_DIR)/xml

SRC_DIR = $(TOPDIR)/src
SCRIPTS_DIR = $(SRC_DIR)/scripts
SCRIPTS_FUNCS = $(SCRIPTS_DIR)/funcs
SCRIPTS_UTIL = $(SCRIPTS_DIR)/util
SRC_MAKE = $(SRC_DIR)/make
SRC_XSL = $(SRC_DIR)/xsl

MISC_DIR = $(SRC_DIR)/misc
MISC_LFS = $(MISC_DIR)/lfs
LFS_CUSTOM_DIR = $(MISC_LFS)/custom


LPM_DIR = /var/lib/lpm
LPM_BUILD = $(LPM_DIR)/build
LISTS_DIR = $(LPM_DIR)/lists
INSTALLED_DIR = $(LPM_DIR)/installed
PKG_DOWNLOAD_DIR = $(LPM_DIR)/downloads
DIFFLOG_DIR = $(LPM_BUILD)/difflog
PKGLOG_DIR = $(LPM_BUILD)/pkglog
ARCHIVE_DIR = $(LPM_BUILD)/packages

ADMIN_SCRIPT_DIR = $(MISC_DIR)/admin
USER_SCRIPT_DIR = $(TOPDIR)/user


#------------------------------------------------------------------#
# FILES
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# NONVERSION

ACTION_CONFIG_IN = $(BLD_CONFIG)/action-config-in
ACTION_CONFIG_OUT = $(BLD_CONFIG)/action-config-out
CURRENT_CONFIG = $(BLD_CONFIG)/current-config

BLFS_FULL_XML_NV = $(BLD_XML)/blfs-full.xml
WORK_PKGS_TREE = $(BLD_CONFIG)/work-pkgs-tree

INSTLISTS_CONFIG_IN = $(BLD_CONFIG)/instlists-config-in
INSTLISTS_CONFIG_OUT = $(BLD_CONFIG)/instlists-config-out
REMV_LISTS_LIST = $(BLD_CONFIG)/remv-lists-list

INSTPKGS_CONFIG_IN = $(BLD_CONFIG)/instpkgs-config-in
INSTPKGS_CONFIG_OUT = $(BLD_CONFIG)/instpkgs-config-out
REMV_PKGS_LIST = $(BLD_CONFIG)/remv-pkgs-list

REPOPKGS_CONFIG_IN = $(BLD_CONFIG)/repopkgs-config-in
REPOPKGS_CONFIG_OUT = $(BLD_CONFIG)/repopkgs-config-out
REPO_PKGS_LIST = $(BLD_CONFIG)/repo-pkgs-list

REPOLIST_CONFIG_IN = $(BLD_CONFIG)/repolist-config-in
REPOLIST_CONFIG_OUT = $(BLD_CONFIG)/repolist-config-out
REPO_LIST_LIST = $(BLD_CONFIG)/repo-list-list

TIMER_SCRIPT = $(SCRIPTS_FUNCS)/timer.sh
ELAP_TIME = $(BLD_DIR)/elapsed-time
BLD_TIME=$(BLD_DIR)/bld-time
PKG_TIME=$(BLD_DIR)/pkg-time
CUMU_TIME=$(BLD_DIR)/cumu-time

JHALFS_DIR = ${INSTALLROOT}/jhalfs
JHALFS_CONFIG = $(JHALFS_GIT_DIR)/configuration

BOOTSTRAP_GROUP_LIST = $(MISC_LFS)/bootstrap.group

#------------------------------------------------------------------#
# VERSION

BUILD_XML = ${BUILD_DIR}/xml
BLFS_FULL_XML = $(BUILD_XML)/blfs-full.xml
BLFS_PKGLIST_XML = $(BUILD_XML)/blfs-pkglist.xml

BOOK_BLFS_SCRIPTS = ${BUILD_DIR}/book-blfs-scripts

BLFS_PKGLIST_XSL = $(SRC_XSL)/blfs-pkglist.xsl
BLFS_PKGLIST_ADDINST_XSL = $(SRC_XSL)/blfs-pkglist-addinst.xsl

BLFSPKGS_CONFIG_IN = $(BLD_CONFIG)/blfspkfgs-config-in
BLFSPKGS_CONFIG_OUT = $(BLD_CONFIG)/blfspkgs-config-out
SELECT_BLFSPKGS_XSL = $(SRC_XSL)/select-blfspkgs.xsl
BLFS_PKGS_LIST = $(BLD_CONFIG)/blfs-pkgs-list

BLFS_DEPS_XSL = $(SRC_XSL)/blfs-deps.xsl
BLFS_SCRIPTS_XSL = $(SRC_XSL)/blfs-scripts.xsl



ACTION_LAUNCH_SH = $(SCRIPTS_FUNCS)/action-launch.sh

BUILD_PKGLOGS_SH = $(SCRIPTS_FUNCS)/build-pkglogs.sh
BUILD_ARCHIVES_SH = $(SCRIPTS_FUNCS)/build-archives.sh

INST_PKG_SH = $(SCRIPTS_FUNCS)/inst-pkg.sh
REMV_PKG_SH = $(SCRIPTS_FUNCS)/remv-pkg.sh
UPGR_PKG_SH = $(SCRIPTS_FUNCS)/upgr-pkg.sh

UTIL_MOUNT_KERNFS_SH = $(SCRIPTS_UTIL)/util-mount-kernfs.sh
UTIL_UMOUNT_KERNFS_SH = $(SCRIPTS_UTIL)/util-umount-kernfs.sh


#------------------------------------------------------------------#
# MISC
#------------------------------------------------------------------#

MENU_CONFIG = python3 $(TOPDIR)/kconfiglib/menuconfig.py

export
