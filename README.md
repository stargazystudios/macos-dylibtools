# macos-dylibtools
Collection of scripts to help with the migration of dylib libraries, built for a local 
environment, to a portable package.


# dylibCopyDependents.sh
macOS script to copy a dylib file, and other dylib files it references in the same, flat 
directory, to another, pre-existing location.

Options:
1. path to dylib.
2. path to copy dylib files to.


# dylibReplaceRpath.sh
macOS script to take a flat directory of interdependent dylib files, and replace the path
to one another with @rpath, allowing them to be packaged with any dependent executable.

Options:
1. path to dylib directory.


# dylibLipoPairs.sh
macOS script to search for dylib files in two input directories and use 'lipo' command 
to create a single, multi-architecture file for each pairing found

Options:
1. path 1 to find dylib files.
2. path 2 to find dylib files.
3. path to create multi-architecture dylib files from pairs found.
