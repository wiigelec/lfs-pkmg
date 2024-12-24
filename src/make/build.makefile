####################################################################
#
# build.makefile
#
####################################################################


BUILD_SCRIPTS = $(SCRIPTS_DIR)/build

BUILD_LFS_CHROOT = $(JHALFS_DIR)/build-lfs-chroot

BUILD_BOOTSTRAP_ARCHIVES_SH = $(BUILD_SCRIPTS)/build-bootstrap-archives.sh
BUILD_BOOTSTRAP_WORK_SH = $(BUILD_SCRIPTS)/build-bootstrap-work.sh
BUILD_DEPLOY_BOOTSTRAP_SH = $(BUILD_SCRIPTS)/build-deploy-bootstrap.sh
BUILD_GROUP_LIST_SH = $(BUILD_SCRIPTS)/build-group-list.sh
BUILD_LFS_SH = $(BUILD_SCRIPTS)/build-lfs.sh
BUILD_LFS_CHROOT_SH = $(BUILD_SCRIPTS)/build-lfs-chroot.sh
BUILD_BLFS_ARCHIVES_SH = $(BUILD_SCRIPTS)/build-blfs-archives.sh
BUILD_BLFS_WORK_SH = $(BUILD_SCRIPTS)/build-blfs-work.sh


#------------------------------------------------------------------#

build-bootstrap-archives :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BOOTSTRAP_ARCHIVES_SH)


#------------------------------------------------------------------#

build-bootstrap-work :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BOOTSTRAP_WORK_SH)


#------------------------------------------------------------------#

build-deploy-bootstrap :
	@echo
	@$(call bold_message, $@)
	$(BUILD_DEPLOY_BOOTSTRAP_SH)


#------------------------------------------------------------------#

build-group-list :
	@echo
	@$(call bold_message, $@)
	$(BUILD_GROUP_LIST_SH)


#------------------------------------------------------------------#

build-lfs :
	@echo
	@$(call bold_message, $@)
	$(BUILD_LFS_SH)


#------------------------------------------------------------------#

build-lfs-chroot $(BUILD_LFS_CHROOT) :
	@echo
	@$(call bold_message, build-lfs-chroot)
	$(BUILD_LFS_CHROOT_SH)


#------------------------------------------------------------------#

build-blfs-archives :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BLFS_ARCHIVES_SH)


#------------------------------------------------------------------#

build-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(BUILD_BLFS_WORK_SH)


#------------------------------------------------------------------#

watch-timer :
	@watch -n1 tail -n25 $(ELAP_TIME)
