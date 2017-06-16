#!/usr/bin/env bash

sudo yum install -y epel-release
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
