#!/bin/bash
####################################################################
# 
# bs-deploy-work.sh
#
####################################################################

set -e

### CONFIRM ###
echo
read -p "Deploy bootstrap to $INSTALLROOT? (y) " confirm
if [[ $confirm != "y" ]]; then exit 1; fi


### DOWLOAD FILES ###

pushd $INSTALLROOT/sources > /dev/null
wgetlist=$(grep -r PKG_URL= $WORK_DIR/scripts)
for each in $wgetlist; do
	each=${each##*PKG_URL=}
	wget -nc $each
done
wgetlist=$(grep -r "wget h" $WORK_DIR/scripts)
for each in $wgetlist; do
	[[ $each == *"wget"* ]] && continue
	each=${each##*.build:}
	wget -nc $each
done
popd > /dev/null


### FIX SCRIPTS ###

echo
echo "Modifying work for bootstrap..."
echo

pushd $WORK_DIR/scripts > /dev/null
for each in ./*.build; do
	sed -i '/ROOT_EOF/d' $each
	sed -i 's/^wget/#wget/g' $each
	sed -i 's/SRC_DIR=\$SOURCE_DIR\/\$PKG_ID/SRC_DIR=\$SOURCE_DIR/g' $each
	sed -i 's/\.\.\/\$PACKAGE/\$PACKAGE/g' $each
	sed -i 's/mv \$PACKAGE \.\//true/g' $each
	sed -i 's/\(rm -rf \$SRC_DIR\)/true #\1/g' $each
done
popd > /dev/null



### FIX MAKEFILE ###

makefile=$WORK_DIR/Makefile
sed -i "5 i DIFFLOG_DIR=$DIFFLOG_DIR" $makefile
sed -i "6 i export" $makefile
sed -i '/TIMER_SCRIPT/d' $makefile

sudo mkdir -p ${INSTALLROOT}/$DIFFLOG_DIR


### COPY WORK DIR ###
sourcework=$INSTALLROOT/sources/work
workscripts=$sourcework/scripts
cp -r $WORK_DIR $INSTALLROOT/sources/
cp $UTIL_CREATE_PKGLOG_SH $workscripts/
cp $UTIL_CREATE_ARCHIVE_SH $workscripts/


### CHROOT BUILD ###

# confirm
echo
read -p "Run boostrap chroot build on $INSTALLROOT? (y) " confirm
if [[ $confirm != "y" ]]; then exit 1; fi

# mount kernfs
sudo -E $UTIL_MOUNT_KERNFS_SH

# resolv.conf
resolvconf=$INSTALLROOT/etc/resolv.conf
[[ -f $resolvconf ]] && sudo rm $resolvconf
echo "nameserver 8.8.8.8" | sudo tee -a $resolvconf > /dev/null

sudo chroot $INSTALLROOT make -C /sources/work


### BUILD PACKAGES ###

workscripts=/sources/work/scripts

echo
echo "Building pkglogs..."
echo
sudo chroot $INSTALLROOT bash -e -c "DIFFLOG_DIR=$DIFFLOG_DIR PKGLOG_DIR=$PKGLOG_DIR $workscripts/util-create-pkglog.sh"

echo
echo "Building packages..."
echo
sudo chroot $INSTALLROOT bash -e -c "PKGLOG_DIR=$PKGLOG_DIR ARCHIVE_DIR=$ARCHIVE_DIR LFS_VER=$BLFSBRANCH $workscripts/util-create-archive.sh"


### CLEANUP ###

sudo -E $UTIL_UMOUNT_KERNFS_SH
