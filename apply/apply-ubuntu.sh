#!/usr/bin/env bash

echo "Ubuntu $(os-version) $(ubuntu-codename)"

# if we're running Linux under VMWare, then
# make sure we install the 'open-vm' packages
SCSI="$(cat /proc/scsi/scsi 2> /dev/null | grep -i vmware)"
if [ -n "${SCSI}" ]; then
   sudo apt-get install      \
      open-vm-tools         \
      open-vm-tools-desktop \
      open-vm-tools-dkms
fi

sudo apt-get check neovim || (
   sudo add-apt-repository ppa:neovim-ppa/unstable
   sudo apt-get update
   sudo apt-get install -y neovim
)

sudo apt-get install -y  \
	ant                  \
	curl                 \
	dkms                 \
	emacs                \
	golang               \
	libcurl4-openssl-dev \
	libssl-dev           \
	libxml2-dev          \
	mercurial            \
	openjdk-8-jdk        \
	r-base-dev           \
	silversearcher-ag    \
	tmux                 \
	vim                  \
	xclip

#sudo apt-get build-dep -y r-base-dev
git config --global credential.helper "cache --timeout=36000"

# add Eclipse launcher -- assumes that eclipse lives
# at /usr/local/eclipse
mkdir -p ~/.local/share/applications
cat << EOF > ~/.local/share/applications/eclipse.desktop
[Desktop Entry]
Type=Application
Name=Eclipse
Comment=Eclipse Integrated Development Environment
Icon=/usr/local/eclipse/icon.xpm
Exec=/usr/local/eclipse/eclipse
Terminal=false
Categories=IDE;Java;
StartupWMClass=Eclipse
EOF

# add Qt Creator launcher -- assumes that we have an
# executable at /usr/local/bin/qtcreator
cat << EOF > ~/.local/share/applications/qtcreator.desktop
[Desktop Entry]
Type=Application
Exec=qtcreator %F
Name=Qt Creator
GenericName=C++ IDE for developing Qt applications
X-KDE-StartupNotify=true
Icon=QtProject-qtcreator
Terminal=false
Categories=Development;IDE;Qt;
MimeType= text/x-c++src;text/x-c++hdr;text/x-xsrc;application/x-designer;application/vnd.qt.qmakeprofile;application/vnd.qt.xml.resource;
EOF
