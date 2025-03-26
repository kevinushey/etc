#!/usr/bin/env bash

# install Homebrew
if ! command -v brew &> /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

FORMULAS=(
	ag
	boost
	cairo
	cmake
	ctags
	hub
	libpq
	libgit2
	llvm
	neovim
	ninja
	node
	openjdk
	pandoc
	postgres
	qpdf
	r
	reattach-to-user-namespace
	rg
	shellcheck
	soci
	svn
	tmux
	tree
	wget
	yaml-cpp
)

for FORMULA in "${FORMULAS[@]}"; do
	brew install --formula "${FORMULA}"
done

# prepare launch agents
mkdir -p ~/Library/LaunchAgents
pushd ~/Library/LaunchAgents
cat > environment.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>local.environment</string>
  <key>ProgramArguments</key>
  <array>
    <string>sh</string>
    <string>-c</string>
    <string>
    launchctl setenv RSTUDIO_NO_ACCESSIBILITY 1
    </string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
launchctl load environment.plist
popd


