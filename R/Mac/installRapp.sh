#!/usr/bin/env sh
## Installs R.app from source, and places it within the /Applications folder

mkdir .R-devel
cd .R-devel
wget http://cran.r-project.org/bin/macosx/Mac-GUI-1.62.tar.gz
tar -zxvf Mac-GUI-1.62.tar.gz
cd Mac-GUI-1.62
xcodebuild -target R
rm -rf /Applications/R.app
cp -R build/SnowLeopard64/R.app /Applications/R.app


