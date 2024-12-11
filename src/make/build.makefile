####################################################################
#
# makefile.build
#
####################################################################

BUILD:
	@echo
	@$(call bold_message, Launching BUILD...)
	$(BUILD_LAUNCH_SH)




####################################################################
# LFS
####################################################################

#------------------------------------------------------------------#
build-lfs : build-lfs-jhalfs build-lfs-archives
	@echo
	@$(call done_message, SUCCESS! LFS on $(LFS) build complete.)

clean-build-lfs : clean-build-lfs-jhalfs


#------------------------------------------------------------------#
build-lfs-jhalfs: $(JHALFS_GIT_DIR) $(JHALFS_CONFIG) \
	$(JHALFS_LFS) $(DIFFLOG_CONVERT)

clean-build-lfs-jhalfs : 
	@-rm -rf $(JHALFS_GIT_DIR)
	@-rm $(JHALFS_CONFIG)
	@-sudo rm -rf $(LFS)/*

jhalfs-git-dir $(JHALFS_GIT_DIR) : 
	@echo
	@$(call bold_message, Downloading jhalfs...)
	$(UTIL_GET_JHALFS_SH)

$(JHALFS_CONFIG) : $(JHALFS_GIT_DIR)
jhalfs-config $(JHALFS_CONFIG) :
	@echo
	@$(call bold_message, Configuring jhalfs...)
	$(BL_JHALFS_CONFIG_SH)

jhalfs-lfs $(JHALFS_LFS) :
	@echo
	@$(call bold_message, Installing jhalfs to $(LFS)...)
	$(BL_JHALFS_MNT_SH)

difflog-convert $(DIFFLOG_CONVERT) :
	@echo
	@$(call bold_message, Converting scripts for difflog...)
	$(BL_DIFFLOG_CONVERT_SH)


.PHONY: build-lfs-jhalfs clean-build-lfs-jhalfs


#------------------------------------------------------------------#
build-lfs-archives: $(JHALFS_BUILD) $(CHROOT_SCRIPTS) $(ARCHIVE_MNT)

$(JHALFS_BUILD : $(JHALFS_MNT) $(DIFFLOG_CONVERT)
jhalfs-build $(JHALFS_BUILD) :
	@echo
	@$(call bold_message, Building LFS...)
	$(BL_JHALFS_BUILD_SH)

chroot-scripts $(CHROOT_SCRIPTS) :
	@echo
	@$(call bold_message, Installing chroot scripts...)
	$(BL_CHROOT_SCRIPTS_SH)

$(ARCHIVE_MNT): $(CHROOT_SCRIPTS)
archive-mnt $(ARCHIVE_MNT) :
	@echo
	@$(call bold_message, Running chroot scripts...)
	$(BL_RUN_CHROOT_SH)
