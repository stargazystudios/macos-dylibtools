#!/bin/sh

# macOS script to search for dylib files in two input directories and use 'lipo' command 
# to create a single, multi-architecture file for each pairing found

# Options:
#	1. path 1 to find dylib files.
#	2. path 2 to find dylib files.
#	3. path to create multi-architecture dylib files from pairs found.

dylibDirectory1="$1"
dylibDirectory2="$2"
copyToDirectory="$3"

if [ ! -d "$dylibDirectory1" ]; then

	echo "Specified dylib directory 1 does not exist."
	exit 1

fi

if [ ! -d "$dylibDirectory2" ]; then

	echo "Specified dylib directory 2 does not exist."
	exit 1

fi

if [ ! -d "$copyToDirectory" ]; then

	mkdir -p "$copyToDirectory"

fi

dylibs=()

for dylib in `find $dylibDirectory1 -name '*.dylib' -maxdepth 1`; do

	dylibs+=(`basename "$dylib"`)

done

for dylib in "${dylibs[@]}"; do

	if [ -e "$dylibDirectory2/$dylib" ]; then
	
		echo "$dylib"
		lipo -create "$dylibDirectory1/$dylib" "$dylibDirectory2/$dylib" -output "$copyToDirectory/$dylib"

	fi

done