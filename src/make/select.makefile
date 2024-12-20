####################################################################
#
# select.makefile
#
####################################################################


SELECT_SCRIPTS = $(SCRIPTS_DIR)/select

SELECT_ACTION_PARAMS_SH = $(SELECT_SCRIPTS)/select-action-params.sh
SELECT_BLFS_PACKAGES_SH = $(SELECT_SCRIPTS)/select-blfs-packages.sh

export


#------------------------------------------------------------------#

select-action-params :
	@echo
	@$(call bold_message, Launching action menuconfig...)
	$(SELECT_ACTION_PARAMS_SH)

#------------------------------------------------------------------#

select-blfs-packages :
	@echo
	@$(call bold_message, Launching BLFS package menuconfig...)
	$(SELECT_BLFS_PACKAGES_SH)
