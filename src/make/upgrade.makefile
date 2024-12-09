####################################################################
#
# install.makefile
#
####################################################################


UPGRADE:
	@echo
	@$(call bold_message, Launching UPGRADE...)
	$(UPGRADE_LAUNCH_SH)


####################################################################
# INDIVIDUAL
####################################################################

#------------------------------------------------------------------#
upgrade-individual : upgrade-config-in upgrade-config-out upgrade-package
	@echo
	@$(call done_message, SUCCESS! Package\(s\) upgraded.)


.PHONY: upgrade-individual


#------------------------------------------------------------------#

upgrade-config-in : 
	@echo
	@$(call done_message, Generating upgrade config in...)
	$(UPGRADE_CONFIG_IN_SH)

upgrade-config-out : 
	@echo
	@$(call done_message, Running package menuconfig...)
	$(UPGRADE_CONFIG_OUT_SH)

upgrade-package : 
	@echo
	@$(call done_message, Upgrading package...)
	$(UPGRADE_PACKAGE_SH)

.PHONY: upgrade-config-in upgrade-config-out upgrade-package
