####################################################################
#
# install.makefile
#
####################################################################


LIST:
	@echo
	@$(call bold_message, Launching LIST...)
	$(LIST_LAUNCH_SH)


####################################################################
# CREATE DIR
####################################################################

#------------------------------------------------------------------#
list-create-dir :
	@echo
	$(LIST_CREATEDIR_SH)
	@$(call done_message, SUCCESS! List created.)

.PHONY: list-create-dir 



####################################################################
# INSTALL
####################################################################

#------------------------------------------------------------------#
list-install : listinst-config-in listinst-config-out listinst
	@echo
	@$(call done_message, SUCCESS! List installed to $(INSTALLROOT).)

.PHONY: list-install

#------------------------------------------------------------------#

listinst-config-in : 
	@echo
	@$(call done_message, Generating list install config in...)
	$(LISTINST_CONFIG_IN_SH)

listinst-config-out : 
	@echo
	@$(call done_message, Running list install menuconfig...)
	$(LISTINST_CONFIG_OUT_SH)

listinst : 
	@echo
	@$(call done_message, Installing list packages...)
	$(LISTINST_SH)

.PHONY:

