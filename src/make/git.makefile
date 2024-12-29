####################################################################
#
# git.makefile
#
####################################################################

#------------------------------------------------------------------#
# DEFINITIONS
#------------------------------------------------------------------#

### TARGET DEFS ###

# directories
BLFS_GIT_DIR = $(BLD_DIR)/git/blfs-book
LFS_GIT_DIR = $(BLD_DIR)/git/lfs-book
JHALFS_GIT_DIR = $(BLD_DIR)/git/jhalfs

# target files

# target scripts


### OTHER DEFS ###

BLFS_GIT_URL = https://git.linuxfromscratch.org/blfs
LFS_GIT_URL = https://git.linuxfromscratch.org/lfs
JHALFS_GIT_URL = https://git.linuxfromscratch.org/jhalfs

export


#------------------------------------------------------------------#
# TARGETS
#------------------------------------------------------------------#

#------------------------------------------------------------------#
git-lfs:
	@echo
	@$(call bold_message, $@)
	@if [ ! -d $(LFS_GIT_DIR) ]; then git clone $(LFS_GIT_URL) $(LFS_GIT_DIR);\
	 else pushd $(LFS_GIT_DIR)>/dev/null; git pull; popd>/dev/null; fi 

.PHONY: git-lfs


#------------------------------------------------------------------#
git-blfs:
	@echo
	@$(call bold_message, $@)
	@if [ ! -d $(BLFS_GIT_DIR) ]; then git clone $(BLFS_GIT_URL) $(BLFS_GIT_DIR);\
	 else pushd $(BLFS_GIT_DIR)>/dev/null; git pull; popd>/dev/null; fi 

.PHONY: git-blfs


#------------------------------------------------------------------#
git-jhalfs:
	@echo
	@$(call bold_message, $@)
	@if [ ! -d $(JHALFS_GIT_DIR) ]; then git clone $(JHALFS_GIT_URL) $(JHALFS_GIT_DIR);\
	 else pushd $(JHALFS_GIT_DIR)>/dev/null; git pull; popd>/dev/null; fi 

.PHONY: git-jhalfs

