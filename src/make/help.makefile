####################################################################
#
# help.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
DOC_TEXT = $(DOC_DIR)/text

# target files

# target scripts


### OTHER DEFS ###

# help files
AUDIT_HELP = $(DOC_TEXT)/audit.help
BUILD_BLFS_HELP = $(DOC_TEXT)/build-blfs.help
BUILD_BOOTSTRAP_HELP = $(DOC_TEXT)/build-bootstrap.help
BUILD_LFS_HELP = $(DOC_TEXT)/build-lfs.help
CREATE_LIST_DIR_HELP = $(DOC_TEXT)/create-list-dir.help
CREATE_LIST_DEPS_HELP = $(DOC_TEXT)/create-list-deps.help
INSTALL_LIST_HELP = $(DOC_TEXT)/install-list.help
INSTALL_PACKAGE_HELP = $(DOC_TEXT)/install-package.help
REMOVE_LIST_HELP = $(DOC_TEXT)/remove-list.help
REMOVE_PACKAGE_HELP = $(DOC_TEXT)/remove-package.help
TASK_HELP = $(DOC_TEXT)/task.help
UPGRADE_LIST_HELP = $(DOC_TEXT)/upgrade-list.help
UPGRADE_PACKAGE_HELP = $(DOC_TEXT)/upgrade-package.help



#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
help:
	@cat $(TASK_HELP)

.PHONY: help


#------------------------------------------------------------------#
help-audit:
	@cat $(AUDIT_HELP)

.PHONY: audit


#------------------------------------------------------------------#
help-build-blfs:
	@cat $(BUILD_BLFS_HELP)

.PHONY: help-build-blfs


#------------------------------------------------------------------#
help-build-bootstrap:
	@cat $(BUILD_BOOTSTRAP_HELP)

.PHONY: help-build-bootstrap


#------------------------------------------------------------------#
help-build-lfs:
	@cat $(BUILD_LFS_HELP)

.PHONY: help-build-lfs


#------------------------------------------------------------------#
help-create-list-dir:
	@cat $(CREATE_LIST_DIR_HELP)

.PHONY: help-create-list-dir


#------------------------------------------------------------------#
help-create-list-deps:
	@cat $(CREATE_LIST_DEPS_HELP)

.PHONY: help-create-list-deps


#------------------------------------------------------------------#
help-install-list:
	@cat $(INSTALL_LIST_HELP)

.PHONY: help-install-list


#------------------------------------------------------------------#
help-install-package:
	@cat $(INSTALL_PACKAGE_HELP)

.PHONY: help-install-package


#------------------------------------------------------------------#
help-remove-list:
	@cat $(REMOVE_LIST_HELP)

.PHONY: help-remove-list


#------------------------------------------------------------------#
help-remove-package:
	@cat $(REMOVE_PACKAGE_HELP)

.PHONY: help-remove-package


#------------------------------------------------------------------#
help-upgrade-list:
	@cat $(UPGRADE_LIST_HELP)

.PHONY: help-upgrade-list


#------------------------------------------------------------------#
help-upgrade-package:
	@cat $(UPGRADE_PACKAGE_HELP)

.PHONY: help-upgrade-package

