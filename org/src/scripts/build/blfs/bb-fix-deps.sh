#!/bin/bash
####################################################################
# 
# bb-fix-deps.sh
#
####################################################################

set -e

### FIX DEPS ###

echo
echo "Fixing dep files..."
echo
 
# fix dejavu-fonts
fix_files=$(grep -rl dejavu-fonts $DEPS_DIR)
for a in $fix_files; do sed -i '/dejavu-fonts/d' $a; done

# fix polkit-agent
fix_files=$(grep -rl polkit-agent $DEPS_DIR)
for a in $fix_files; do sed -i '/polkit-agent/d' $a; done

# fix server-mail
fix_files=$(grep -rl server-mail $DEPS_DIR)
for a in $fix_files; do sed -i 's/server-mail/dovecot/' $a; done

# fix x-window-system
fix_files=$(grep -rl x-window-system $DEPS_DIR)
for a in $fix_files; do sed -i 's/x-window-system/xinit/' $a; done

# fix java-bin
fix_files=$(grep -rl java-bin $DEPS_DIR)
for a in $fix_files; do sed -i 's/java-bin/java/' $a; done

# harfbuzz/freetype/graphite
sed -i 's/\(freetype2\)/\1-pass1/' $DEPS_DIR/harfbuzz.deps
sed -i 's/\(graphite2\)/\1-pass1/' $DEPS_DIR/harfbuzz.deps

cp $DEPS_DIR/freetype2.deps $DEPS_DIR/freetype2-pass1.deps
cp $DEPS_DIR/graphite2.deps $DEPS_DIR/graphite2-pass1.deps

sed -i '/freetype2/d' $DEPS_DIR/freetype2-pass1.deps
sed -i '/harfbuzz/d' $DEPS_DIR/freetype2-pass1.deps
sed -i '/graphite2/d' $DEPS_DIR/graphite2-pass1.deps

echo "--freetype2-pass1--" >> $DEPS_DIR/freetype2-pass1.deps
echo "--graphite2-pass1--" >> $DEPS_DIR/graphite2-pass1.deps

echo "--freetype2--" >> $DEPS_DIR/harfbuzz.deps
echo "--graphite2--" >> $DEPS_DIR/harfbuzz.deps

cp $DEPS_DIR/harfbuzz.deps $DEPS_DIR/freetype2.deps
cp $DEPS_DIR/harfbuzz.deps $DEPS_DIR/graphite2.deps

# libva/mesa
sed -i 's/\(libva\)/\1-pass1/' $DEPS_DIR/mesa.deps
cp $DEPS_DIR/libva.deps $DEPS_DIR/libva-pass1.deps
sed -i '/libva/d' $DEPS_DIR/libva-pass1.deps
sed -i '/mesa/d' $DEPS_DIR/libva-pass1.deps
echo "--libva-pass1--" >> $DEPS_DIR/libva-pass1.deps
echo "--libva--" >> $DEPS_DIR/mesa.deps

# gcr
sed -i '/--gcr--/d' $DEPS_DIR/gcr.deps
echo "openssh" >> $DEPS_DIR/gcr.deps
echo "--gcr--" >> $DEPS_DIR/gcr.deps

