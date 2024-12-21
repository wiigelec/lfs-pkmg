####################################################################
#
# build.makefile
#
####################################################################


BUILD_SCRIPTS = $(SCRIPTS_DIR)/build

BUILD_BLFS_ARCHIVES_SH = $(BUILD_SCRIPTS)/build-blfs-archives.sh
BUILD_BLFS_VERSIONDIR_SH = $(BUILD_SCRIPTS)/build-blfs-versiondir.sh
BUILD_BLFS_WORK_SH = $(BUILD_SCRIPTS)/build-blfs-work.sh

export


#------------------------------------------------------------------#

build-blfs-archives :
	@echo
	@$(call bold_message, Building archives...)
	$(BUILD_BLFS_ARCHIVES_SH)

#------------------------------------------------------------------#

build-blfs-versiondir :
	@echo
	@$(call bold_message, Creating build version dir...)
	$(BUILD_BLFS_VERSIONDIR_SH)

#------------------------------------------------------------------#

build-blfs-work :
	@echo
	@$(call bold_message, Building work dir...)
	$(BUILD_BLFS_WORK_SH)

