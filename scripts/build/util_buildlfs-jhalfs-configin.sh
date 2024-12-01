#!/bin/bash
####################################################################
# 
# util_buildlfs-jhalfs-configin.sh
#
####################################################################


### MODIFY CONFIG IN ###

modfile=$JHALFS_CONFIGIN.mod
cp $JHALFS_CONFIGIN $modfile

# rev
rev=$(xmllint --xpath "//rev/text()" $SETUP_CONFIG_XML)
revstring="BOOK_LFS"
if [[ $rev == "systemd" ]]; then
	revstring="BOOK_LFS_SYSD"
fi
line1=$(grep -n "prompt \"Use BOOK\"" $modfile | sed 's/:.*//')
sed -i "$((line1+1))s/^\(.*default \).*$/\1$revstring/" $modfile

# branch
branch=$(xmllint --xpath "//branch/text()" $SETUP_CONFIG_XML)
line1=$(grep -n "config[ ]*COMMIT" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^\(.*default.*[\"]\)\(.\).*$/\1$branch\"/" $modfile

# set build dir
sub=${LFS//\//\\\/}
line1=$(grep -n "config[ ]*BUILDDIR" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^.*$/default \"$sub\"/" $modfile

# build kernel
#sub=${BUILD_DIR//\//\\\/}
#line1=$(grep -n "config[ ]*CONFIG_BUILD_KERNEL" $modfile | sed 's/:.*//')
#sed -i "$((line1+2))s/^\(.*default \).*$/\1y/" $modfile
#line1=$(grep -n "string[ ]*\"Kernel config file\"" $modfile | sed 's/:.*//')
#sed -i "$((line1+1))s/^\(.*default.*[\"]\)\(.\).*$/\1$sub\/kernel-config\"/" $modfile

# enable package management
line1=$(grep -n "config[ ]*PKGMNGT" $modfile | sed 's/:.*//')
sed -i "$((line1+3))s/^\(.*default \).*$/\1y/" $modfile

# disable test
line1=$(grep -n "config[ ]*CONFIG_TESTS" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^\(.*default \).*$/\1n/" $modfile

# disable sbu report
line1=$(grep -n "config[ ]*REPORT" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^\(.*default \).*$/\1n/" $modfile

# enable package download
line1=$(grep -n "config[ ]*GETPKG" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^\(.*default \).*$/\1y/" $modfile
line1=$(grep -n "config[ ]*SRC_ARCHIVE" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^\(.*default.*[\"]\)\(.\).*$/\1\/sources\"/" $modfile

# hostname
line1=$(grep -n "config[ ]*HOSTNAME" $modfile | sed 's/:.*//')
sed -i "$((line1+2))s/^.*$/default \"lfs-build\"/" $modfile


### OUTPUT ###
cat $modfile

### CLEANUP ###
rm $modfile
