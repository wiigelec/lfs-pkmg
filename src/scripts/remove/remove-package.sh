#!/bin/bash
####################################################################
# 
# install-package.sh
#
####################################################################

set -e

### CONFIRM ###
echo
echo "Removing:"
echo
echo "$(cat $REMOVE_PKG_LIST | xargs)"
echo
echo "from $INSTALLROOT"
echo
echo
read -p "Continue? (Yes): " confirm
[[ $confirm != "Yes" ]] && echo "Cancelling..." && exit 1

sudo -E sh -e << ROOT_EOF

echo

tmpdir=\$INSTALLROOT/tmp/lfspkmg\$RANDOM
sudo mkdir -p \$tmpdir

while IFS= read -r line;
do

	### REMOVE ###
	echo
	echo -n "Removing \$line from \$INSTALLROOT..."
	
	### INSTALLED FILE LIST ###
        ifl=\$INSTALLROOT/\$INSTALLED_DIR/\$line
	lfi=\$tmpdir/lfi
	tac \$ifl > \$lfi

	cnt=1

	while IFS= read -r remove;
	do
		# check installed other
		ex=\${ifl##*/}
		[[ ! -z \$(grep -r --exclude \$ex "\$remove" \$INSTALLROOT/\$INSTALLED_DIR 2>/dev/null) ]] && continue

		remove=\${remove#/}
		remove=\$INSTALLROOT/\$remove
		
		remove=\$(echo \$remove | sed 's/ ->.*//g')

		rm -d \$remove 2> /dev/null || true
		[ \$cnt -eq 100 ] && echo -n "." && cnt=1
		((cnt++))

	done < \$lfi

	rm \$lfi
	rm \$ifl

        
done < \$REMOVE_PKG_LIST

rm -rf \$tmpdir

ROOT_EOF
