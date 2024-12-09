####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################


include ./src/make/defs.makefile

include ./src/make/action.makefile

include ./src/make/build.makefile

include ./src/make/docs.makefile

include ./src/make/install.makefile

include ./src/make/remove.makefile

include ./src/make/upgrade.makefile

### NUKE ###
nuke : 
	-rm -rf $(BUILD_DIR)
