#!/usr/bin/env sh

## This script installs lldb from sources. Note that this
## implies building LLVM and clang from source as well;
## this is a time consuming operation and will turn your
## computer into a tiny space heater for the next couple
## hours.
##
## Unfortunately, there's some code signing stuff that needs
## to be done manually once, the first time (see the
## 'docs/code-signing.txt' file); presumedly this could
## be automated too but I am currently too lazy.

# Where to check out LLDB sources?
: ${LLDB_SOURCE_DIR="${HOME}/lldb"}

# What branch to build from? Try e.g. release_38
: ${LLDB_BRANCH="master"}

# Create the directory, and clone the lldb directory
mkdir -p ${LLDB_SOURCE_DIR}
cd ${LLDB_SOURCE_DIR}
git clone http://llvm.org/git/lldb.git
cd lldb
git pull
git checkout "${LLDB_BRANCH}"

# Build it!
#
# As always, in the software world, documentation is sparse
# and build systems are built on only hopes and dreams. Apparently,
# the recommended way to build lldb is with:
#
#     xcodebuild -configuration Release -target lldb-tool
#
# as per:
#
#     http://comments.gmane.org/gmane.comp.debugging.lldb.devel/6202codebuild
#
# and so that's what we do.
xcodebuild -configuration Release -target lldb-tool || {
    echo 'xcodebuild failed!'
    exit 1
}

# Symlink to /usr/local/bin so we can use it
SOURCE="${LLDB_SOURCE_DIR}/lldb/build/Release/lldb"
TARGET="/usr/local/bin/lldb"
ln -fs "${SOURCE}" "${TARGET}"
echo "Symlinked '${SOURCE}' -> '${TARGET}'"

