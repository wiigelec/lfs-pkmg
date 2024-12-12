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


.PHONY: 


#------------------------------------------------------------------#

list-blah-blah : 
	@echo
	@$(call done_message, Generating package install config in...)
	$(PKGINST_CONFIG_IN_SH)

.PHONY:

