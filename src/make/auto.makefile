####################################################################
#
# auto.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories

# target files

# target scripts
ACTION_LAUNCH_SH = $(SCRIPTS_FUNCS)/action-launch.sh


### OTHER DEFS ###

export


#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
auto : git-lfs git-blfs select-action-params
	$(MAKE) action-launch

.PHONY: auto

action-launch :
	$(ACTION_LAUNCH_SH)

.PHONY: action-launch


#------------------------------------------------------------------#
AUDITLP : 

#------------------------------------------------------------------#
AUDITOP : 

#------------------------------------------------------------------#
AUDITPF : 

#------------------------------------------------------------------#
AUDITSF : 

#------------------------------------------------------------------#
BUILDLFS : git-jhalfs $(SETUP_LFS_JHALFS) $(SETUP_LFS_DIFFLOG) \
       build-lfs $(SETUP_LFS_CHROOT) build-lfs-chroot	
	@echo
	@$(call done_message, Success! LFS build complete.)

.PHONY: BUILDLFS


#------------------------------------------------------------------#
BUILDBOOTSTRAP : $(BLFS_FULL_XML) book-blfs-pkglist $(BOOK_BLFS_DEPS) \
	$(BOOK_BLFS_SCRIPTS) setup-bootstrap-group book-blfs-trees \
	setup-blfs-work build-deploy-bootstrap
	@echo
	@$(call done_message, Success! Run 'make BOOTSTRAPWORK'.)

.PHONY: BUILDBOOTSTRAP


#------------------------------------------------------------------#
BUILDBLFS : $(BLFS_FULL_XML) book-blfs-pkglist $(BOOK_BLFS_DEPS) \
	$(BOOK_BLFS_SCRIPTS) select-blfs-packages book-blfs-trees \
	setup-blfs-work
	@echo
	@$(call done_message, Success! Run 'make BUILDWORK'.)

.PHONY: BUILDBLFS


#------------------------------------------------------------------#
BUILDPATCH : 

#------------------------------------------------------------------#
DOCSHTML : 

#------------------------------------------------------------------#
LISTDIR : list-create-dir
	@echo
	@$(call done_message, Success! Directory list created.)

.PHONY: LISTDIR


#------------------------------------------------------------------#
LISTDEPS : $(BLFS_FULL_XML) $(BLFS_PKGLIST_XML) select-blfs-packages \
	$(BOOK_BLFS_DEPS) book-blfs-trees list-create-deps
	@echo
	@$(call done_message, Success! Dependency list created.)

.PHONY: LISTDEPS


#------------------------------------------------------------------#
LISTINSTALL : select-repo-lists list-install 
	@echo
	@$(call done_message, Success! List packages installed.)

.PHONY: LISTINSTALL


#------------------------------------------------------------------#
LISTPATCH : 

#------------------------------------------------------------------#
LISTREMOVE : select-installed-lists list-remove
	@echo
	@$(call done_message, Success! List packages removed.)

.PHONY: LISTREMOVE


#------------------------------------------------------------------#
LISTUPGRADE : select-repo-lists list-upgrade
	@echo
	@$(call done_message, Success! List packages upgraded.)

#------------------------------------------------------------------#
PKGINSTALL : select-repo-packages package-install 
	@echo
	@$(call done_message, Success! Packages installed.)

.PHONY: PKGINSTALL


#------------------------------------------------------------------#
PKGREMOVE : select-installed-packages package-remove
	@echo
	@$(call done_message, Success! Packages removed.)

.PHONY: PKGREMOVE


#------------------------------------------------------------------#
PKGUPGRADE : select-repo-packages package-upgrade
	@echo
	@$(call done_message, Success! Packages upgraded.)

.PHONY: PKGUPGRADE


#------------------------------------------------------------------#
# BUILD WORK TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
BUILDARCHIVES : build-blfs-archives
	@echo
	@$(call done_message, Success! Archives complete.)

.PHONY: BUILDARCHIVES


#------------------------------------------------------------------#
BOOTSTRAPWORK : build-bootstrap-work build-bootstrap-archives
	@echo
	@$(call done_message, Success! Bootstrap complete.)

.PHONY: BOOTSTRAPWORK


#------------------------------------------------------------------#
BUILDWORK : build-blfs-work build-blfs-archives 
	@echo
	@$(call done_message, Success! Build complete.)

.PHONY: BUILDWORK

