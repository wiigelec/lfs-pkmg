####################################################################
#
# package.makefile
#
####################################################################


PACKAGE_SCRIPTS = $(SCRIPTS_DIR)/package

PACKAGE_INSTALL_SH = $(PACKAGE_SCRIPTS)/package-install.sh
PACKAGE_REMOVE_SH = $(PACKAGE_SCRIPTS)/package-remove.sh

export


#------------------------------------------------------------------#

package-install :
	@echo
	@$(call bold_message, Installing packages...)
	$(PACKAGE_INSTALL_SH)


#------------------------------------------------------------------#

package-remove :
	@echo
	@$(call bold_message, Removing packages...)
	$(PACKAGE_REMOVE_SH)

