#!/bin/bash
####################################################################
# 
# book-lfs-pkglist.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

echo "Processing xml..."

[[ -z $LFS_VERS ]] && \
	echo -e "\n>>>>> No lfs version in $CURRENT_CONFIG. <<<<<\n" && \
	exit 1

xsltproc -o $LFS_PKGLIST_XML \
	--stringparam book-version $LFS_VERS \
        $LFS_PKGLIST_XSL $LFS_FULL_XML


# FIX VERSIONS

sed -i 's/\$\$.*-\(.*\)\$\$/\1/' $LFS_PKGLIST_XML


#------------------------------------------------------------------#
# UNVERSIONED
#------------------------------------------------------------------#

unversioned=$(grep -F "$" $LFS_PKGLIST_XML | sed 's/.*<id>\(.*\)<\/id>.*/\1/')
[[ ! -z $unversioned ]] && echo -e "\n>>>>> WARNING: the following packages are unversioned: <<<<<\n"
for each in $unversioned
do
        echo $each
done
[[ ! -z $unversioned ]] && echo


#------------------------------------------------------------------#
# UPDATE INSTALLED
#------------------------------------------------------------------#

installeddir=${INSTALLROOT}$LPM_INSTALLED
[[ ! -d $installeddir ]] && exit 0

echo "Adding installed..."
installed=$(ls $installeddir)
for i in $installed; do

        i=${i%--*}
        i=${i%--*}

        name=${i%--*}
        version=${i#*--}

        # strip pass 1
        name=${name%-pass1}

        # add/update version
        xsltproc --stringparam name $name --stringparam version $version -o $LFS_PKGLIST_XML $BLFS_PKGLIST_ADDINST_XSL $LFS_PKGLIST_XML

done

