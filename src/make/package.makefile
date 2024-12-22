####################################################################
#
# package.makefile
#
####################################################################


PACKAGE_SCRIPTS = $(SCRIPTS_DIR)/package

PACKAGE_INSTALL_SH = $(PACKAGE_SCRIPTS)/package-install.sh
PACKAGE_REMOVE_SH = $(PACKAGE_SCRIPTS)/package-remove.sh
PACKAGE_UPGRADE_SH = $(PACKAGE_SCRIPTS)/package-upgrade.sh

export


#------------------------------------------------------------------#

package-install :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_INSTALL_SH)


#------------------------------------------------------------------#

package-remove :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_REMOVE_SH)


#------------------------------------------------------------------#

package-upgrade :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_UPGRADE_SH)
