####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################


include ./src/make/defs.makefile

include ./src/make/action.makefile

include ./src/make/build.makefile

include ./src/make/docs.makefile

#include ./src/make/makefile.install

#include ./src/make/makefile.remove

#include ./src/make/makefile.setup

#include ./src/make/makefile.upgrade

### NUKE ###
nuke : 
	-rm -rf $(BUILD_DIR)
