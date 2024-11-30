#!/bin/bash
####################################################################
# 
# util_setup-config-in.sh
#
####################################################################o


### REV ###
cat << EOF
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

### BRANCHES ###
echo "choice"
echo "prompt \"Book Branch\""

$UTIL_SETUP_GET_BRANCHES_SH

echo "endchoice"
