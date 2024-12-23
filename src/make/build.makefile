####################################################################
#
# build.makefile
#
####################################################################


BUILD_SCRIPTS = $(SCRIPTS_DIR)/build

BUILD_LFS_CHROOT = $(JHALFS_DIR)/build-lfs-chroot

BUILD_LFS_SH = $(BUILD_SCRIPTS)/build-lfs.sh
BUILD_LFS_CHROOT_SH = $(BUILD_SCRIPTS)/build-lfs-chroot.sh
BUILD_BLFS_ARCHIVES_SH = $(BUILD_SCRIPTS)/build-blfs-archives.sh
BUILD_BLFS_WORK_SH = $(BUILD_SCRIPTS)/build-blfs-work.sh

export


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
