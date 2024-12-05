#!/bin/bash
####################################################################
# 
# bl-jhalfs-config.sh
#
####################################################################


#------------------------------------------------------------------#
# GENERATE CONFIGURATION FILE

pushd $JHALFS_GIT_DIR > /dev/null
cp $MISC_DIR/lfs/configuration ./ 

#------------------------------------------------------------------#
# SET CONFIG PARAMS

### REV ###
if [[ $REV == "SYSD" ]]; then
	rev=systemd
else
	rev=sysv
fi
if [[ $rev == "systemd" ]]; then

	sed -i "s/BOOK_LFS=y/# BOOK_LFS is not set/" $JHALFS_CONFIG
	sed -i "s/# BOOK_LFS_SYSD is not set/BOOK_LFS_SYSD=y/" $JHALFS_CONFIG
	sed -i "s/INITSYS=.*/INITSYS=\"systemd\"/" $JHALFS_CONFIG
fi

### BRANCH ###
sed -i "s/COMMIT=.*/COMMIT=\"$LFSBRANCH\"/" $JHALFS_CONFIG


### INSTALL ROOT ###
installroot=${INSTALLROOT//\//\\/}
sed -i "s/BUILDDIR=.*/BUILDDIR=\"$installroot\"/" $JHALFS_CONFIG


popd > /dev/null


#------------------------------------------------------------------#
# PACKAGE MANAGEMENT

cp $MISC_DIR/lfs/packageManager.xml $JHALFS_GIT_DIR/pkgmngt
cp $MISC_DIR/lfs/packInstall.sh $JHALFS_GIT_DIR/pkgmngt


### DISABLE PROMPTS ###
#sed -i 's/read -r ANSWER/ANSWER=yes/g' $JHALFS_GIT_DIR/jhalfs
