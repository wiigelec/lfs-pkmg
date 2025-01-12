#!/bin/bash
####################################################################
# 
# build-pkglogs.sh
#
####################################################################


#------------------------------------------------------------------#
# build-pkglogs
#------------------------------------------------------------------#

if [[ -z $(ls -A $LPM_DIFFLOG) ]]; then
	echo ">>>>> Nothing to be done. <<<<<"
	[[ $ACTION == "BUILDCUSTOM" ]] && exit 0
	exit 1
fi

[[ ! -d $LPM_PKGLOG ]] && mkdir -p $LPM_PKGLOG
for FILE in $LPM_DIFFLOG/*.difflog1;
do
	### SKIP ###
	[[ $FILE == *"cleanup--"* ]] && continue
	[[ $FILE == *"stripping--"* ]] && continue

	### GET PACKAGE NAME AND VERSION ##
    	echo -ne "Processing $FILE...\033[0K\r"

	# package
    	pkg=${FILE%.difflog1}
    	diff1=$FILE
    	diff2=$pkg.difflog2
    	pkg=${pkg##*/}
    	log=$LPM_PKGLOG/$pkg.pkglog

    	# diff
	[[ $(diff $diff1 $diff2 > $log.tmp) ]] && true

    	# filter
    	sed -i '/^>/!d' $log.tmp
    	sed -i 's/> //g' $log.tmp
    	sed -i '/^\/var\/lib\/swl\/difflog/d' $log.tmp
    	sed -i '/^\/sources/d' $log.tmp
    	sed -i '/^\/jhalfs/d' $log.tmp
    	sed -i '/^\/blfs_root/d' $log.tmp
    	sed -i '/^\/dev/d' $log.tmp
    	sed -i '/^\/proc/d' $log.tmp
    	sed -i '/^\/sys/d' $log.tmp
    	sed -i '/^\/root/d' $log.tmp
    	sed -i '/^\/home/d' $log.tmp
    	sed -i '/^\/etc\/passwd/d' $log.tmp
    	sed -i '/^\/etc\/group/d' $log.tmp
    	sed -i '/^\/etc\/shadow/d' $log.tmp
   	sed -i '/^\/etc\/gshadow/d' $log.tmp
    	sed -i '/^\/var\/lib\/systemd\/coredump\//d' $log.tmp
    	sed -i '/^\/opt\/kf5\/share\/icons\/hicolor\//d' $log.tmp
    	sed -i '/^\/tmp/d' $log.tmp
    	sed -i '/^\/etc\/ld\.so\.cache/d' $log.tmp
    	sed -i '/^\/install\/.*/d' $log.tmp
    	sed -i '/^\/var\/cache/d' $log.tmp
    	sed -i '/^\/var\/lib\/pkgtools/d' $log.tmp
    	sed -i '/^\/var\/lib\/packages/d' $log.tmp
    	sed -i '/^\/var\/lib\/swl/d' $log.tmp
    	sed -i '/^\/var\/lib\/systemd\/timesync/d' $log.tmp
    	sed -i '/^\/var\/log\/journal/d' $log.tmp
    	sed -i '/^\/var\/log\/wtmp/d' $log.tmp
    	sed -i '/^\/var\/lib\/NetworkManager/d' $log.tmp
	sed -i '/^\/var\/lib\/lpm\/pretend/p;/^\/var\/lib\/lpm/d' $log.tmp

	### KF6 INTRO FIX ###
	if [[ $log == *"kf6-intro"* ]]; then
		# get version
		version=${log#kf6-intro--}
		version=${version%.pkglog}

		# replace kf6
		sed -i "s/kf6\//kf6-$version\//g" $log
	fi


    	# sort
    	cat $log.tmp | sort -u > $log
    	rm $log.tmp
    	cp $log $log.tmp
    	rm $log

    	# check files exist
    	while IFS= read -r line;
    	do
	  	if [[ -e $line ]]; then
		   	echo $line >> $log
	    	fi
    	done < $log.tmp

    	# cleanup
    	rm $log.tmp
done

echo -ne "\033[0K\r"
