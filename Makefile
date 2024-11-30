####################################################################
#
# LFS PKMG MAKEFILE
#
####################################################################


### DEFINITIONS ###

include ./inc/makefile.defs


### DEFAULT TARGET DOCS ###

include ./inc/makefile.docs


### BUILD ###

include ./inc/makefile.build


### INSTALL ###

include ./inc/makefile.install


### REMOVE  ###

include ./inc/makefile.remove


### SETUP ###

include ./inc/makefile.setup


### UPGRADE ###

include ./inc/makefile.upgrade

nuke : clean-setup clean-build-lfs
	-rm -rf $(BUILD_DIR)
.PHONY: nuke
