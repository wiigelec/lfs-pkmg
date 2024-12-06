#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e

sudo -E sh -e << ROOT_EOF

[[ ! -d \$INSTALLED_DIR ]] && mkdir -p \$INSTALLROOT/\$INSTALLED_DIR

tmpdir=/tmp/lfspkmg/\$RANDOM

sudo mkdir -p \$tmpdir

pushd \$INSTALLROOT > /dev/null

echo

while IFS= read -r line;
do

	### CHECK INSTALLED ###
	ifl=\${line%.txz}
	ifl=\$INSTALLROOT/\$INSTALLED_DIR/\$ifl
	[[ -f \$ifl ]] && echo "Skipping \$line: INSTALLED" && continue 


	### DOWNLOAD ###
	echo "Downloading \$line..."
	sudo curl --silent -o \$tmpdir/\$line \$ARCHIVEPATH/\$line

	### INSTALL ###
	echo "Installing \$line to \$INSTALLROOT..."
	tar --keep-directory-symlink -xpf \$tmpdir/\$line

	### INSTALLED FILE LIST ###
	tar -tvf \$tmpdir/\$line | sed 's/.* \.//g' | sed '/^\/$/d' > \$ifl

        
done < \$INSTALL_PKG_LIST

popd > /dev/null

rm -rf \$tmpdir

ROOT_EOF
