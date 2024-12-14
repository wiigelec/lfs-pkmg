####################################################################
#
# list.makefile
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
	@$(call done_message, SUCCESS! List $(LISTNAME) created.)

.PHONY: list-create-dir 



####################################################################
# INSTALL
####################################################################

#------------------------------------------------------------------#
list-install : listinst-config-in listinst-config-out listinst
	@echo
	@$(call done_message, SUCCESS! List\(s\) installed to $(INSTALLROOT).)

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

.PHONY: listinst-config-in listinst-config-out listinst



####################################################################
# REMOVE
####################################################################

#------------------------------------------------------------------#
list-remove : listrem-config-in listrem-config-out listrem
	@echo
	@$(call done_message, SUCCESS! List\(s\) removed from $(INSTALLROOT).)

.PHONY: list-remove

#------------------------------------------------------------------#

listrem-config-in : 
	@echo
	@$(call done_message, Generating list remove config in...)
	$(LISTREM_CONFIG_IN_SH)

listrem-config-out : 
	@echo
	@$(call done_message, Running list remove menuconfig...)
	$(LISTREM_CONFIG_OUT_SH)

listrem : 
	@echo
	@$(call done_message, Removing list packages...)
	$(LISTREM_SH)

.PHONY: listrem-config-in listrem-config-out listrem

