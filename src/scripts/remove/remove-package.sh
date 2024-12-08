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

	### INSTALLED FILE LIST ###
        ifl=\$INSTALLROOT/\$INSTALLED_DIR/\$line
	lfi=\$tmpdir/lfi
	tac \$ifl > \$lfi

	cnt=1
	filecnt=\$(wc -l < \$lfi)
	((filecnt*=2))

	
	### PASS 1 FILES
	while IFS= read -r remove;
	do
		# percent complete
		percomp=\$(printf %.0f "\$((10**4 * \$cnt/\$filecnt))e-2")
		a="Removing+\$line+from+\$INSTALLROOT+(\${filecnt}+entries)"
		b="+\$percomp+%"
		message=\$(printf "%-80s %15s" "\$a" "\$b")
		message=\${message// /.}
		message=\${message//+/ }
		echo -ne "\$message\033[0K\r"
		((cnt++))

		# parse symlinks
		remove=\$(echo \$remove | sed 's/ ->.*//g')

		# check dir
		[[ -d \$remove ]] && continue

		# check installed other
		ex=\${ifl##*/}
		[[ ! -z \$(grep -r --exclude \$ex "\$remove" \$INSTALLROOT/\$INSTALLED_DIR 2>/dev/null) ]] && continue

		remove=\${remove#/}
		remove=\$INSTALLROOT/\$remove

		#rm "\$remove" || true
		rm "\$remove" 2> /dev/null || true

	done < \$lfi

	### PASS 2 DIRS
	while IFS= read -r remove;
	do
		# percent complete
		percomp=\$(printf %.0f "\$((10**4 * \$cnt/\$filecnt))e-2")
		a="Removing+\$line+from+\$INSTALLROOT+(\${filecnt}+entries)"
		b="+\$percomp+%"
		message=\$(printf "%-80s %15s" "\$a" "\$b")
		message=\${message// /.}
		message=\${message//+/ }
		echo -ne "\$message\033[0K\r"
		((cnt++))

		# parse symlinks
		remove=\$(echo \$remove | sed 's/ ->.*//g')

		# check installed other
		ex=\${ifl##*/}
		[[ ! -z \$(grep -r --exclude \$ex "^\$remove$" \$INSTALLROOT/\$INSTALLED_DIR 2>/dev/null) ]] && continue

		remove=\${remove#/}
		remove=\$INSTALLROOT/\$remove

		#rm -d "\$remove" || true
		rm -d "\$remove" 2> /dev/null || true

	done < \$lfi

	echo

	rm \$lfi
	rm \$ifl

        
done < \$REMOVE_PKG_LIST

rm -rf \$tmpdir

ROOT_EOF
