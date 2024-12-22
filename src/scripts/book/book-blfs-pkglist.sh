#!/bin/bash
####################################################################
# 
# book-blfs-pkglist.sh
#
####################################################################

set -e
source $CURRENT_CONFIG


#------------------------------------------------------------------#
# GET VERSION INFO
#------------------------------------------------------------------#

kf6version=$(grep 'ln -sfv kf6' $BLFS_FULL_XML | sed 's/.* kf6-\(.*\) .*/\1/')


#------------------------------------------------------------------#
# PROCESS XML
#------------------------------------------------------------------#

echo "Processing xml..."

xsltproc -o $BLFS_PKGLIST_XML \
	--stringparam book-version $BOOK_VERS \
        --stringparam kf6-version $kf6version \
        $BLFS_PKGLIST_XSL $BLFS_FULL_XML


# FIX VERSIONS

sed -i 's/\$\$.*-\(.*\)\$\$/\1/' $BLFS_PKGLIST_XML


#------------------------------------------------------------------#
# UNVERSIONED
#------------------------------------------------------------------#

unversioned=$(grep -F "$" $BLFS_PKGLIST_XML | sed 's/.*<id>\(.*\)<\/id>.*/\1/')
[[ ! -z $unversioned ]] && echo -e "\nWARNING: the following packages are unversioned:\n"
for each in $unversioned
do
        echo $each
done

#------------------------------------------------------------------#
# UPDATE INSTALLED
#------------------------------------------------------------------#

echo "Adding installed..."
installed=$(ls ${INSTALLROOT}$INSTALLED_DIR)
for i in $installed; do

        i=${i%--*}
        i=${i%--*}

        name=${i%--*}
        version=${i#*--}

        # strip pass 1
        name=${name%-pass1}

        # add/update version
        xsltproc --stringparam name $name --stringparam version $version -o $BLFS_PKGLIST_XML $BLFS_PKGLIST_ADDINST_XSL $BLFS_PKGLIST_XML

done
