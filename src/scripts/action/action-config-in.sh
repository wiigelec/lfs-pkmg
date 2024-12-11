#!/bin/bash
####################################################################
# 
# action-config-in.sh
#
####################################################################o


### INITIALIZE ###

[[ ! -d $BUILD_DIR/config ]] && mkdir $BUILD_DIR/config

#------------------------------------------------------------------#
# ACTION GROUP

cat > $ACTION_CONFIG_IN << EOF
choice
        prompt "Action Group"
#        config    ACTIONGROUP__AUDIT
#            bool "Audit"
#            help
#		<TODO: help text>
        config    ACTIONGROUP__BUILD
            bool "Build"
            help
		<TODO: help text>
        config    ACTIONGROUP__DOCS
            bool "Documentation"
            help
		<TODO: help text>
#        config    ACTIONGROUP__LIST
#            bool "List"
#            help
#		<TODO: help text>
        config    ACTIONGROUP__PACKAGE
            bool "Package"
            help
		<TODO: help text>

endchoice

EOF

#------------------------------------------------------------------#
# ACTION

cat >> $ACTION_CONFIG_IN << EOF
choice
        prompt "Action"

	#------------------------------------------------------------------#
	# AUDIT ACTIONS
        config    ACTION__AUDITLP
	    depends on ACTIONGROUP__AUDIT
            bool "Audit list packages"
            help
		<TODO: help text>
        config    ACTION__AUDITOP
	    depends on ACTIONGROUP__AUDIT
            bool "Audit orphaned packages"
            help
		<TODO: help text>
        config    ACTION__AUDITPF
	    depends on ACTIONGROUP__AUDIT
            bool "Audit package files"
            help
		<TODO: help text>
        config    ACTION__AUDITSF
	    depends on ACTIONGROUP__AUDIT
            bool "Audit system files"
            help
		<TODO: help text>
	
	#------------------------------------------------------------------#
	# BUILD ACTIONS
        config    ACTION__BUILDLFS
	    depends on ACTIONGROUP__BUILD
            bool "Build LFS"
            help
		<TODO: help text>
#        config    ACTION__BUILDBLFS
#	    depends on ACTIONGROUP__BUILD
#            bool "Build BLFS"
#            help
#		<TODO: help text>
#        config    ACTION__BUILDPATCH
#	    depends on ACTIONGROUP__BUILD
#            bool "Build patch"
#            help
#		<TODO: help text>
	
	#------------------------------------------------------------------#
	# DOCS ACTIONS
        config    ACTION__DOCSHTML
	    depends on ACTIONGROUP__DOCS
            bool "HTML Documentation"
            help
		<TODO: help text>

	#------------------------------------------------------------------#
	# LIST ACTIONS
        config    ACTION__LISTARCH
	    depends on ACTIONGROUP__LIST
            bool "Create list from archive"
            help
		<TODO: help text>
        config    ACTION__LISTDEPS
	    depends on ACTIONGROUP__LIST
            bool "Create list from dependency tree"
            help
		<TODO: help text>
        config    ACTION__LISTINSTALL
	    depends on ACTIONGROUP__LIST
            bool "Install list"
            help
		<TODO: help text>
        config    ACTION__LISTPATCH
	    depends on ACTIONGROUP__LIST
            bool "Install patch"
            help
		<TODO: help text>
        config    ACTION__LISTREMOVE
	    depends on ACTIONGROUP__LIST
            bool "Remove list"
            help
		<TODO: help text>
        config    ACTION__LISTUPGRADE
	    depends on ACTIONGROUP__LIST
            bool "Upgrade list"
            help
		<TODO: help text>

	#------------------------------------------------------------------#
	# PACKAGE ACTIONS
        config    ACTION__PKGINSTALL
	    depends on ACTIONGROUP__PACKAGE
            bool "Install package"
            help
		<TODO: help text>
        config    ACTION__PKGREMOVE
	    depends on ACTIONGROUP__PACKAGE
            bool "Remove package"
            help
		<TODO: help text>
        config    ACTION__PKGUPGRADE
	    depends on ACTIONGROUP__PACKAGE
            bool "Upgrade package"
            help
		<TODO: help text>
		
endchoice

EOF

#------------------------------------------------------------------#
# AUDIT FIELDS





#------------------------------------------------------------------#
# BUILD FIELDS

### REV ###

cat >> $ACTION_CONFIG_IN << EOF
choice
        prompt "Init System"
	depends on ACTION__BUILDLFS || ACTION__BUILDBLFS
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

### LFS BRANCHES ### 

cat>> $ACTION_CONFIG_IN << EOF
choice
prompt "LFS Branch"
depends on ACTION__BUILDLFS
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

### BLFS BRANCHES ###

cat >> $ACTION_CONFIG_IN << EOF
choice
prompt "BLFS Branch"
depends on ACTION__BUILDBLFS
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
# DOCS FIELDS

### BROWSER ###

cat >> $ACTION_CONFIG_IN << EOF
config    BROWSER
	depends on ACTION__DOCSHTML
        string  "Browser"
        default "lynx"
EOF

#------------------------------------------------------------------#
# LIST FIELDS





#------------------------------------------------------------------#
# PACKAGE FIELDS





#------------------------------------------------------------------#
# COMMON FIELDS

### MIRROR PATH ###

cat >> $ACTION_CONFIG_IN << EOF
config    MIRRORPATH
	depends on ACTIONGROUP__LIST || ACTION__PKGINSTALL || ACTION__PKGUPGRADE
        string  "Mirror Path"
        default "file://$ARCHIVE_DIR"
EOF

### INSTALL ROOT ###

cat >> $ACTION_CONFIG_IN << EOF
config    INSTALLROOT
	depends on ACTIONGROUP__LIST || ACTIONGROUP__PACKAGE || ACTION__BUILDLFS
        string  "Install ROOT"
        default "$LFS"
EOF





