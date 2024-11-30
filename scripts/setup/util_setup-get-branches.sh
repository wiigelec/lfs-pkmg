#!/bin/bash
####################################################################
# 
# util_setup-get-branches.sh
#
####################################################################o


### GET LFS BOOK BRANCHES ###

pushd $LFS_BOOK_DIR > /dev/null
branches=$(git for-each-ref --format='%(refname:short)' refs/remotes/origin)
popd > /dev/null

for branch in $branches; do

	branch=${branch#origin/}
	echo "  config BRANCH_$branch"
	echo "          bool \"$branch\""

done
