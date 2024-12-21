#!/bin/bash
####################################################################
# 
# timer.sh
#
####################################################################

SCRIPT_DIR=${SCRIPT_DIR:-$HOME/blfs-builder/scripts}
source $SCRIPT_DIR/common-defs


####################################################################
# TIME BUILD
####################################################################

function time_build
{
	### LOOP ###
	while : ; do

		# check pid still active
		[[ ! -e /proc/$pid ]] && break

		# write time to file
		minutes=$((SECONDS / 60))
		seconds=$((SECONDS % 60))

		echo "$minutes:$seconds" > $BLD_TIME
	done

	### SAVE BUILD TIME ###

	# give the mgr a chance to exit
	# to avoid doubling build time
	sleep .5
	get_total_time

	echo "$tot_mins:$tot_secs" > $CUMU_TIME
	
}


####################################################################
# TIME PACKAGE
####################################################################

function time_package
{
	### LOOP ###
        while : ; do

                # check pid still active
                [[ ! -e /proc/$pid ]] && break

		# package build complete
		[[ -f $target ]] && exit

                # write time to file
                minutes=$((SECONDS / 60))
                seconds=$((SECONDS % 60))

		echo "$target $minutes:$seconds" > $PKG_TIME
        done	
}


####################################################################
# TIMER MANAGER
####################################################################

function timer_manager
{
	### INITIALIZE FILES ###
	first_target=$(ls $WORK_DIR/scripts | head -n1 | sed 's/.build//')
	last_target=$(ls $WORK_DIR/scripts | tail -n1 | sed 's/.build//')
	[[ $first_target == $last_target ]] && single_target=true

	### INITIALIZE DISPLAY ###

	# set offset
	if [[ $single_target ]]; then offset=3;
	else offset=7; fi

	# initialize elapsed-time
	if [[ ! -f $ELAP_TIME ]]; then
		echo "Package build times:" > $ELAP_TIME
		echo "" >> $ELAP_TIME
		echo "" >> $ELAP_TIME
		# multiple targets
		if [[ ! $single_target ]]; then
			echo "..." >> $ELAP_TIME
			echo "" >> $ELAP_TIME
			echo "$last_target" >> $ELAP_TIME
			echo "" >> $ELAP_TIME
		fi
		echo "--------------------------------------------------------------------" >> $ELAP_TIME
		echo "Elapsed build time: " >> $ELAP_TIME
	fi

	# intialize cumuliative-time
	[[ ! -f $CUMU_TIME ]] && echo "0:0" > $CUMU_TIME
	

	### LOOP ###
	first=true
        while : ; do

                # check pid still active
                [[ ! -e /proc/$pid ]] && break

		### PACKAGE BUILD TIME ###

		pkgline=""
		[[ -f $PKG_TIME ]] && pkgline=$(cat $PKG_TIME)
		if [[ ! -z $pkgline ]]; then

			# GET TIMES
			package=${pkgline% *}
			pkg_time=${pkgline#* }
			pkg_mins=${pkg_time%:*}
			pkg_secs=${pkg_time#*:}

			# seconds padding
			[ $pkg_secs -lt 10 ] && pkg_secs="0$pkg_secs"

			a="$package"
			b="$pkg_mins:$pkg_secs"
			write_line=$(printf "%-45s %10s" $a $b)
			write_line=${write_line// /.}

			# NEW PACKAGE
			# last target
			if [[ $package == $last_target ]]; then
				sed -i '/^\.\.\.$/,+3d' $ELAP_TIME
				offset=3
			fi
			existing=$(grep $package $ELAP_TIME)
			if [[ $first == "true" ]] || [[ -z $existing ]]; then

                        	# insert new line
                               	sed -i "$(( $(wc -l < $ELAP_TIME)-$offset ))a $write_line" $ELAP_TIME
                               	first=false

                       	# EXISTING PACKAGE
                       	else
                               # replace old line
                               sed -i "$(( $(wc -l < $ELAP_TIME)-$offset ))s/^.*$/$write_line/" $ELAP_TIME
                       	fi
		fi


		### TOTAL BUILD TIME ###

		# get cumulative times
		tot_mins=""
		tot_secs=""
		get_total_time
		[[ -z $tot_mins ]] || [[ -z $tot_secs ]] && continue

		# seconds padding
		[ $tot_secs -lt 10 ] && tot_secs="0$tot_secs"

		# replace old line
		a="Elapsed build time: "
		b="$tot_mins:$tot_secs"
		write_line=$(printf "%-45s %10s" "$a" $b)
		sed -i "$(( $(wc -l < $ELAP_TIME) ))s/^.*$/$write_line/" $ELAP_TIME
	done
	
}

#------------------------------------------------------------------#
function get_total_time
{
	# build time
        bldline=""
        [[ -f $BLD_TIME ]] && bldline=$(cat $BLD_TIME)
	[[ -z $bldline ]] && return
        bld_mins=${bldline%:*}
        bld_secs=${bldline#*:}

	# cumulative time
        cmlline=""
        [[ -f $CUMU_TIME ]] && cmlline=$(cat $CUMU_TIME)
	[[ -z $cmlline ]] && return
        cml_mins=${cmlline%:*}
        cml_secs=${cmlline#*:}

	# total time
        tot_mins=$(($bld_mins + $cml_mins))
        tot_secs=$(($bld_secs + $cml_secs))

	# seconds overflow
	if [ $tot_secs -ge 60 ]; then
		((tot_mins++))
		tot_secs=$(($tot_secs % 60))
	fi

}

####################################################################
# MAIN
####################################################################

### PARSE PARAMS ###

pid=$2
target=$3
package=${target#*z-}

case $1 in
        BLD) time_build ;;
        PKG) time_package ;;
        MGR) timer_manager ;;

esac
