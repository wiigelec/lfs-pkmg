#!/bin/bash
####################################################################
# 
# util-create-pkglog.sh
#
####################################################################


[[ -z $(ls -A $DIFFLOG_DIR) ]] && echo ">>>>> Nothing to be done. <<<<<"  && exit 1
[[ ! -d $PKGLOG_DIR ]] && mkdir -p $PKGLOG_DIR
for FILE in $DIFFLOG_DIR/*.difflog1;
do
	### SKIP ###
	[[ $FILE == *"cleanup--"* ]] && continue
	[[ $FILE == *"stripping--"* ]] && continue

	### GET PACKAGE NAME AND VERSION ##
    	echo "Processing $FILE..."

	# package
    	pkg=${FILE%.difflog1}
    	diff1=$FILE
    	diff2=$pkg.difflog2
    	pkg=${pkg##*/}
    	log=$PKGLOG_DIR/$pkg.pkglog

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
    	sed -i '/^\/var\/lib\/lpm/d' $log.tmp

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

