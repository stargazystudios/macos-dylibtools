#!/bin/sh

# macOS script to take a flat directory of interdependent dylib files, and replace the path
# to one another with @rpath, allowing them to be packaged with any dependent executable.

# Options:
#	1. path to dylib directory.

dylibsPath="$1"

if [ ! -d "$dylibsPath" ]; then

	echo "Specified path does not exist."
	exit 1

fi

dylibs=()

for dylib in `find $dylibsPath -name '*.dylib' -maxdepth 1`; do

	dylibs+=(`basename "$dylib"`)

done

for dylib in "${dylibs[@]}"; do

	for targetDylib in "${dylibs[@]}"; do
	
		for targetDylibPath in `otool -L "$dylibsPath/$dylib" | awk '{if(NR>1)print}' | grep "$targetDylib" | awk -F' ' '{ print $1 }'`; do
		
			if [ "$targetDylibPath" != "@rpath/$targetDylib" ]; then
			
				echo "$targetDylibPath -> @rpath/$targetDylib"
			
				if [ "$dylib" = "$targetDylib" ]; then
				
					install_name_tool -id "@rpath/$targetDylib" "$dylibsPath/$dylib"
				
				else
				
					install_name_tool -change "$targetDylibPath" "@rpath/$targetDylib" "$dylibsPath/$dylib"
					
				fi
				
			fi
			
		done
	
	done
	
done
