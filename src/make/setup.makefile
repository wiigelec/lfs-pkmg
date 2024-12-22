####################################################################
#
# setup.makefile
#
####################################################################


SETUP_SCRIPTS = $(SCRIPTS_DIR)/setup

SETUP_BLFS_WORK_SH = $(SETUP_SCRIPTS)/setup-blfs-work.sh

export


#------------------------------------------------------------------#

setup-blfs-work :
	@echo
	@$(call bold_message, $@)
	$(SETUP_BLFS_WORK_SH)

