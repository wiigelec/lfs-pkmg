####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################

#------------------------------------------------------------------#
default: 
	@echo -e "\nRun 'make help' for a list of help topics."


#------------------------------------------------------------------#

include ./src/make/audit.makefile

include ./src/make/auto.makefile

include ./src/make/book.makefile

include ./src/make/build.makefile

-include $(CURRENT_CONFIG)

include ./src/make/defs.makefile

include ./src/make/git.makefile

include ./src/make/help.makefile

include ./src/make/list.makefile

include ./src/make/package.makefile

include ./src/make/select.makefile

include ./src/make/setup.makefile

#------------------------------------------------------------------#
nuke: 
	-rm -rf $(BLD_DIR)
