####################################################################
#
# setup.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
SETUP_SCRIPTS = $(SRC_SCRIPTS)/setup

# target files
SETUP_LFS_CHROOT = $(JHALFS_DIR)/setup-lfs-chroot
SETUP_LFS_DIFFLOG = $(JHALFS_DIR)/setup-lfs-difflog
SETUP_LFS_JHALFS = $(JHALFS_DIR)/setup-lfs-jhalfs

# target scripts
SETUP_BOOTSTRAP_GROUP_SH = $(SETUP_SCRIPTS)/setup-bootstrap-group.sh
SETUP_LFS_CHROOT_SH = $(SETUP_SCRIPTS)/setup-lfs-chroot.sh
SETUP_LFS_DIFFLOG_SH = $(SETUP_SCRIPTS)/setup-lfs-difflog.sh
SETUP_LFS_JHALFS_SH = $(SETUP_SCRIPTS)/setup-lfs-jhalfs.sh
SETUP_BLFS_WORK_SH = $(SETUP_SCRIPTS)/setup-blfs-work.sh


### OTHER DEFS ###



#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
setup-bootstrap-group :
	@echo
	@$(call bold_message, $@)
	$(SETUP_BOOTSTRAP_GROUP_SH)

.PHONY: setup-bootstrap-group


#------------------------------------------------------------------#
setup-lfs-chroot $(SETUP_LFS_CHROOT) :
	@echo
	@$(call bold_message, setup-lfs-chroot)
	$(SETUP_LFS_CHROOT_SH)
	@touch $(SETUP_LFS_CHROOT)

.PHONY: setup-lfs-chroot


#------------------------------------------------------------------#
setup-lfs-difflog $(SETUP_LFS_DIFFLOG) :
	@echo
	@$(call bold_message, setup-lfs-difflog)
	$(SETUP_LFS_DIFFLOG_SH)
	@touch $(SETUP_LFS_DIFFLOG)

.PHONY: setup-lfs-difflog


#------------------------------------------------------------------#
setup-lfs-jhalfs $(SETUP_LFS_JHALFS) :
	@echo
	@$(call bold_message, setup-lfs-jhalfs)
	$(SETUP_LFS_JHALFS_SH)
	@touch $(SETUP_LFS_JHALFS)

.PHONY: setup-lfs-jhafs


#------------------------------------------------------------------#
setup-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(SETUP_BLFS_WORK_SH)

.PHONY: setup-blfs-work


