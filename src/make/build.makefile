####################################################################
#
# build.makefile
#
####################################################################


BUILD_SCRIPTS = $(SCRIPTS_DIR)/build

BUILD_BLFS_ARCHIVES_SH = $(BUILD_SCRIPTS)/build-blfs-archives.sh
BUILD_BLFS_WORK_SH = $(BUILD_SCRIPTS)/build-blfs-work.sh

export


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

