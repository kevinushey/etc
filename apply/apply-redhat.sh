#!/usr/bin/env bash

if [ "$(platform)" = "centos" ]; then
	sudo yum install -y epel-release
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
