#!/bin/bash
####################################################################
# 
# build-deploy-bootstrap.sh
#
####################################################################

set -e


#------------------------------------------------------------------#
# DOWNLOAD FILES
#------------------------------------------------------------------#

### CONFIRM ###

echo
read -p "Deploy bootstrap to $INSTALLROOT? (y) " confirm
if [[ $confirm != "y" ]]; then exit 1; fi


### DOWNLOAD ###

echo "Downloading files..."

pushd $INSTALLROOT/sources > /dev/null
wgetlist=$(grep -r PKG_URL= $BUILD_WORK/scripts)
for each in $wgetlist; do
        each=${each##*PKG_URL=}
        wget -nc $each
done
wgetlist=$(grep -r "wget h" $BUILD_WORK/scripts)
for each in $wgetlist; do
        [[ $each == *"wget"* ]] && continue
        each=${each##*.build:}
        wget -nc $each
done
popd > /dev/null


#------------------------------------------------------------------#
# FIX
#------------------------------------------------------------------#

### FIX SCRIPTS ###

echo "Modifying work..."

pushd $BUILD_WORK/scripts > /dev/null
for each in ./*.build; do

	if [[ $each == *"postlfs-config-profile"* ]]; then
		sed -i 's/sudo \(sh -e << ROOT_EOF\)/\1/g' $each
	else
		sed -i '/ROOT_EOF/d' $each
	fi
        sed -i 's/^wget/#wget/g' $each
        sed -i 's/SRC_DIR=\$SOURCE_DIR\/\$PKG_ID/SRC_DIR=\$SOURCE_DIR/g' $each
        sed -i 's/\.\.\/\$PACKAGE/\$PACKAGE/g' $each
        sed -i 's/mv \$PACKAGE \.\//true/g' $each
        sed -i 's/\(rm -rf \$SRC_DIR\)/true #\1/g' $each
done
popd > /dev/null


### FIX MAKEFILE ###

makefile=$BUILD_WORK/Makefile
sed -i "5 i LPM_DIFFLOG=$LPM_DIFFLOG" $makefile
sed -i "6 i export" $makefile
sed -i '/TIMER_SCRIPT/d' $makefile

sudo mkdir -p ${INSTALLROOT}/$LPM_DIFFLOG


#------------------------------------------------------------------#
# COPY WORK DIR
#------------------------------------------------------------------#

echo "Copying scripts..."

### COPY WORK DIR ###
sourcework=$INSTALLROOT/sources/work
workscripts=$sourcework/scripts
cp -r $BUILD_WORK $INSTALLROOT/sources/


### PKGLOG ###
cp $BUILD_PKGLOGS_SH $workscripts/

### ARCHIVE ###
cp $BUILD_ARCHIVES_SH $workscripts/

