#!/bin/bash
####################################################################
# 
# bl-jhalfs-config.sh
#
####################################################################

#------------------------------------------------------------------#
# GENERATE CONFIGURATION FILE

pushd $JHALFS_GIT_DIR > /dev/null
cp $MISC_DIR/configuration ./ 

#------------------------------------------------------------------#
# SET CONFIG PARAMS

### REV ###
rev=$(grep CONFIG_SYSV=y $BL_CONFIG_OUT)
if [[ -z $rev ]]; then
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
branch=$(grep CONFIG_BRANCH_.*=y $BL_CONFIG_OUT)
branch=${branch##*_}
branch=${branch%=*}
sed -i "s/COMMIT=.*/COMMIT=\"$branch\"/" $JHALFS_CONFIG


### INSTALL ROOT ###
installroot=$(grep INSTALLROOT $BL_CONFIG_OUT)
installroot=${installroot##*=}
installroot=${installroot//\"/}
installroot=${installroot//\//\\\/}
sed -i "s/BUILDDIR=.*/BUILDDIR=\"$installroot\"/" $JHALFS_CONFIG


popd > /dev/null


#------------------------------------------------------------------#
# PACKAGE MANAGEMENT

cp $MISC_DIR/packageManager.xml $JHALFS_GIT_DIR/pkgmngt
cp $MISC_DIR/packInstall.sh $JHALFS_GIT_DIR/pkgmngt


### DISABLE PROMPTS ###
sed -i 's/read -r ANSWER/ANSWER=yes/g' $JHALFS_GIT_DIR/jhalfs
