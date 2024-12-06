####################################################################
#
# install.makefile
#
####################################################################


INSTALL:
	@echo
	@$(call bold_message, Launching INSTALL...)
	$(INSTALL_LAUNCH_INSTALL_SH)


####################################################################
# INDIVIDUAL
####################################################################

#------------------------------------------------------------------#
install-individual : install-config-in install-config-out install-package
	@echo
	@$(call done_message, SUCCESS! Package installed.)


.PHONY: install-individual


#------------------------------------------------------------------#

install-config-in : 
	@echo
	@$(call done_message, Generating install config in...)
	$(INSTALL_CONFIG_IN_SH)

install-config-out : 
	@echo
	@$(call done_message, Running package menuconfig...)
	$(INSTALL_CONFIG_OUT_SH)

install-package : 
	@echo
	@$(call done_message, Installing package...)
	$(INSTALL_PACKAGE_SH)

.PHONY: install-config-in install-config-out install-package
