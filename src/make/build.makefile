####################################################################
#
# build.makefile
#
####################################################################


#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
BLD_SCRIPTS = $(SRC_SCRIPTS)/build

# target files
BUILD_LFS_CHROOT_SCRIPTS = $(JHALFS_DIR)/build-lfs-chroot-scripts
BUILD_LFS_CHROOT_ARCHIVES = $(JHALFS_DIR)/build-lfs-chroot-archives

# target scripts
BUILD_BOOTSTRAP_ARCHIVES_SH = $(BLD_SCRIPTS)/build-bootstrap-archives.sh
BUILD_BOOTSTRAP_WORK_SH = $(BLD_SCRIPTS)/build-bootstrap-work.sh
BUILD_DEPLOY_BOOTSTRAP_SH = $(BLD_SCRIPTS)/build-deploy-bootstrap.sh
BUILD_GROUP_LIST_SH = $(BLD_SCRIPTS)/build-group-list.sh
BUILD_LFS_SH = $(BLD_SCRIPTS)/build-lfs.sh
BUILD_LFS_CHROOT_SCRIPTS_SH = $(BLD_SCRIPTS)/build-lfs-chroot-scripts.sh
BUILD_LFS_CHROOT_ARCHIVES_SH = $(BLD_SCRIPTS)/build-lfs-chroot-archives.sh
BUILD_BLFS_ARCHIVES_SH = $(BLD_SCRIPTS)/build-blfs-archives.sh
BUILD_BLFS_WORK_SH = $(BLD_SCRIPTS)/build-blfs-work.sh


### OTHER DEFS ###

BUILD_PKGLOGS_SH = $(SCRIPTS_FUNCS)/build-pkglogs.sh
BUILD_ARCHIVES_SH = $(SCRIPTS_FUNCS)/build-archives.sh

# timer
TIMER_SCRIPT = $(SCRIPTS_FUNCS)/timer.sh
ELAP_TIME = $(BUILD_WORK)/elapsed-time
BLD_TIME = $(BUILD_WORK)/bld-time
PKG_TIME = $(BUILD_WORK)/pkg-time
CUMU_TIME = $(BUILD_WORK)/cumu-time



#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
build-bootstrap-archives :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BOOTSTRAP_ARCHIVES_SH)

.PHONY: build-bootstrap-archives


#------------------------------------------------------------------#
build-bootstrap-work :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BOOTSTRAP_WORK_SH)

.PHONY: build-bootstrap-work


#------------------------------------------------------------------#
build-deploy-bootstrap :
	@echo
	@$(call bold_message, $@)
	$(BUILD_DEPLOY_BOOTSTRAP_SH)

.PHONY: build-deploy-bootstrap


#------------------------------------------------------------------#
build-group-list :
	@echo
	@$(call bold_message, $@)
	$(BUILD_GROUP_LIST_SH)

.PHONY: build-group-list


#------------------------------------------------------------------#
build-lfs :
	@echo
	@$(call bold_message, $@)
	$(BUILD_LFS_SH)

.PHONY: build-lfs


#------------------------------------------------------------------#
build-lfs-chroot-scripts $(BUILD_LFS_CHROOT_SCRIPTS) :
	@echo
	@$(call bold_message, build-lfs-chroot-scripts)
	$(BUILD_LFS_CHROOT_SCRIPTS_SH)
	@touch $@

.PHONY: build-lfs-chroot-scripts


#------------------------------------------------------------------#
build-lfs-chroot-archives $(BUILD_LFS_CHROOT_ARCHIVES) :
	@echo
	@$(call bold_message, build-lfs-chroot-archives)
	$(BUILD_LFS_CHROOT_ARCHIVES_SH)
	@touch $@

.PHONY: build-lfs-chroot-archives


#------------------------------------------------------------------#
build-blfs-archives :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BLFS_ARCHIVES_SH)

.PHONY: build-blfs-archives


#------------------------------------------------------------------#
build-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BLFS_WORK_SH)

.PHONY: build-blfs-work


#------------------------------------------------------------------#
watch-timer :
	@watch -n1 tail -n25 $(ELAP_TIME)

.PHONY: watch-timer

