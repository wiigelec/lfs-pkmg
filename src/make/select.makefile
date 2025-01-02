####################################################################
#
# select.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
SELECT_SCRIPTS = $(SRC_SCRIPTS)/select

# target files

# target scripts
SELECT_ACTION_PARAMS_SH = $(SELECT_SCRIPTS)/select-action-params.sh
SELECT_BLFS_PACKAGES_SH = $(SELECT_SCRIPTS)/select-blfs-packages.sh
SELECT_INST_LISTS_SH = $(SELECT_SCRIPTS)/select-inst-lists.sh
SELECT_INST_PACKAGES_SH = $(SELECT_SCRIPTS)/select-inst-packages.sh
SELECT_REPO_LISTS_SH = $(SELECT_SCRIPTS)/select-repo-lists.sh
SELECT_REPO_PACKAGES_SH = $(SELECT_SCRIPTS)/select-repo-packages.sh


### OTHER DEFS ###




#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
select-action-params :
	@echo
	@$(call bold_message, $@)
	$(SELECT_ACTION_PARAMS_SH)

.PHONY: select-action-params


#------------------------------------------------------------------#
select-blfs-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_BLFS_PACKAGES_SH)

.PHONY: select-blfs-packages


#------------------------------------------------------------------#
select-installed-lists :
	@echo
	@$(call bold_message, $@)
	$(SELECT_INST_LISTS_SH)

.PHONY: select-installed-lists


#------------------------------------------------------------------#
select-installed-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_INST_PACKAGES_SH)

.PHONY: select-install-packages


#------------------------------------------------------------------#
select-repo-lists :
	@echo
	@$(call bold_message, $@)
	$(SELECT_REPO_LISTS_SH)

.PHONY: select-repo-lists


#------------------------------------------------------------------#
select-repo-packages :
	@echo
	@$(call bold_message, $@)
	$(SELECT_REPO_PACKAGES_SH)

.PHONY: select-repo-packages

