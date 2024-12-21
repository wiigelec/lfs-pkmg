####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################

#------------------------------------------------------------------#
default: 
	@echo -e "\nrun make help for a list of topics"


#------------------------------------------------------------------#

include ./src/make/book.makefile

include ./src/make/build.makefile

include ./src/make/defs.makefile

include ./src/make/git.makefile

include ./src/make/select.makefile

include ./src/make/setup.makefile
