####################################################################
#
# makefile.defs
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

#------------------------------------------------------------------#
BUILD_XML_DIR=$(BUILD_DIR)/xml

LFS_BOOK = $(BUILD_XML_DIR)/lfs-xml
BLFS_BOOK = $(BUILD_XML_DIR)/blfs-xml

JHALFS_GIT_DIR = $(BUILD_DIR)/jhalfs
JHALFS_MNT = $(INSTALLROOT)/jhalfs

DIFFLOG_DIR = /var/lib/jhalfs/BLFS/difflog
PKGLOG_DIR = /var/lib/jhalfs/BLFS/pkglog
ARCHIVE_DIR = /var/lib/jhalfs/BLFS/archive
CHROOT_SCRIPTS_DIR = $(JHALFS_MNT)/lfspkmg-scripts

LFS_CUSTOM_DIR = $(SRC_DIR)/build/lfs/custom


####################################################################
# FILE DEFINITIONS
####################################################################

CURRENT_CONFIG = $(BUILD_DIR)/current-config
ACTION_CONFIG_IN = $(BUILD_DIR)/action-config.in
ACTION_CONFIG_OUT = $(BUILD_DIR)/action-config.out
ACTION_CURRENT_CONFIG = $(BUILD_DIR)/current-config

#------------------------------------------------------------------#
INDEX_HTML = $(HTML_DIR)/index.html

#------------------------------------------------------------------#
# BUILD LFS FILES
BL_CONFIG_IN = $(BUILD_DIR)/bl-config.in
BL_CONFIG_OUT = $(BUILD_DIR)/bl-config.out

LFS_FULL_XML = $(BUILD_XML_DIR)/lfs-full.xml

JHALFS_CONFIG = $(JHALFS_GIT_DIR)/configuration
JHALFS_BUILD = $(JHALFS_MNT)/jhalfs-build
DIFFLOG_CONVERT = $(JHALFS_MNT)/difflog-convert
CHROOT_SCRIPTS = $(JHALFS_MNT)/lfspkmg-chroot
ARCHIVE_MNT = $(JHALFS_MNT)/archive-mnt
JHALFS_LFS = $(JHALFS_MNT)/jhalfs-lfs


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

ACTION_CONFIG_IN_SH = $(SCRIPT_DIR)/action/action-config-in.sh
ACTION_CONFIG_OUT_SH = $(SCRIPT_DIR)/action/action-config-out.sh
ACTION_CURRENT_CONFIG_SH = $(SCRIPT_DIR)/action/action-current-config.sh
ACTION_LAUNCH_ACTION_SH = $(SCRIPT_DIR)/action/action-launch-action.sh

BUILD_LAUNCH_BUILD_SH = $(SCRIPT_DIR)/build/build-launch-build.sh

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
# UTIL
UTIL_GET_LFSBOOK_SH = $(SCRIPT_DIR)/util/util-get-lfsbook.sh
UTIL_GET_BLFSBOOK_SH = $(SCRIPT_DIR)/util/util-get-blfsbook.sh
UTIL_GET_JHALFS_SH = $(SCRIPT_DIR)/util/util-get-jhalfs.sh
UTIL_CREATE_PKGLOG_SH = $(SCRIPT_DIR)/util/util-create-pkglog.sh
UTIL_CREATE_ARCHIVE_SH = $(SCRIPT_DIR)/util/util-create-archive.sh

### EXPORT ALL ###
export