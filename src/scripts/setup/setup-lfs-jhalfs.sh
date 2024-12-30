#!/bin/bash
####################################################################
# 
# setup-lfs-jhalfs.sh
#
####################################################################

set -e
source $CURRENT_CONFIG 


#------------------------------------------------------------------#
# KERNEL CONFIG
#------------------------------------------------------------------#

kernelconfig=/sources/kernel-config
if [[ ! -f $kernelconfig ]]; then

	echo
	echo "No kernel config provided, default config will be used."
	read -p "Continue? (y) " confirm
	if [[ $confirm != "y" ]]; then 

		echo
		echo ">>>>> Please provide a valid kernel config file $kernelconfig to continue. <<<<<"
		echo
		exit 1 
	fi
fi


#------------------------------------------------------------------#
# INSTALL CONFIGURATION FILE
#------------------------------------------------------------------#

pushd $JHALFS_GIT_DIR > /dev/null
cp $LFS_JHALFS/configuration ./


#------------------------------------------------------------------#
# MODIFY CONFIG PARAMS
#------------------------------------------------------------------#

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


#------------------------------------------------------------------#
# INSTALL PACKAGE MANAGEMENT
#------------------------------------------------------------------#

cp $LFS_JHALFS/packageManager.xml $JHALFS_GIT_DIR/pkgmngt
cp $LFS_JHALFS/packInstall.sh $JHALFS_GIT_DIR/pkgmngt


#------------------------------------------------------------------#
# INSTALL LFS JHALFS
#------------------------------------------------------------------#

./jhalfs run

popd > /dev/null

if [[ -f $kernelconfig ]]; then cp -v $kernelconfig $INSTALLROOT/sources; fi

