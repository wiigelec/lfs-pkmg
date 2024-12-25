####################################################################
#
# auto.makefile
#
####################################################################


#------------------------------------------------------------------#

auto : git-lfs git-blfs select-action-params
	$(ACTION_LAUNCH_SH)

#------------------------------------------------------------------#
AUDITLP : 

#------------------------------------------------------------------#
AUDITOP : 

#------------------------------------------------------------------#
AUDITPF : 

#------------------------------------------------------------------#
AUDITSF : 

#------------------------------------------------------------------#
BOOTSTRAPWORK : build-bootstrap-work build-bootstrap-archives
	@echo
	@$(call done_message, Success! Bootstrap complete.)

#------------------------------------------------------------------#
BUILDLFS : git-jhalfs $(SETUP_LFS_JHALFS) $(SETUP_LFS_DIFFLOG) \
       build-lfs $(SETUP_LFS_CHROOT) build-lfs-chroot	
	@echo
	@$(call done_message, Success! LFS build complete.)

#------------------------------------------------------------------#
BUILDBOOTSTRAP : $(BLFS_FULL_XML) book-blfs-pkglist $(BOOK_BLFS_DEPS) \
	$(BOOK_BLFS_SCRIPTS) setup-bootstrap-group book-blfs-trees \
	setup-blfs-work build-deploy-bootstrap
	@echo
	@$(call done_message, Success! Run 'make BOOTSTRAPWORK'.)

#------------------------------------------------------------------#
BUILDBLFS : $(BLFS_FULL_XML) book-blfs-pkglist $(BOOK_BLFS_DEPS) \
	$(BOOK_BLFS_SCRIPTS) select-blfs-packages book-blfs-trees \
	setup-blfs-work
	@echo
	@$(call done_message, Success! Run 'make BUILDWORK'.)

#------------------------------------------------------------------#
BUILDPATCH : 

#------------------------------------------------------------------#
BUILDWORK : build-blfs-work build-blfs-archives 
	@echo
	@$(call done_message, Success! Build complete.)

#------------------------------------------------------------------#
DOCSHTML : 

#------------------------------------------------------------------#
LISTDIR : list-create-dir
	@echo
	@$(call done_message, Success! Directory list created.)

#------------------------------------------------------------------#
LISTDEPS : $(BLFS_FULL_XML) $(BLFS_PKGLIST_XML) select-blfs-packages \
	$(BOOK_BLFS_DEPS) book-blfs-trees list-create-deps
	@echo
	@$(call done_message, Success! Dependency list created.)

#------------------------------------------------------------------#
LISTINSTALL : select-repo-lists list-install 
	@echo
	@$(call done_message, Success! List packages installed.)

#------------------------------------------------------------------#
LISTPATCH : 

#------------------------------------------------------------------#
LISTREMOVE : select-installed-lists list-remove
	@echo
	@$(call done_message, Success! List packages removed.)

#------------------------------------------------------------------#
LISTUPGRADE : 

#------------------------------------------------------------------#
PKGINSTALL : select-repo-packages package-install 
	@echo
	@$(call done_message, Success! Packages installed.)

#------------------------------------------------------------------#
PKGREMOVE : select-installed-packages package-remove
	@echo
	@$(call done_message, Success! Packages removed.)

#------------------------------------------------------------------#
PKGUPGRADE : select-repo-packages package-upgrade
	@echo
	@$(call done_message, Success! Packages upgraded.)

