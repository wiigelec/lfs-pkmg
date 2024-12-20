####################################################################
#
# build.makefile
#
####################################################################


BUILD_SCRIPTS = $(SCRIPTS_DIR)/build

BUILD_BLFS_VERSIONDIR_SH = $(BUILD_SCRIPTS)/build-blfs-versiondir.sh

export


#------------------------------------------------------------------#

build-blfs-versiondir :
	@echo
	@$(call bold_message, Creating build version dir...)
	$(BUILD_BLFS_VERSIONDIR_SH)

