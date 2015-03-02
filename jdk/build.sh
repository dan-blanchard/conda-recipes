#!/bin/bash

#### Download in build because we have to set cookies ####
# Check if we're on OS X
if [ $(uname) = "Darwin" ]; then
	curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o jdk.dmg -L 'http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-macosx-x64.dmg'

	# Extract files like in
	# http://stackoverflow.com/questions/15217200/how-to-install-java-7-on-mac-in-custom-location
	hdiutil attach -mountpoint jdk_mount jdk.dmg
	pkgutil --expand jdk_mount/JDK\ 8\ Update\ 31.pkg java
	hdiutil detach jdk_mount
	cat java/jdk18031.pkg/Payload | cpio -zi
	mv Contents/Home "$PREFIX/jdk"

    # Make symlinks so that things are in the prefix's lib directory
    mkdir -p "$PREFIX/lib"
    cd "$PREFIX/lib"
    for filename in ../jdk/lib/*; do
        ln -s $filename $(basename $filename)
    done
else
	if [ "$ARCH" = "32" ]; then
		curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o jdk.tar.gz -L 'http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-i586.tar.gz'
	else
		curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o jdk.tar.gz -L 'http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz'
	fi

	# Extract files
	tar -xzvf jdk.tar.gz
	mv jdk1.8.0_31 "$PREFIX/jdk"

    # Make symlinks so that things are in the prefix's lib directory
    mkdir -p "$PREFIX/lib"
    cd "$PREFIX/lib"
    for filename in $(find ../jdk/lib -maxdepth 3 -name "*.so"); do
        ln -s $filename $(basename $filename)
    done
fi

# Make symlinks so that things are in the prefix's bin directory
mkdir -p "$PREFIX/bin"
cd "$PREFIX/bin"
for filename in ../jdk/bin/*; do
	ln -s $filename $(basename $filename)
done
