####################################################################
#
# setup.makefile
#
####################################################################


SETUP_SCRIPTS = $(SCRIPTS_DIR)/setup

SETUP_LFS_DIFFLOG_SH = $(SETUP_SCRIPTS)/setup-lfs-difflog.sh
SETUP_LFS_JHALFS_SH = $(SETUP_SCRIPTS)/setup-lfs-jhalfs.sh
SETUP_BLFS_WORK_SH = $(SETUP_SCRIPTS)/setup-blfs-work.sh

export


#------------------------------------------------------------------#

setup-lfs-difflog :
	@echo
	@$(call bold_message, $@)
	$(SETUP_LFS_DIFFLOG_SH)


#------------------------------------------------------------------#

setup-lfs-jhalfs :
	@echo
	@$(call bold_message, $@)
	$(SETUP_LFS_JHALFS_SH)


#------------------------------------------------------------------#

setup-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(SETUP_BLFS_WORK_SH)

