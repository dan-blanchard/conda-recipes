#!/bin/bash

# Copy everything in SRC_DIR to PREFIX/storm
mkdir -p "$PREFIX/storm"
cp -R $SRC_DIR/* $PREFIX/storm

# Make symlinks so that things are in the prefix's bin directory
mkdir -p "$PREFIX/bin"
cd "$PREFIX/bin"
for filename in ../storm/bin/*; do
    ln -s $filename $(basename $filename)
done

# Fix python path in $PREFIX/bin/storm
sed -i.bak "s|/usr/bin/python|/usr/bin/env python|" $PREFIX/storm/bin/storm

# Make symlinks so that things are in the prefix's lib directory
mkdir -p "$PREFIX/lib"
cd "$PREFIX/lib"
for filename in ../storm/lib/*; do
    if [ ${filename: -4} != ".jar" ]; then
       ln -s $filename $(basename $filename)
    fi
done
