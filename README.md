# macos-dylibtools
Collection of scripts to help with the migration of dylib libraries, built for a local environment, to a portable package.


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
