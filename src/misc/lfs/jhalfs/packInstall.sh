# function for packing and installing a tree. We only have access
# to variables PKGDIR and PKG_DEST

packInstall() {

local PCKGVRS=$(basename $PKGDIR)
local TGTPKG=$(basename $PKG_DEST)
local PACKAGE=$(echo ${TGTPKG} | sed 's/^[0-9]\{3,4\}-//' |
           sed 's/^[0-9]\{2\}-//')
case $PCKGVRS in
  expect*|tcl*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*//') ;;
  vim*|unzip*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*\([0-9]\)\([0-9]\)/\1.\2/') ;;
  tidy*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*\([0-9]*\)/\1cvs/') ;;
  docbook-xml) local VERSION=4.5 ;;
  *) local VERSION=$(echo ${PCKGVRS} | sed 's/^.*-\([0-9]\)/\1/' |
                   sed 's/_/./g');;
# the last sed above is because dpkg does not want a '_' in version.
esac
local ARCHIVE_NAME=$(dirname ${PKGDIR})/${PACKAGE}_${VERSION}.tar
case $(uname -m) in
  x86_64) local ARCH=amd64 ;;
  *) local ARCH=i386 ;;
esac

pushd $PKG_DEST

### CREATE TAR ARCHIVE ###
ARCHIVE_NAME=${ARCHIVE_NAME##*/}
ARCHIVE_NAME=/tmp/$ARCHIVE_NAME
tar -cf $ARCHIVE_NAME .

### INSTALL TAR ARCHIVE ###
pushd /
tar -xf $ARCHIVE_NAME
popd


popd

rm $ARCHIVE_NAME

}
