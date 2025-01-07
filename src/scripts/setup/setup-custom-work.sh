#!/bin/bash
####################################################################
# 
# setup-custom-work.sh
#
####################################################################

set -e
source $SCRIPTS_FUNCS/setup-deps.func
source $SCRIPTS_FUNCS/setup-scripts.func
source $SCRIPTS_FUNCS/setup-makefile.func

# GET ASROOT 

source <(echo $ASROOT)
export -f as_root


#------------------------------------------------------------------#
# GET CUSTOM BUILD SCRIPTS
#------------------------------------------------------------------#

echo
echo "Getting custom build scripts..."

cstmbld=$(cat $CSTM_BLDS_LIST)


#------------------------------------------------------------------#
# ORDER BUILD SCRIPTS
#------------------------------------------------------------------#

### GET STARTING COUNT ###
[[ ! -d $WORK_SCRIPTS ]] && mkdir -p $WORK_SCRIPTS
cnt=$(ls $WORK_SCRIPTS | tail -n1 | sed 's/-.*//')
if [[ -z $cnt ]]; then
	cnt=1
else
	cnt=${cnt//0/}
	((cnt++))
fi

for cb in $cstmbld; 
do
	if [ $cnt -lt 10 ]; then
		order="00$cnt"
	elif [ $cnt -lt 100 ]; then
		order="0$cnt"
	else
		order="$cnt"
	fi

	file=$order-z-$cb
	bldscript=$CUSTOM_BUILD/$cb
	cp $bldscript $WORK_SCRIPTS/$file
        
	((cnt++))
done


#------------------------------------------------------------------#
# GENERATE MAKEFILE
#------------------------------------------------------------------#

echo
setup-makefile

echo
ls $WORK_SCRIPTS
echo

