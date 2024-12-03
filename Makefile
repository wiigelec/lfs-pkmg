####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################


### DEFINITIONS ###

include ./src/make/makefile.defs


### DEFAULT TARGET DOCS ###

include ./src/make/makefile.docs


### BUILD ###

include ./src/make/makefile.build


### INSTALL ###

#include ./src/make/makefile.install


### REMOVE  ###

#include ./src/make/makefile.remove


### SETUP ###

#include ./src/make/makefile.setup


### UPGRADE ###

#include ./src/make/makefile.upgrade


nuke : 
	-rm -rf $(BUILD_DIR)
