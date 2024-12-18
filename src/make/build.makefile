####################################################################
#
# build.makefile
#
####################################################################

BUILD:
	@echo
	@$(call bold_message, Launching BUILD...)
	$(BUILD_LAUNCH_SH)



####################################################################
# COMMON
####################################################################

$(LFS_FULL_XML): $(LFS_BOOK)
lfs-full-xml $(LFS_FULL_XML) :
	@echo
	@$(call bold_message, Generating LFS full xml...)
	$(BUILD_LFS_FULL_XML_SH)


$(BLFS_FULL_XML): $(BLFS_BOOK)
blfs-full-xml $(BLFS_FULL_XML) :
	@echo
	@$(call bold_message, Generating BLFS full xml...)
	$(BUILD_BLFS_FULL_XML_SH)


$(PKG_LFS_XML): $(LFS_FULL_XML) 
pkg-lfs-xml $(PKG_LFS_XML) :
	@echo
	@$(call bold_message, Building LFS package list xml...)
	$(BUILD_PKG_LFS_XML_SH)


pkg-blfs-xml :
	@echo
	@$(call bold_message, Building BLFS package list xml...)
	$(BUILD_PKG_BLFS_XML_SH)


blfs-deps $(BLFS_DEPS_DONE) :
	@echo
	@$(call bold_message, Building book deps...)
	$(BUILD_DEPS_SH)


blfs-trees :
	@echo
	@$(call bold_message, Building dependency trees...)
	$(BUILD_TREES_SH)


blfs-scripts $(BLFS_SCRIPTS_DONE) :
	@echo
	@$(call bold_message, Building scripts...)
	$(BUILD_SCRIPTS_SH)

blfs-init-work :
	@echo
	@$(call bold_message, Setting up work dir...)
	$(BUILD_INIT_WORK_SH)

build-work :
	@echo
	@$(call bold_message, Building work dir packages...)
	@$(eval BUILD_DIR = $(shell grep BUILD_DIR $(ACTION_CURRENT_CONFIG) | sed 's/BUILD_DIR=//'))
	@$(eval LFS_VER = $(shell xmllint --xpath "/book/bookinfo/subtitle/text(\)" $BLFS_FULL_XML | sed 's/Version //' | sed 's/-/\./'))
	@$(MAKE) -C $(BUILD_DIR)/work
	@$(shell sudo -E $(UTIL_CREATE_PKGLOG_SH))
	@$(shell sudo -E LFS_VER=$(LFS_VER) $(UTIL_CREATE_ARCHIVE_SH))


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



####################################################################
# BLFS
####################################################################


build-blfs : $(BLFS_FULL_XML) pkg-blfs-xml $(BLFS_DEPS_DONE) $(BLFS_SCRIPTS_DONE) \
	bb-config-in bb-config-out bb-build-list blfs-trees \
	blfs-init-work
	@echo
	@$(call done_message, SUCCESS! Work dir initialized. Run \'make build-work\' to build packages.)

bb-config-in :
	@echo
	@$(call bold_message, Generating build BLFS config in...)
	$(BB_CONFIG_IN_SH)

bb-config-out :
	@echo
	@$(call bold_message, Generating build BLFS menuconfig...)
	$(BB_CONFIG_OUT_SH)

bb-build-list :
	@echo
	@$(call bold_message, Generating BLFS build list...)
	$(BB_BUILD_LIST_SH)

bb-build : 
	@echo
	@$(call bold_message, Building packages...)
	$(BUILD_BLFS_SH)



####################################################################
# BOOTSTRAP
####################################################################


build-bootstrap : $(BLFS_FULL_XML) pkg-blfs-xml $(BLFS_DEPS_DONE) $(BLFS_SCRIPTS_DONE) \
	bs-build-list blfs-trees blfs-init-work bs-deploy-work
	@echo
	@$(call done_message, SUCCESS! Bootstrap package deployed to $(INSTALLROOT).)

bs-build-list :
	@echo
	@$(call bold_message, Generating bootstrap build list...)
	$(BS_BUILD_LIST_SH)

bs-deploy-work :
	@echo
	@$(call bold_message, Deploying  bootstrap work package...)
	$(BS_DEPLOY_WORK_SH)
