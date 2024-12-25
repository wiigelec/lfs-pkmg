####################################################################
#
# select.makefile
#
####################################################################


SELECT_SCRIPTS = $(SCRIPTS_DIR)/select

SELECT_ACTION_PARAMS_SH = $(SELECT_SCRIPTS)/select-action-params.sh
SELECT_BLFS_PACKAGES_SH = $(SELECT_SCRIPTS)/select-blfs-packages.sh
SELECT_INST_LISTS_SH = $(SELECT_SCRIPTS)/select-inst-lists.sh
SELECT_INST_PACKAGES_SH = $(SELECT_SCRIPTS)/select-inst-packages.sh
SELECT_REPO_LISTS_SH = $(SELECT_SCRIPTS)/select-repo-lists.sh
SELECT_REPO_PACKAGES_SH = $(SELECT_SCRIPTS)/select-repo-packages.sh

export


#------------------------------------------------------------------#

select-action-params :
	@echo
	@$(call bold_message, $@)
	$(SELECT_ACTION_PARAMS_SH)


#------------------------------------------------------------------#

select-blfs-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_BLFS_PACKAGES_SH)


#------------------------------------------------------------------#

select-installed-lists :
	@echo
	@$(call bold_message, $@)
	$(SELECT_INST_LISTS_SH)


#------------------------------------------------------------------#

select-installed-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_INST_PACKAGES_SH)


#------------------------------------------------------------------#

select-repo-lists :
	@echo
	@$(call bold_message, $@)
	$(SELECT_REPO_LISTS_SH)


#------------------------------------------------------------------#

select-repo-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_REPO_PACKAGES_SH)
