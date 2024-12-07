####################################################################
#
# remove.makefile
#
####################################################################


REMOVE:
	@echo
	@$(call bold_message, Launching REMOVE...)
	$(REMOVE_LAUNCH_SH)


####################################################################
# INDIVIDUAL
####################################################################

#------------------------------------------------------------------#
remove-individual : remove-config-in remove-config-out remove-package
	@echo
	@$(call done_message, SUCCESS! Package removed.)


.PHONY: remove-individual


#------------------------------------------------------------------#

remove-config-in : 
	@echo
	@$(call done_message, Generating remove config in...)
	$(REMOVE_CONFIG_IN_SH)

remove-config-out : 
	@echo
	@$(call done_message, Running package menuconfig...)
	$(REMOVE_CONFIG_OUT_SH)

remove-package : 
	@echo
	@$(call done_message, Remove package...)
	$(REMOVE_PACKAGE_SH)

.PHONY: remove-config-in remove-config-out remove-package
