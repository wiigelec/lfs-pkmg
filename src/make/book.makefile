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
	@$(call bold_message, Generating BLFS full xml...)
	@$(BOOK_BLFS_FULLXML_SH)

.PHONY: book-blfs-fullxml

#------------------------------------------------------------------#

book-blfs-pkglist :
	@echo
	@$(call bold_message, Generating BLFS package list...)
	$(BOOK_BLFS_PKGLIST_SH)

#------------------------------------------------------------------#

book-blfs-deps :
	@echo
	@$(call bold_message, Reading book dependencies...)
	$(BOOK_BLFS_DEPS_SH)

#------------------------------------------------------------------#

book-blfs-scripts :
	@echo
	@$(call bold_message, Generating build scrips...)
	$(BOOK_BLFS_SCRIPTS_SH)

#------------------------------------------------------------------#

book-blfs-trees :
	@echo
	@$(call bold_message, Generating dependency trees...)
	$(BOOK_BLFS_TREES_SH)

