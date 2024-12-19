#!/bin/bash
####################################################################
# 
# bb-fix-scripts.sh
#
####################################################################

set -e


### FIX BUILD SCRIPTS ###

echo
echo "Fixing build scripts..."
echo

#------------------------------------------------------------------#
# sudo
FILE=$BLFS_SCRIPTS_DIR/sudo.build
linenum=$(grep -n "cat > /etc/pam.d/sudo" $FILE | sed 's/:.*//')
sed -i "$linenum i [[ -d /etc/pam.d ]] &&" $FILE
linenum=$(grep -n "chmod 644 /etc/pam.d/sudo" $FILE | sed 's/:.*//')
sed -i "$linenum i [[ -f /etc/pam.d/sudo ]] &&" $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# unzip
FILE=$BLFS_SCRIPTS_DIR/unzip.build
sed -i '/convmv -f cp936 -t utf-8 -r --nosmart --notest/d' $FILE
sed -i '/<\/path\/to\/unzipped\/files>/d' $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# post-lfs-config-profile
FILE=$BLFS_SCRIPTS_DIR/postlfs-config-profile.build
linenum=$(grep -n "### CONFIGURE MAKE INSTALL ###" $FILE | sed 's/:.*//')
linenum2=$(grep -n "### END CONFIGURE MAKE INSTALL ###" $FILE | sed 's/:.*//')
sed -i "${linenum},${linenum2}s/\\$/\\\\\$/g" $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
#------------------------------------------------------------------#
# bash -e
fix_files=$(grep -rl "bash -e" $BLFS_SCRIPTS_DIR)
for a in $fix_files; do sed -i 's/bash -e/set -e/' $a; done
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# as_root
fix_files=$(grep -rl "as_root" $BLFS_SCRIPTS_DIR)
for a in $fix_files; do sed -i 's/as_root/sudo -E/' $a; done
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# xorg env
sed -i 's/<PREFIX>/\/usr/' $BLFS_SCRIPTS_DIR/xorg-env.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# xorg libs
sed -i '/grep -A9 summary \*make_check\.log/d' $BLFS_SCRIPTS_DIR/xorg7-lib.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# harfbuzz/freetype/graphite
cp $BLFS_SCRIPTS_DIR/freetype2.build $BLFS_SCRIPTS_DIR/freetype2-pass1.build
cp $BLFS_SCRIPTS_DIR/graphite2.build $BLFS_SCRIPTS_DIR/graphite2-pass1.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# mesa/libva
cp $BLFS_SCRIPTS_DIR/libva.build $BLFS_SCRIPTS_DIR/libva-pass1.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# libvdpau
sed -i '/[ -e \$XORG_PREFIX\/share\/doc\/libvdpau ] && mv -v \$XORG_PREFIX\/share\/doc\/libvdpau{,1\.5}/d' $BLFS_SCRIPTS_DIR/libvdpau.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# boost
sed -i 's/-j<N>/-j\$(nproc)/' $BLFS_SCRIPTS_DIR/boost.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# sdl2
num=$(grep -n "cd test" $BLFS_SCRIPTS_DIR/sdl2.build | sed 's/:.*//')
sed -i "$num,$(($num+2))d" $BLFS_SCRIPTS_DIR/sdl2.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# qt6
sed -i 's/\$QT6DIR/\\\$QT6DIR/' $BLFS_SCRIPTS_DIR/qt6.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# qt5
sed -i 's/\$QT5DIR/\\\$QT5DIR/' $BLFS_SCRIPTS_DIR/qt5-components.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# v4l-utils
sed -i 's/contrib\/test\/\$prog/contrib\/test\/\\$prog/' $BLFS_SCRIPTS_DIR/v4l-utils.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# network manager
sed -i 's/\/usr\/share\/man\/man\$section/\/usr\/share\/man\/man\\$section/' $BLFS_SCRIPTS_DIR/NetworkManager.build
sed -i 's/install -vm 644 \$file/install -vm 644 \\$file/' $BLFS_SCRIPTS_DIR/NetworkManager.build
sed -i 's/netdev &&/netdev/' $BLFS_SCRIPTS_DIR/NetworkManager.build
sed -i '/netdev <username>/d' $BLFS_SCRIPTS_DIR/NetworkManager.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# kf6-frameworks
sed -i '/The options used here are:/,+5d' $BLFS_SCRIPTS_DIR/kf6-frameworks.build
sed -i '/exit/d' $BLFS_SCRIPTS_DIR/kf6-frameworks.build
echo "exit" >> $BLFS_SCRIPTS_DIR/kf6-frameworks.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# qcoro
sed -i '/make test/d' $BLFS_SCRIPTS_DIR/qcoro.build
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# plasma-build
FILE=$BLFS_SCRIPTS_DIR/plasma-build.build
sed -i '/The options used here are:/,+5d' $FILE
sed -i '/exit/d' $FILE
echo "exit" >> $FILE
linenum=$(grep -n "# Setup xsessions (X11 sessions)" $FILE | sed 's/:.*//')
sed -i "$linenum i sudo -E sh -e << ROOT_EOF" $FILE
linenum=$(grep -n "ln -sfv \$KF6_PREFIX/share/xdg-desktop-portal/portals/kde.portal" $FILE | sed 's/:.*//')
((linenum++))
sed -i "$linenum i ROOT_EOF" $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# java
FILE=$BLFS_SCRIPTS_DIR/java.build
[[ $(uname -m) == "x86_64" ]] && sed -i 's/\(PKG_URL=.*\)i686\(.*\)/\1x86_64\2/' $FILE
sed -i '/wget http/d' $FILE
sed -i '/public class HelloWorld/,+6d' $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# ojdk-conf
FILE=$BLFS_SCRIPTS_DIR/ojdk-conf.build
sed -i 's/\$JAVA_HOME/\\\$JAVA_HOME/' $FILE
sed -i 's/\${AUTO_CLASSPATH_DIR}/\\\${AUTO_CLASSPATH_DIR}/' $FILE
sed -i 's/\$dir/\\\$dir/' $FILE
sed -i 's/\$jar/\\\$jar/' $FILE
sed -i 's/`find/\\`find/' $FILE
sed -i 's/null`/null\\`/' $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# openjdk
FILE=$BLFS_SCRIPTS_DIR/openjdk.build
sed -i '/export MAKEFLAGS/d' $FILE
sed -i 's/make images/make images JOBS=\$(nproc)/' $FILE
sed -i 's/\${s}\.png \\/\\\${s}\.png \\\\/' $FILE
sed -i 's/\${s}x\${s}/\\\${s}x\\\${s}/' $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# postgresql
FILE=$BLFS_SCRIPTS_DIR/postgresql.build
line1=$(grep -n "install -v -dm700 /srv/pgsql/data &&" $FILE | sed 's/:.*//')
line2=$(grep -n "su - postgres -c '/usr/bin/initdb -D /srv/pgsql/data'" $FILE | sed 's/:.*//')
sed -i "$line1,${line2}d" $FILE
sed -i '/make install-postgresql/d' $FILE
line1=$(grep -n "su - postgres -c '/usr/bin/postgres -D /srv/pgsql/data >" $FILE | sed 's/:.*//')
line2=$(grep -n "su - postgres -c \"/usr/bin/pg_ctl stop -D /srv/pgsql/data\"" $FILE | sed 's/:.*//')
sed -i "$line1,${line2}d" $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# libreoffice
FILE=$BLFS_SCRIPTS_DIR/libreoffice.build
sed -i 's/<PREFIX>/\/opt\/libreoffice-\$PKG_VERS/' $FILE
sed -i 's/\$LO_PREFIX/\\\$LO_PREFIX/' $FILE
sed -i 's/\$i/\\\$i/' $FILE
sed -i 's/\$(basename \$i)/\\\$(basename \\\$i)/' $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# qemu
FILE=$BLFS_SCRIPTS_DIR/qemu.build
sed -i 's/usermod -a -G kvm <username>/usermod -a -G kvm \$USER/' $FILE
line1=$(grep -n "chmod 4750 /usr/libexec/qemu-bridge-helper" $FILE | sed 's/:.*//')
sed -i "${line1}a ln -sv qemu-system-\`uname -m\` \/usr\/bin\/qemu" $FILE
line1=$(grep -n "VDISK_SIZE=50G" $FILE | sed 's/:.*//')
line2=$(grep -n "echo allow br0 > /etc/qemu/bridge.conf" $FILE | sed 's/:.*//')
sed -i "$line1,$(($line2+1))d" $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# xorg7-legacy
FILE=$BLFS_SCRIPTS_DIR/xorg7-legacy.build
sed -i '/exit/d' $FILE
echo "exit" >> $FILE
#------------------------------------------------------------------#

#------------------------------------------------------------------#
# tigervnc
FILE=$BLFS_SCRIPTS_DIR/tigervnc.build
sed -i 's/\$XORG_PREFIX/\\\$XORG_PREFIX/' $FILE
sed -i 's/\$(whoami)/\\\$(whoami)/' $FILE
line1=$(grep -n "systemctl start" $FILE | sed 's/:.*//')
line2=$(grep -n "systemctl enable" $FILE | sed 's/:.*//')
sed -i "$line1,${line2}d" $FILE
#------------------------------------------------------------------#


