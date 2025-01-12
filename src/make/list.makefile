####################################################################
#
# list.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
LIST_SCRIPTS = $(SRC_SCRIPTS)/list

# target files

# target scripts
LIST_CREATE_CUST_SH = $(LIST_SCRIPTS)/list-create-cust.sh
LIST_CREATE_DIR_SH = $(LIST_SCRIPTS)/list-create-dir.sh
LIST_CREATE_DEPS_SH = $(LIST_SCRIPTS)/list-create-deps.sh
LIST_INSTALL_SH = $(LIST_SCRIPTS)/list-install.sh
LIST_REMOVE_SH = $(LIST_SCRIPTS)/list-remove.sh
LIST_UPGRADE_SH = $(LIST_SCRIPTS)/list-upgrade.sh


### OTHER DEFS ###

USER_LIST = $(TOPDIR)/user/list




#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
list-create-cust:
	@echo
	@$(call bold_message, $@)
	$(LIST_CREATE_CUST_SH)

.PHONY: list-create-cust


#------------------------------------------------------------------#
list-create-dir:
	@echo
	@$(call bold_message, $@)
	$(LIST_CREATE_DIR_SH)

.PHONY: list-create-dir


#------------------------------------------------------------------#
list-create-deps:
	@echo
	@$(call bold_message, $@)
	$(LIST_CREATE_DEPS_SH)

.PHONY: list-create-deps


#------------------------------------------------------------------#
list-install:
	@echo
	@$(call bold_message, $@)
	$(LIST_INSTALL_SH)

.PHONY: list-install


#------------------------------------------------------------------#
list-remove:
	@echo
	@$(call bold_message, $@)
	$(LIST_REMOVE_SH)

.PHONY: list-remove


#------------------------------------------------------------------#
list-upgrade:
	@echo
	@$(call bold_message, $@)
	$(LIST_UPGRADE_SH)

.PHONY: list-upgrade

