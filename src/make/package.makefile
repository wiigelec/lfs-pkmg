####################################################################
#
# package.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
PACKAGE_SCRIPTS = $(SRC_SCRIPTS)/package

# target files

# target scripts
PACKAGE_INSTALL_SH = $(PACKAGE_SCRIPTS)/package-install.sh
PACKAGE_REMOVE_SH = $(PACKAGE_SCRIPTS)/package-remove.sh
PACKAGE_UPGRADE_SH = $(PACKAGE_SCRIPTS)/package-upgrade.sh


### OTHER DEFS ###

INST_PKG_SH = $(SCRIPTS_FUNCS)/inst-pkg.sh
REMV_PKG_SH = $(SCRIPTS_FUNCS)/remv-pkg.sh
UPGR_PKG_SH = $(SCRIPTS_FUNCS)/upgr-pkg.sh



#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
package-install :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_INSTALL_SH)

.PHONY: package-install


#------------------------------------------------------------------#
package-remove :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_REMOVE_SH)

.PHONY: package-remove


#------------------------------------------------------------------#
package-upgrade :
	@echo
	@$(call bold_message, $@)
	$(PACKAGE_UPGRADE_SH)

.PHONY: package-upgrade

