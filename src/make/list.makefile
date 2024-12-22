####################################################################
#
# list.makefile
#
####################################################################

LIST_SCRIPTS = $(SCRIPTS_DIR)/list

LIST_CREATE_DIR_SH = $(LIST_SCRIPTS)/list-create-dir.sh
LIST_CREATE_DEPS_SH = $(LIST_SCRIPTS)/list-create-deps.sh


#------------------------------------------------------------------#

list-create-dir:
	@echo
	@$(call bold_message, $@)
	@$(LIST_CREATE_DIR_SH)


#------------------------------------------------------------------#

list-create-deps:
	@echo
	@$(call bold_message, $@)
	@$(LIST_CREATE_DEPS_SH)

