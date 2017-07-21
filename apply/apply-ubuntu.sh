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

CRAN_URL=http://cran.rstudio.com/bin/linux/ubuntu

if [ -z "`grep ${CRAN_URL} /etc/apt/sources.list`" ]; then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
	sudo su -c "echo deb http://cran.rstudio.com/bin/linux/ubuntu $(ubuntu-codename)/ >> /etc/apt/sources.list"
	sudo apt-get update -y
	sudo apt-get upgrade -y
fi

sudo apt-get check neovim || (
   sudo add-apt-repository ppa:neovim-ppa/unstable
   sudo apt-get update
   sudo apt-get install -y neovim
)

sudo apt-get install -y        \
	vim                    \
	libxml2-dev            \
	emacs                  \
	r-base-dev             \
	ess                    \
	nodejs-dev             \
	npm                    \
	libcurl4-openssl-dev   \
	curl                   \
	golang                 \
	golang-go.tools        \
	mercurial              \
	dkms                   \
	tmux                   \
	xclip                  \
	silversearcher-ag

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

