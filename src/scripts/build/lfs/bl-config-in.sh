#!/bin/bash
####################################################################
# 
# bl-config-in.sh
#
####################################################################o


#------------------------------------------------------------------#
# REV
cat > $BL_CONFIG_IN << EOF
choice
        prompt "Book Revision"
        config    SYSV
            bool "sysvinit"
            help
                Build BLFS with SysV init.

        config    SYSD
            bool "systemd"
            help
                Build BLFS with systemd init.

endchoice

EOF

#------------------------------------------------------------------#
# BRANCHES

cat >> $BL_CONFIG_IN << EOF
choice
prompt "Book Branch"
EOF

# get branches
pushd $LFS_XML > /dev/null
branches=$(git for-each-ref --format='%(refname:short)' refs/remotes/origin)
popd > /dev/null

for branch in $branches; do

        branch=${branch#origin/}

cat >> $BL_CONFIG_IN << EOF
  config BRANCH_$branch
      bool "$branch"
EOF

done

cat >> $BL_CONFIG_IN << EOF
endchoice

EOF

#------------------------------------------------------------------#
# INSTALL ROOT 
cat >> $BL_CONFIG_IN << EOF
config    INSTALLROOT
        string  "Install ROOT"
        default "$LFS"
EOF



