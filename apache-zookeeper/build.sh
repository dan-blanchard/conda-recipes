#!/bin/bash

# Copy everything in SRC_DIR to PREFIX/zookeeper
mkdir -p "$PREFIX/zookeeper"
cp -R $SRC_DIR/* $PREFIX/zookeeper

# Setup data directory and config file
mkdir -p "$PREFIX/etc/zookeeper"
mkdir -p "$PREFIX/zookeeper/data"
sed "s|/tmp/zookeeper|$PREFIX/zookeeper/data|g" < $PREFIX/zookeeper/conf/zoo_sample.cfg > $PREFIX/etc/zookeeper/zoo.cfg

# Make symlinks so that things are in the prefix's bin directory
mkdir -p "$PREFIX/bin"
cd "$PREFIX/bin"
for filename in ../zookeeper/bin/*; do
    if [ ${filename: -4} != ".cmd" ]; then
	   ln -s $filename $(basename $filename)
    fi
done

# Make symlinks so that things are in the prefix's lib directory
mkdir -p "$PREFIX/lib"
cd "$PREFIX/lib"
for filename in ../zookeeper/lib/*; do
	ln -s $filename $(basename $filename)
done
