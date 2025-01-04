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
BOOK_BLFS_SCRIPTS = ${BUILD_DIR}/book-blfs-scripts
BLFS_FULL_XML = $(BUILD_XML)/blfs-full.xml
BLFS_PKGLIST_XML = $(BUILD_XML)/blfs-pkglist.xml

# target scripts
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
	@$(call bold_message, book-blfs-fullxml)
	$(BOOK_BLFS_FULLXML_SH)

.PHONY: book-blfs-fullxml


#------------------------------------------------------------------#
book-blfs-pkglist :
	@echo
	@$(call bold_message, book-blfs-pkglist)
	$(BOOK_BLFS_PKGLIST_SH)


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


#------------------------------------------------------------------#
book-blfs-trees :
	@echo
	@$(call bold_message, $@)
	$(BOOK_BLFS_TREES_SH)

