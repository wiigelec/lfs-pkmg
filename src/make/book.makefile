####################################################################
#
# book.makefile
#
####################################################################


BOOK_SCRIPTS = $(SCRIPTS_DIR)/book

BOOK_BLFS_DEPS_SH = $(BOOK_SCRIPTS)/book-blfs-deps.sh
BOOK_BLFS_SCRIPTS_SH = $(BOOK_SCRIPTS)/book-blfs-scripts.sh
BOOK_BLFS_TREES_SH = $(BOOK_SCRIPTS)/book-blfs-trees.sh
BOOK_BLFS_FULLXML_SH = $(BOOK_SCRIPTS)/book-blfs-fullxml.sh
BOOK_BLFS_PKGLIST_SH = $(BOOK_SCRIPTS)/book-blfs-pkglist.sh

export


#------------------------------------------------------------------#

book-blfs-fullxml $(BLFS_FULL_XML) :
	@echo
	@$(call bold_message, blfs-full-xml)
	@$(BOOK_BLFS_FULLXML_SH)

.PHONY: book-blfs-fullxml

#------------------------------------------------------------------#

book-blfs-pkglist $(BLFS_PKGLIST_XML) :
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
	@$(call bold_message, $@)
	$(BOOK_BLFS_SCRIPTS_SH)
	@touch $(BOOK_BLFS_SCRIPTS)

#------------------------------------------------------------------#

book-blfs-trees :
	@echo
	@$(call bold_message, $@)
	$(BOOK_BLFS_TREES_SH)

