#!/bin/bash
####################################################################
#
# util-lfs-chroot.sh
#
####################################################################

LFS=${LFS:-/mnt/lfs}

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    /bin/bash --login

