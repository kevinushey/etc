#!/usr/bin/env bash

FLAVOUR=$(lsb_release -c | tail -n 1 | cut -d: -f2 | sed 's/\t//g')
echo "Ubuntu flavour: '${FLAVOUR}'"

CRAN_URL=http://cran.rstudio.com/bin/linux/ubuntu

if [ -z "$(grep ${CRAN_URL} /etc/apt/sources.list)" ]; then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
	sudo su -c "echo deb http://cran.rstudio.com/bin/linux/ubuntu ${FLAVOUR}/ >> /etc/apt/sources.list"
	sudo apt-get update -y
	sudo apt-get upgrade -y
fi

sudo apt-get install -y vim \
	emacs \
	r-base-dev \
	ess \
	nodejs-dev \
	npm \
	libcurl4-openssl-dev \
	curl \
	golang \
	golang-go.tools \
    mercurial

#sudo apt-get build-dep -y r-base-dev
git config --global credential.helper "cache --timeout=36000"
