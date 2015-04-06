#!/usr/bin/env sh

## This script installs lldb from sources. Note that this
## implies building LLVM and clang from source as well;
## this is a time consuming operation and will turn your
## computer into a tiny space heater for the next couple
## hours.

# Where to check out LLDB sources?
: ${LLDB_SOURCE_DIR:=${HOME}/lldb}

# Create the directory, and clone the lldb directory
mkdir -p ${LLDB_SOURCE_DIR}
cd ${LLDB_SOURCE_DIR}
git clone http://llvm.org/git/lldb.git
cd lldb

# For some reason, svn checkouts fail with 'http://'
# so we use 'sed' to switch to 'https://'
ag -Q -l "http://llvm.org" \
	| xargs sed -i '' 's|http://llvm.org|https://llvm.org|g'

# Build it!
xcodebuild
xcodebuild install

# Symlink to /usr/local/bin so we can use it
FROMPATH=${LLDB_SOURCE_DIR}/lldb/build/BuildAndIntegration/lldb
TOPATH=/usr/local/bin/lldb
ln -fs "${FROMPATH}" "${TOPATH}"

