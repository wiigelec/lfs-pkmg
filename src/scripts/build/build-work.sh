#!/bin/bash
####################################################################
# 
# build-work.sh
#
####################################################################

set -e

####################################################################
# DEPENDENCIES
####################################################################

### INITIALIZE ###
[[ -d $WORK_DIR ]] && rm -rf $WORK_DIR
mkdir -p $WORK_DIR/{scripts,logs}
> $BB_BUILD_TREE


### PROCESS DEPENDENCIES ###
echo
echo "Processing dependencies..."
echo

packages=$(cat $BB_BUILD_LIST)
for p in $packages
do
	treefile=$TREE_DIR/${p}.tree
	while IFS= read -r treeline;
       	do
		echo -ne "$treeline\033[0K\r"

		# check version
		# handle pass1
		pass1=""
		[[ $treeline =~ "-pass1" ]] && pass1=${treeline} && treeline=${treeline%-pass1}
		iv=$(xmllint --xpath "//package[id='$treeline']/installed/text()" $PKG_BLFS_XML 2>/dev/null) || true
		bv=$(xmllint --xpath "//package[id='$treeline']/version/text()" $PKG_BLFS_XML 2>/dev/null)

		if [[ "$iv" == "$bv" ]]; then continue; fi

		[[ ! -z $pass1 ]] && treeline=$pass1
		[[ -z "$(grep -x $treeline $BB_BUILD_TREE)" ]] && echo $treeline >> $BB_BUILD_TREE
       	done < $treefile

done

echo -ne "\033[0K\r"


####################################################################
# BUILD SCRIPTS
####################################################################

### COPY BUILD SCRIPTS ###

echo
echo "Ordering build scripts..."
echo

# read tree file
cnt=1
while IFS= read -r line;
do
	file=""
	file=$(find $BLFS_SCRIPTS_DIR -name "$line.build")
	[ -z $file ] && echo "File $line not found in $BLFS_SCRIPTS_DIR." && continue

	# create ordered list
	if [ "$cnt" -lt 10 ]; then
		order="00$cnt"
        elif [ "$cnt" -lt 100 ]; then
		order="0$cnt"
	else
		order="$cnt"
	fi

	name=${file##*/}
	work_script=$WORK_DIR/scripts/$order-z-$name
	cp $file $work_script
	echo -ne "Copied ${work_script##*/}\033[0K\r"

	((cnt++))

done < $BB_BUILD_TREE

[ $cnt -eq 1 ] && echo -e "\n>>>>> Nothing to be done. <<<<<\n" && exit 1

chmod +x $WORK_DIR/scripts/*

echo -ne "\033[0K\r"


####################################################################
# MAKEFILE
####################################################################

### GENERATE MAKEFILE ###

echo
echo "Generating Makefile..."
echo

makefile=$WORK_DIR/Makefile
[[ -f $makefile ]] && rm $makefile
scripts=$(ls -r $WORK_DIR/scripts)

### MAKEFILE HEADER ###
cat << EOF > $makefile
####################################################################
# AUTO GENERATED MAKEFILE
####################################################################

### DISPLAY OUTPUT ###
BOLD= ""
NORMAL= ""
BLUE= ""

define echo_message
  @echo \$(BLUE)"===================================================================="
  @echo \$(BOLD)"--------------------------------------------------------------------"
  @echo \$(BOLD) Building target: \$(BLUE)\$@\$(BOLD)
  @echo \$(BOLD)"--------------------------------------------------------------------"
  @echo \$(BLUE)"===================================================================="
  @echo \$(NORMAL)
endef

define end_message
  @echo \$(BOLD)
  @echo \$(BLUE)"--------------------------------------------------------------------"
  @echo \$(BOLD)"===================================================================="
  @echo \$(BOLD) SUCCESS: \$(BLUE)Build completed.\$(BOLD)
  @echo \$(BOLD)"===================================================================="
  @echo \$(BLUE)"--------------------------------------------------------------------"
  @echo \$(NORMAL)
endef

EOF

### ADD SCRIPTS ###
prev=""
first="true"
for s in $scripts
do
	[ -z $prev ] && prev=$s && continue

	target1=${prev%.build}
	target2=${s%.build}
	package=${target1#*z-}
	echo "$target1 : $target2 " >> $makefile
	echo "	@echo" >> $makefile
	echo "	@\$(call echo_message)" >> $makefile
	echo "	@\$(TIMER_SCRIPT) PKG \$\$PPID $target1 &" >> $makefile
	echo "	@echo" >> $makefile
	echo "	./scripts/$prev" >> $makefile
	#echo "	\$(SCRIPT_DIR)/select.sh VERSINSTPKG $package" >> $makefile
	echo "	touch $target1" >> $makefile
	[[ ! -z $first ]] && echo "	@\$(call end_message)" >> $makefile && first=""
	echo "" >> $makefile
	prev=$s
done

target1=${prev%.build}
package=${target1#*z-}
echo "$target1 :" >> $makefile
echo "	@echo" >> $makefile
echo "	@\$(call echo_message)" >> $makefile
echo "	@\$(TIMER_SCRIPT) PKG \$\$PPID $target1 &" >> $makefile
echo "	@echo" >> $makefile
echo "	./scripts/$prev" >> $makefile
#echo "	\$(SCRIPT_DIR)/select.sh VERSINSTPKG $package" >> $makefile
echo "	touch $target1" >> $makefile

