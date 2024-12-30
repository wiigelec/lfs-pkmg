####################################################################
#
# audit.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
SCRIPTS_AUDIT = $(SRC_SCRIPTS)/audit

# target files

# target scripts
AUDIT_INSTALLED_PACKAGES_SH = $(SCRIPTS_AUDIT)/audit-installed-packages.sh
AUDIT_LIST_PACKAGES_SH = $(SCRIPTS_AUDIT)/audit-installed-files.sh
AUDIT_PACKAGE_FILES_SH = $(SCRIPTS_AUDIT)/audit-installed-files.sh
AUDIT_SYSTEM_FILES_SH = $(SCRIPTS_AUDIT)/audit-installed-files.sh


### OTHER DEFS ###


export


#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
audit-installed-packages:
	@echo
	@$(call bold_message, $@)
	$(AUDIT_INSTALLED_PACKAGES_SH)

.PHONY: audit-installed-packages


#------------------------------------------------------------------#
audit-list-packages:
	@echo
	@$(call bold_message, $@)
	$(AUDIT_LIST_PACKAGES_SH)

.PHONY: audit-list-packages


#------------------------------------------------------------------#
audit-package-files:
	@echo
	@$(call bold_message, $@)
	$(AUDIT_PACKAGE_FILES_SH)

.PHONY: audit-package-files


#------------------------------------------------------------------#
audit-system-files:
	@echo
	@$(call bold_message, $@)
	$(AUDIT_SYSTEM_FILES_SH)

.PHONY: audit-system-files
