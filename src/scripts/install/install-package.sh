#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e

### CONFIRM ###
echo
echo "Installing:"
echo
echo "$(cat $INSTALL_PKG_LIST | xargs)"
echo
echo "to $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

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
	#echo "Downloading \$line..."
	sudo curl --silent -o \$tmpdir/\$line \$ARCHIVEPATH/\$line

	### GET EXTRACTED SIZE ###
	exsize=\$(xz -l \$tmpdir/\$line | tail -n1 | tr -s ' ' | cut -d' ' -f6-7)
	exsize=\${exsize// /+}
	exsize=\${exsize%iB}

	### FORMAT OUTPUT ###
	a="Installing+\$line+to+\$INSTALLROOT"
	b="+\$exsize"
	message=\$(printf "%-80s %15s" "\$a" "\$b")
        message=\${message// /.}
        message=\${message//+/ }

	### INSTALL ###
	echo "\$message"
	tar --keep-directory-symlink -xpf \$tmpdir/\$line

	### INSTALLED FILE LIST ###
	tar -tf \$tmpdir/\$line | sed 's/^\.//g' | sed '/^\/$/d' > \$ifl

        
done < \$INSTALL_PKG_LIST

popd > /dev/null

rm -rf \$tmpdir

ROOT_EOF
