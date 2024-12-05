#!/bin/bash
####################################################################
# 
# action-config-in.sh
#
####################################################################o


#------------------------------------------------------------------#
# ACTION

cat > $ACTION_CONFIG_IN << EOF
choice
        prompt "Action"
        config    ACTION__VIEW_DOCS
            bool "View documentation"
            help
		View lfs-pkmg html documentation in your favorite browser.

        config    ACTION__BUILD
            bool "Build"
            help
                Build LFS, BLFS book packages, custom packages, or patches.

        config    ACTION__INSTALL
            bool "Install"
            help
                Install pre-built packages from selected archive.

        config    ACTION__REMOVE
            bool "Remove"
            help
                Remove pre-built packages from selected archive.

        config    ACTION__UPGRADE
            bool "Upgrade"
            help
                Upgrade entire installation to a new version.
endchoice

EOF

#------------------------------------------------------------------#
# BROWSER

cat >> $ACTION_CONFIG_IN << EOF
config    BROWSER
	depends on ACTION__VIEW_DOCS
        string  "Browser"
        default "lynx"
EOF

#------------------------------------------------------------------#
# BUILD TYPE

cat >> $ACTION_CONFIG_IN << EOF
choice
        prompt "Build Type"
	depends on ACTION__BUILD
        config    BUILD_TYPE__LFS
            bool "Build LFS"
            help
		<TODO: help text>

        config    BUILD_TYPE__BLFS
            bool "Build BLFS packages"
            help
		<TODO: help text>

        config    BUILD_TYPE__PATCH
            bool "Build LFS BLFS patches"
            help
		<TODO: help text>

        config    BUILD_TYPE__CUSTOM
            bool "Build custom packages"
            help
		<TODO: help text>

endchoice

EOF

#------------------------------------------------------------------#
# REV

cat >> $ACTION_CONFIG_IN << EOF
choice
        prompt "Init System"
	depends on BUILD_TYPE__LFS || BUILD_TYPE__BLFS
        config    REV__SYSV
            bool "sysvinit"
            help
                Build BLFS with SysV init.

        config    REV__SYSD
            bool "systemd"
            help
                Build BLFS with systemd init.

endchoice

EOF

#------------------------------------------------------------------#
# LFS BRANCHES

cat >> $ACTION_CONFIG_IN << EOF
choice
prompt "LFS Branch"
depends on BUILD_TYPE__LFS
EOF

# get branches
pushd $LFS_BOOK > /dev/null
branches=$(git for-each-ref --format='%(refname:short)' refs/remotes/origin)
popd > /dev/null

for branch in $branches; do

        branch=${branch#origin/}

cat >> $ACTION_CONFIG_IN << EOF
  config LFSBRANCH__$branch
      bool "$branch"
EOF

done

cat >> $ACTION_CONFIG_IN << EOF
endchoice

EOF

#------------------------------------------------------------------#
# BLFS BRANCHES

cat >> $ACTION_CONFIG_IN << EOF
choice
prompt "BLFS Branch"
depends on BUILD_TYPE__BLFS
EOF

# get branches
pushd $BLFS_BOOK > /dev/null
branches=$(git for-each-ref --format='%(refname:short)' refs/remotes/origin)
popd > /dev/null

for branch in $branches; do

        branch=${branch#origin/}

cat >> $ACTION_CONFIG_IN << EOF
  config BLFSBRANCH__$branch
      bool "$branch"
EOF

done

cat >> $ACTION_CONFIG_IN << EOF
endchoice

EOF

#------------------------------------------------------------------#
# INSTALL TYPE

cat >> $ACTION_CONFIG_IN << EOF
choice
        prompt "Install Type"
	depends on ACTION__INSTALL
        config    INSTALL_TYPE__PKG_IND
            bool "Individual package"
            help
		<TODO: help text>

        config    INSTALL_TYPE__PKG_DEPS
            bool "Package with dependencies"
            help
		<TODO: help text>

        config    INSTALL_TYPE__PKG_LIST
            bool "Package list"
            help
		<TODO: help text>

endchoice

EOF

#------------------------------------------------------------------#
# ARCHIVE PATH

cat >> $ACTION_CONFIG_IN << EOF
config    ARCHIVEPATH
	depends on ACTION__INSTALL
        string  "Archive Path"
        default "file://$ARCHIVE_DIR"
EOF

#------------------------------------------------------------------#
# INSTALL ROOT 

cat >> $ACTION_CONFIG_IN << EOF
config    INSTALLROOT
	depends on ACTION__INSTALL || BUILD_TYPE__LFS
        string  "Install ROOT"
        default "$LFS"
EOF


