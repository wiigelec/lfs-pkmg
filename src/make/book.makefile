####################################################################
#
# book.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
BOOK_SCRIPTS = $(SRC_SCRIPTS)/book

# target files
BOOK_BLFS_DEPS = $(BUILD_DIR)/book-blfs-deps
BOOK_LFS_SCRIPTS = ${BUILD_DIR}/book-lfs-scripts
BOOK_BLFS_SCRIPTS = ${BUILD_DIR}/book-blfs-scripts
LFS_FULL_XML = $(BUILD_XML)/lfs-full.xml
LFS_PKGLIST_XML = $(BUILD_XML)/lfs-pkglist.xml
BLFS_FULL_XML = $(BUILD_XML)/blfs-full.xml
BLFS_PKGLIST_XML = $(BUILD_XML)/blfs-pkglist.xml

# target scripts
BOOK_LFS_FULLXML_SH = $(BOOK_SCRIPTS)/book-lfs-fullxml.sh
BOOK_LFS_PKGLIST_SH = $(BOOK_SCRIPTS)/book-lfs-pkglist.sh
BOOK_LFS_SCRIPTS_SH = $(BOOK_SCRIPTS)/book-lfs-scripts.sh
BOOK_BLFS_DEPS_SH = $(BOOK_SCRIPTS)/book-blfs-deps.sh
BOOK_BLFS_SCRIPTS_SH = $(BOOK_SCRIPTS)/book-blfs-scripts.sh
BOOK_BLFS_TREES_SH = $(BOOK_SCRIPTS)/book-blfs-trees.sh
BOOK_BLFS_FULLXML_SH = $(BOOK_SCRIPTS)/book-blfs-fullxml.sh
BOOK_BLFS_PKGLIST_SH = $(BOOK_SCRIPTS)/book-blfs-pkglist.sh


### OTHER DEFS ###




#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
book-blfs-fullxml :
	@echo
	@$(call bold_message, $@)
	$(BOOK_BLFS_FULLXML_SH)

.PHONY: book-blfs-fullxml


#------------------------------------------------------------------#
book-lfs-fullxml :
	@echo
	@$(call bold_message, $@)
	$(BOOK_LFS_FULLXML_SH)

.PHONY: book-blfs-fullxml


#------------------------------------------------------------------#
book-lfs-pkglist :
	@echo
	@$(call bold_message, $@)
	$(BOOK_LFS_PKGLIST_SH)

.PHONY: book-lfs-pkglist


#------------------------------------------------------------------#
book-lfs-scripts $(BOOK_LFS_SCRIPTS) :
	@echo
	@$(call bold_message, book-lfs-scripts)
	$(BOOK_LFS_SCRIPTS_SH)
	@touch $(BOOK_LFS_SCRIPTS)

.PHONY: book-lfs-scripts


#------------------------------------------------------------------#
book-blfs-pkglist :
	@echo
	@$(call bold_message, $@)
	$(BOOK_BLFS_PKGLIST_SH)

.PHONY: book-blfs-pkglist


#------------------------------------------------------------------#
book-blfs-deps $(BOOK_BLFS_DEPS) :
	@echo
	@$(call bold_message, book-blfs-deps)
	$(BOOK_BLFS_DEPS_SH)
	@touch $(BOOK_BLFS_DEPS)


#------------------------------------------------------------------#
book-blfs-scripts $(BOOK_BLFS_SCRIPTS) :
	@echo
	@$(call bold_message, book-blfs-scripts)
	$(BOOK_BLFS_SCRIPTS_SH)
	@touch $(BOOK_BLFS_SCRIPTS)

.PHONY: book-blfs-scripts


#------------------------------------------------------------------#
book-blfs-trees :
	@echo
	@$(call bold_message, $@)
	$(BOOK_BLFS_TREES_SH)


#------------------------------------------------------------------#
# CLEAN
#------------------------------------------------------------------#

clean-deps :
	-rm $(BOOK_BLFS_DEPS)

clean-fullxml :
	-rm $(BLFS_FULL_XML)

clean-scripts :
	-rm $(BOOK_BLFS_SCRIPTS)

clean-trees :
	-rm -rf $(DEPTREE_TREES)
