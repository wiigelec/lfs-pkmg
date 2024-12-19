####################################################################
#
# install.makefile
#
####################################################################


PACKAGE:
	@echo
	@$(call bold_message, Launching PACKAGE...)
	$(PACKAGE_LAUNCH_SH)


####################################################################
# INSTALL
####################################################################

#------------------------------------------------------------------#
package-install : pkginst-config-in pkginst-config-out pkginst
	@echo
	@$(call done_message, SUCCESS! Package\(s\) installed.)


.PHONY: package-install


#------------------------------------------------------------------#

pkginst-config-in : 
	@echo
	@$(call done_message, Generating package install config in...)
	$(PKGINST_CONFIG_IN_SH)

pkginst-config-out : 
	@echo
	@$(call done_message, Running package install menuconfig...)
	$(PKGINST_CONFIG_OUT_SH)

pkginst : 
	@echo
	@$(call done_message, Installing package...)
	$(PKGINST_SH)

.PHONY: pkginst-config-in pkginst-config-out pgkinst



####################################################################
# REMOVE
####################################################################

#------------------------------------------------------------------#
package-remove : pkgrem-config-in pkgrem-config-out pkgrem
	@echo
	@$(call done_message, SUCCESS! Package\(s\) removed.)


.PHONY: package-remove

#------------------------------------------------------------------#

pkgrem-config-in :
	@echo
	@$(call done_message, Generating package remove config in...)
	$(PKGREM_CONFIG_IN_SH)

pkgrem-config-out :
	@echo
	@$(call done_message, Running package remove menuconfig...)
	$(PKGREM_CONFIG_OUT_SH)

pkgrem :
	@echo
	@$(call done_message, Removing package...)
	$(PKGREM_SH)

.PHONY: pkgrem-config-in pkgrem-config-out pkgrem



####################################################################
# UPGRADE
####################################################################

#------------------------------------------------------------------#
package-upgrade : pkgupgr-config-in pkgupgr-config-out pkgupgr
	@echo
	@$(call done_message, SUCCESS! Package\(s\) upgraded.)


.PHONY: package-upgrade

#------------------------------------------------------------------#

pkgupgr-config-in :
	@echo
	@$(call done_message, Generating upgrade config in...)
	$(PKGUPGR_CONFIG_IN_SH)

pkgupgr-config-out : 
	@echo
	@$(call done_message, Running package menuconfig...)
	$(PKGUPGR_CONFIG_OUT_SH)

pkgupgr :
	@echo
	@$(call done_message, Upgrading package...)
	$(PKGUPGR_SH)

.PHONY: pkgupgr-config-in pkgupgr-config-out pkgupgr-package

