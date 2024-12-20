####################################################################
#
# defs.makefile
#
####################################################################


####################################################################
# DISPLAY OUTPUT
####################################################################

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


ASROOT = as_root() { if [ $$EUID = 0 ]; then $$*; \
	 elif [ -x /usr/bin/sudo ]; then sudo -E $$*; \
	 else su -c \\"$$*\\"; fi }



####################################################################
# DIRECTORY DEFINITIONS
####################################################################

#------------------------------------------------------------------#
### TOP LEVEL DIRS ###

TOPDIR = $(shell pwd)

HTML_DIR = $(TOPDIR)/doc/html
BUILD_DIR ?= $(TOPDIR)/build
SRC_DIR = $(TOPDIR)/src
SCRIPT_DIR = $(SRC_DIR)/scripts
MISC_DIR = $(SRC_DIR)/misc
XSL_DIR = $(SRC_DIR)/xsl

LPM_DIR = /var/lib/lpm

#------------------------------------------------------------------#
BUILD_GIT_DIR=$(TOPDIR)/build/git

LFS_BOOK = $(BUILD_GIT_DIR)/lfs-book
BLFS_BOOK = $(BUILD_GIT_DIR)/blfs-book

JHALFS_GIT_DIR = $(BUILD_GIT_DIR)/jhalfs
JHALFS_MNT = $(INSTALLROOT)/jhalfs

LFS_CUSTOM_DIR = $(SRC_DIR)/scripts/build/lfs/custom
CHROOT_SCRIPTS_DIR = $(JHALFS_MNT)/lfspkmg-scripts

DIFFLOG_DIR = $(LPM_DIR)/build/difflog
PKGLOG_DIR = $(LPM_DIR)/build/pkglog
ARCHIVE_DIR = $(LPM_DIR)/build/archive
PACKAGES_DIR = $(LPM_DIR)/packages
LISTS_DIR = $(LPM_DIR)/lists
INSTALLED_DIR=$(LPM_DIR)/installed

ADMIN_SCRIPT_DIR = $(SCRIPT_DIR)/admin
USER_SCRIPT_DIR = $(TOPDIR)/custom

DEPTREE_DIR = $(BUILD_DIR)/deptree
DEPS_DIR = $(DEPTREE_DIR)/deps
TREE_DIR = $(DEPTREE_DIR)/trees
WORK_DIR = $(BUILD_DIR)/work

BLFS_SCRIPTS_DIR = $(BUILD_DIR)/build-scripts


####################################################################
# FILE DEFINITIONS
####################################################################

CURRENT_CONFIG = $(BUILD_DIR)/config/current-config
ACTION_CONFIG_IN = $(BUILD_DIR)/config/action-config.in
ACTION_CONFIG_OUT = $(BUILD_DIR)/config/action-config.out
ACTION_CURRENT_CONFIG = $(BUILD_DIR)/config/current-config

PKGINST_CONFIG_IN = $(BUILD_DIR)/config/pkginst-config.in
PKGINST_CONFIG_OUT = $(BUILD_DIR)/config/pkginst-config.out
INSTALL_PKG_LIST = $(BUILD_DIR)/config/install-pkg-list

PKGREM_CONFIG_IN = $(BUILD_DIR)/config/pkgrem-config.in
PKGREM_CONFIG_OUT = $(BUILD_DIR)/config/pkgrem-config.out
REMOVE_PKG_LIST = $(BUILD_DIR)/config/remove-pkg-list

PKGUPGR_CONFIG_IN = $(BUILD_DIR)/config/pkgupgr-config.in
PKGUPGR_CONFIG_OUT = $(BUILD_DIR)/config/pkgupgr-config.out
UPGRADE_PKG_LIST = $(BUILD_DIR)/config/upgrade-pkg-list

BUILD_TREES_IN = $(BUILD_DIR)/config/build-trees-in
BUILD_TREES_OUT = $(BUILD_DIR)/config/build-trees-out

LFS_FULL_XML = $(BUILD_DIR)/xml/lfs-full.xml
BLFS_FULL_XML = $(BUILD_DIR)/xml/blfs-full.xml
PKG_LFS_XML = $(BUILD_DIR)/xml/pkg-lfs.xml
PKG_LFS_XSL = $(XSL_DIR)/pkg-lfs.xsl
PKG_BLFS_XML = $(BUILD_DIR)/xml/pkg-blfs.xml
PKG_BLFS_XSL = $(XSL_DIR)/pkg-blfs.xsl

PKG_ADD_INSTALLED_XSL = $(XSL_DIR)/pkg-add-installed.xsl

BLFS_DEPS_XSL = $(SRC_DIR)/xsl/blfs-deps.xsl
BLFS_SCRIPTS_XSL = $(SRC_DIR)/xsl/blfs-scripts.xsl

BLFS_DEPS_DONE = $(BUILD_DIR)/deps.done
BLFS_SCRIPTS_DONE = $(BUILD_DIR)/scripts.done

BB_CONFIG_IN = $(BUILD_DIR)/config/bb-config.in
BB_CONFIG_OUT = $(BUILD_DIR)/config/bb-config.out
BB_CONFIG_IN_XSL = $(SRC_DIR)/xsl/bb-config-in.xsl
BB_BUILD_LIST = $(BUILD_DIR)/config/bb-build-list
BB_BUILD_TREE = $(BUILD_DIR)/config/bb-build-tree

#------------------------------------------------------------------#
LISTDEPS_CONFIG_IN = $(BUILD_DIR)/config/listdeps-config.in
LISTDEPS_CONFIG_OUT = $(BUILD_DIR)/config/listdeps-config.out

LISTINST_CONFIG_IN = $(BUILD_DIR)/config/listinst-config.in
LISTINST_CONFIG_OUT = $(BUILD_DIR)/config/listinst-config.out

LISTREM_CONFIG_IN = $(BUILD_DIR)/config/listrem-config.in
LISTREM_CONFIG_OUT = $(BUILD_DIR)/config/listrem-config.out

LISTUPGR_CONFIG_IN = $(BUILD_DIR)/config/listupgr-config.in
LISTUPGR_CONFIG_OUT = $(BUILD_DIR)/config/listupgr-config.out

#------------------------------------------------------------------#
INDEX_HTML = $(HTML_DIR)/index.html

#------------------------------------------------------------------#
# BUILD LFS FILES
BL_CONFIG_IN = $(BUILD_DIR)/bl-config.in
BL_CONFIG_OUT = $(BUILD_DIR)/bl-config.out

JHALFS_CONFIG = $(JHALFS_GIT_DIR)/configuration
JHALFS_BUILD = $(JHALFS_MNT)/jhalfs-build
DIFFLOG_CONVERT = $(JHALFS_MNT)/difflog-convert
CHROOT_SCRIPTS = $(JHALFS_MNT)/lfspkmg-chroot
ARCHIVE_MNT = $(JHALFS_MNT)/archive-mnt
JHALFS_LFS = $(JHALFS_MNT)/jhalfs-lfs

LMP_VERSION = $(LPM_DIR)/lpm-version

####################################################################
# MISC DEFINITIONS
####################################################################

LFS ?= /mnt/lfs

#------------------------------------------------------------------#
# GIT
LFS_GIT = https://git.linuxfromscratch.org/lfs
BLFS_GIT = https://git.linuxfromscratch.org/blfs
JHALFS_GIT = https://git.linuxfromscratch.org/jhalfs

#------------------------------------------------------------------#
# BROWSER
BROWSER ?= lynx

### MENU_CONFIG ###
MENU_CONFIG = python3 $(TOPDIR)/kconfiglib/menuconfig.py


####################################################################
# SCRIPT DEFINITIONS
####################################################################

#------------------------------------------------------------------#
# ACTION
ACTION_CONFIG_IN_SH = $(SCRIPT_DIR)/action/action-config-in.sh
ACTION_CONFIG_OUT_SH = $(SCRIPT_DIR)/action/action-config-out.sh
ACTION_CURRENT_CONFIG_SH = $(SCRIPT_DIR)/action/action-current-config.sh
ACTION_LAUNCH_SH = $(SCRIPT_DIR)/action/action-launch.sh


#------------------------------------------------------------------#
# BUILD
BUILD_LAUNCH_SH = $(SCRIPT_DIR)/build/build-launch.sh

BUILD_LFS_FULL_XML_SH = $(SCRIPT_DIR)/build/build-lfs-full-xml.sh
BUILD_PKG_LFS_XML_SH = $(SCRIPT_DIR)/build/build-pkg-lfs-xml.sh
BUILD_BLFS_FULL_XML_SH = $(SCRIPT_DIR)/build/build-blfs-full-xml.sh
BUILD_PKG_BLFS_XML_SH = $(SCRIPT_DIR)/build/build-pkg-blfs-xml.sh


#------------------------------------------------------------------#
# BUILD LFS
BL_CONFIG_IN_SH = $(SCRIPT_DIR)/build/lfs/bl-config-in.sh
BL_CONFIG_OUT_SH = $(SCRIPT_DIR)/build/lfs/bl-config-out.sh
BL_JHALFS_CONFIG_SH = $(SCRIPT_DIR)/build/lfs/bl-jhalfs-config.sh
BL_JHALFS_MNT_SH = $(SCRIPT_DIR)/build/lfs/bl-jhalfs-mnt.sh
BL_DIFFLOG_CONVERT_SH = $(SCRIPT_DIR)/build/lfs/bl-difflog-convert.sh
BL_JHALFS_BUILD_SH = $(SCRIPT_DIR)/build/lfs/bl-jhalfs-build.sh
BL_CHROOT_SCRIPTS_SH = $(SCRIPT_DIR)/build/lfs/bl-chroot-scripts.sh
BL_RUN_CHROOT_SH = $(SCRIPT_DIR)/build/lfs/bl-run-chroot.sh

#------------------------------------------------------------------#
# BUILD BLFS
BB_CONFIG_IN_SH = $(SCRIPT_DIR)/build/blfs/bb-config-in.sh
BB_CONFIG_OUT_SH = $(SCRIPT_DIR)/build/blfs/bb-config-out.sh
BB_BUILD_LIST_SH = $(SCRIPT_DIR)/build/blfs/bb-build-list.sh
BB_FIX_DEPS_SH = $(SCRIPT_DIR)/build/blfs/bb-fix-deps.sh
BB_FIX_SCRIPTS_SH = $(SCRIPT_DIR)/build/blfs/bb-fix-scripts.sh
BUILD_BLFS_SH = $(SCRIPT_DIR)/build/build-blfs.sh
BUILD_DEPS_SH = $(SCRIPT_DIR)/build/build-deps.sh
BUILD_SCRIPTS_SH = $(SCRIPT_DIR)/build/build-scripts.sh
BUILD_INIT_WORK_SH = $(SCRIPT_DIR)/build/build-init-work.sh
BUILD_WORK_SH = $(SCRIPT_DIR)/build/build-work.sh

BS_BUILD_LIST_SH = $(SCRIPT_DIR)/build/bootstrap/bs-build-list.sh
BS_DEPLOY_WORK_SH = $(SCRIPT_DIR)/build/bootstrap/bs-deploy-work.sh

#------------------------------------------------------------------#
# LIST
LIST_LAUNCH_SH = $(SCRIPT_DIR)/list/list-launch.sh

LIST_CREATEDIR_SH = $(SCRIPT_DIR)/list/list-createdir.sh

LISTDEPS_CONFIG_IN_SH = $(SCRIPT_DIR)/list/listdeps-config-in.sh
LISTDEPS_CONFIG_OUT_SH = $(SCRIPT_DIR)/list/listdeps-config-out.sh
LIST_CREATEDEPS_SH = $(SCRIPT_DIR)/list/list-createdeps.sh

LISTINST_CONFIG_IN_SH = $(SCRIPT_DIR)/list/listinst-config-in.sh
LISTINST_CONFIG_OUT_SH = $(SCRIPT_DIR)/list/listinst-config-out.sh
LISTINST_SH = $(SCRIPT_DIR)/list/listinst.sh

LISTREM_CONFIG_IN_SH = $(SCRIPT_DIR)/list/listrem-config-in.sh
LISTREM_CONFIG_OUT_SH = $(SCRIPT_DIR)/list/listrem-config-out.sh
LISTREM_SH = $(SCRIPT_DIR)/list/listrem.sh

LISTUPGR_CONFIG_IN_SH = $(SCRIPT_DIR)/list/listupgr-config-in.sh
LISTUPGR_CONFIG_OUT_SH = $(SCRIPT_DIR)/list/listupgr-config-out.sh
LISTUPGR_SH = $(SCRIPT_DIR)/list/listupgr.sh

#------------------------------------------------------------------#
# PACKAGE
PACKAGE_LAUNCH_SH = $(SCRIPT_DIR)/package/package-launch.sh
PKGINST_CONFIG_IN_SH = $(SCRIPT_DIR)/package/pkginst-config-in.sh
PKGINST_CONFIG_OUT_SH = $(SCRIPT_DIR)/package/pkginst-config-out.sh
PKGINST_SH = $(SCRIPT_DIR)/package/pkginst.sh

PKGREM_CONFIG_IN_SH = $(SCRIPT_DIR)/package/pkgrem-config-in.sh
PKGREM_CONFIG_OUT_SH = $(SCRIPT_DIR)/package/pkgrem-config-out.sh
PKGREM_SH = $(SCRIPT_DIR)/package/pkgrem.sh

PKGUPGR_CONFIG_IN_SH = $(SCRIPT_DIR)/package/pkgupgr-config-in.sh
PKGUPGR_CONFIG_OUT_SH = $(SCRIPT_DIR)/package/pkgupgr-config-out.sh
PKGUPGR_SH = $(SCRIPT_DIR)/package/pkgupgr.sh

#------------------------------------------------------------------#
# UTIL
UTIL_GET_LFSBOOK_SH = $(SCRIPT_DIR)/util/util-get-lfsbook.sh
UTIL_GET_BLFSBOOK_SH = $(SCRIPT_DIR)/util/util-get-blfsbook.sh
UTIL_GET_JHALFS_SH = $(SCRIPT_DIR)/util/util-get-jhalfs.sh
UTIL_CREATE_PKGLOG_SH = $(SCRIPT_DIR)/util/util-create-pkglog.sh
UTIL_CREATE_ARCHIVE_SH = $(SCRIPT_DIR)/util/util-create-archive.sh
UTIL_INSTALL_PKG_SH = $(SCRIPT_DIR)/util/util-install-package.sh
UTIL_REMOVE_PKG_SH = $(SCRIPT_DIR)/util/util-remove-package.sh
UTIL_GET_MIRROR_VERSIONS_SH = $(SCRIPT_DIR)/util/util-get-mirror-versions.sh
UTIL_LPCONFIG_IN_SH = $(SCRIPT_DIR)/util/util-lpconfig-in.sh
UTIL_BUILD_TREES_SH = $(SCRIPT_DIR)/util/util-build-trees.sh
UTIL_ROOT_TREE_SH = $(SCRIPT_DIR)/util/util-root-tree.sh

UTIL_MOUNT_KERNFS_SH = $(SCRIPT_DIR)/util/util-mount-kernfs.sh
UTIL_UMOUNT_KERNFS_SH = $(SCRIPT_DIR)/util/util-umount-kernfs.sh

### EXPORT ALL ###
export
