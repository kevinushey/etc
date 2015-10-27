#!/usr/bin/env bash

if [ -n "$(grep "CentOS Linux release 7" /etc/redhat-release 2> /dev/null)" ]; then
	wget -c http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
	sudo rpm -ivh epel-release-7-5.noarch.rpm
else
	echo "Failed to detect CentOS version: not activating EPEL"
fi

sudo yum update -y
sudo yum install -y      \
	R                    \
	vim                  \
	emacs                \
	the_silver_searcher  \
	tmux                 \
	libcurl-devel        \
	libxml2-devel        \
	openssl-devel
