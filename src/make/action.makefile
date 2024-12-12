####################################################################
#
# makefile.action
#
####################################################################


action : action-launch
clean-action : 
	@-rm $(ACTION_CONFIG_IN)
	@-rm $(ACTION_CONFIG_OUT)
	@-rm $(ACTION_CURRENT_CONFIG)


action-config-in : lfs-book blfs-book
	@echo
	@$(call bold_message, Generating action config in...)
	$(ACTION_CONFIG_IN_SH)

action-config-out : action-config-in
	@echo
	@$(call bold_message, Running action menuconfig...)
	$(ACTION_CONFIG_OUT_SH)

action-current-config : action-config-out 
	@echo
	@$(call bold_message, Generating current config...)
	$(ACTION_CURRENT_CONFIG_SH)

action-launch : action-current-config 
	@echo
	@$(call bold_message, Launching action...)
	$(ACTION_LAUNCH_SH)

lfs-book :
	@echo
	@$(call bold_message, Downloading LFS book...)
	$(UTIL_GET_LFSBOOK_SH)

blfs-book :
	@echo
	@$(call bold_message, Downloading BLFS book...)
	$(UTIL_GET_BLFSBOOK_SH)
	


.PHONY: action action-config-in action-config-out action-current-config \
       action-launch-action lfs-book blfs-book	

.PHONY: clean-action-config-in
