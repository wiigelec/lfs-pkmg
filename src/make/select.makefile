####################################################################
#
# select.makefile
#
####################################################################


SELECT_SCRIPTS = $(SCRIPTS_DIR)/select

SELECT_ACTION_PARAMS_SH = $(SELECT_SCRIPTS)/select-action-params.sh
SELECT_BLFS_PACKAGES_SH = $(SELECT_SCRIPTS)/select-blfs-packages.sh
SELECT_INST_PACKAGES_SH = $(SELECT_SCRIPTS)/select-inst-packages.sh
SELECT_REPO_PACKAGES_SH = $(SELECT_SCRIPTS)/select-repo-packages.sh

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


#------------------------------------------------------------------#

select-installed-packages :
	@echo
	@$(call bold_message, Launching installed package menuconfig...)
	$(SELECT_INST_PACKAGES_SH)


#------------------------------------------------------------------#

select-repo-packages :
	@echo
	@$(call bold_message, Launching repo package menuconfig...)
	$(SELECT_REPO_PACKAGES_SH)
