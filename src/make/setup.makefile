####################################################################
#
# setup.makefile
#
####################################################################


SETUP_SCRIPTS = $(SCRIPTS_DIR)/setup

SETUP_LFS_JHALFS = $(JHALFS_DIR)/setup-lfs-jhalfs
SETUP_LFS_DIFFLOG = $(JHALFS_DIR)/setup-lfs-difflog
SETUP_LFS_CHROOT = $(JHALFS_DIR)/setup-lfs-chroot

SETUP_LFS_CHROOT_SH = $(SETUP_SCRIPTS)/setup-lfs-chroot.sh
SETUP_LFS_DIFFLOG_SH = $(SETUP_SCRIPTS)/setup-lfs-difflog.sh
SETUP_LFS_JHALFS_SH = $(SETUP_SCRIPTS)/setup-lfs-jhalfs.sh
SETUP_BLFS_WORK_SH = $(SETUP_SCRIPTS)/setup-blfs-work.sh

export


#------------------------------------------------------------------#

setup-lfs-chroot $(SETUP_LFS_CHROOT) :
	@echo
	@$(call bold_message, setup-lfs-chroot)
	$(SETUP_LFS_CHROOT_SH)
	@touch $(SETUP_LFS_CHROOT)


#------------------------------------------------------------------#

setup-lfs-difflog $(SETUP_LFS_DIFFLOG) :
	@echo
	@$(call bold_message, setup-lfs-difflog)
	$(SETUP_LFS_DIFFLOG_SH)
	@touch $(SETUP_LFS_DIFFLOG)


#------------------------------------------------------------------#

setup-lfs-jhalfs $(SETUP_LFS_JHALFS) :
	@echo
	@$(call bold_message, setup-lfs-jhalfs)
	$(SETUP_LFS_JHALFS_SH)
	@touch $(SETUP_LFS_JHALFS)


#------------------------------------------------------------------#

setup-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(SETUP_BLFS_WORK_SH)

