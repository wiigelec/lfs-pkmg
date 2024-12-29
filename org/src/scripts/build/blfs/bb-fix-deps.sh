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
 


# fix dovecot
fix_files=$(grep -rl dovecot $DEPS_DIR)
for a in $fix_files; do sed -i 's/dovecot/dovecot/' $a; done

# fix xinit
fix_files=$(grep -rl xinit $DEPS_DIR)
for a in $fix_files; do sed -i 's/xinit/xinit/' $a; done

# fix java
fix_files=$(grep -rl java $DEPS_DIR)
for a in $fix_files; do sed -i 's/java/java/' $a; done

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

