####################################################################
#
# git.makefile
#
####################################################################


LFS_GIT_URL = https://git.linuxfromscratch.org/lfs
LFS_GIT_DIR = $(BUILD_DIR)/git/lfs-book

BLFS_GIT_URL = https://git.linuxfromscratch.org/blfs
BLFS_GIT_DIR = $(BUILD_DIR)/git/blfs-book

JHALFS_GIT_URL = https://git.linuxfromscratch.org/jhalfs
JHALFS_GIT_DIR = $(BUILD_DIR)/git/jhalfs


#------------------------------------------------------------------#

git-lfs:
	@echo
	@$(call bold_message, Downloading LFS book...)
	@git clone $(LFS_GIT_URL) $(LFS_GIT_DIR)

clean-git-lfs:
	@-rm -rf $(LFS_GIT_DIR)

.PHONY: git-lfs clean-git-lfs


#------------------------------------------------------------------#

git-blfs:
	@echo
	@$(call bold_message, Downloading BLFS book...)
	@git clone $(BLFS_GIT_URL) $(BLFS_GIT_DIR)

clean-git-blfs:
	@-rm -rf $(BLFS_GIT_DIR)

.PHONY: git-blfs clean-git-blfs


#------------------------------------------------------------------#

git-jhalfs:
	@echo
	@$(call bold_message, Downloading JHALFS...)
	@git clone $(JHALFS_GIT_URL) $(JHALFS_GIT_DIR)

clean-git-jhalfs:
	@-rm -rf $(JHALFS_GIT_DIR)

.PHONY: git-jhalfs clean-git-jhalfs

