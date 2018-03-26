#!/bin/sh

# macOS script to copy a dylib file, and other dylib files it references in the same, flat 
# directory, to another, pre-existing location.

# Options:
#	1. path to dylib.
#	2. path to copy dylib files to.

dylibFile="$1"
copyToPath="$2"

if [ ! -e "$dylibFile" ]; then

	echo "Specified target dylib path does not exist."
	exit 1

fi

if [ ! -d "$copyToPath" ]; then

	echo "Specified destination path does not exist."
	exit 1

fi

dylibPath=`dirname "$dylibFile"`
dylibs=("$dylibFile")


addUniqueDylibReferences () {

	for dylib in `otool -L "$1" | awk '{if(NR>1)print}' | grep "$dylibPath" | awk -F' ' '{ print $1 }'`; do

		countChecked=0
		arraySize=${#dylibs[@]}
		
		#echo "?$dylib"
	
		while [ $countChecked -lt $arraySize ]; do
		
			if [ ${dylibs[$countChecked]} != $dylib ]; then
				
				((countChecked++))
				
			else
				
				countChecked=$((arraySize+1))
				
			fi
		
		done
		
		if [ $countChecked -le $arraySize ]; then
		
			#echo "+$dylib"
			dylibs+=($dylib)
			
		fi

	done

}


#expand the array of dylib file names

countExpanded=0

while [ $countExpanded -lt ${#dylibs[@]} ]; do

	addUniqueDylibReferences ${dylibs[$countExpanded]}
	((countExpanded++))

done

for dylib in "${dylibs[@]}"; do

	cp -v "$dylib" "$copyToPath"
	
done
