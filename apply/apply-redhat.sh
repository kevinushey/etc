#!/usr/bin/env bash

if [ "$(platform)" = "centos" ]; then
	sudo yum install -y epel-release
fi

sudo yum update -y
sudo yum install -y      \
	emacs                \
	libcurl-devel        \
	libxml2-devel        \
	neovim               \
	openssl-devel        \
	R                    \
	ripgrep              \
	the_silver_searcher  \
	tmux                 \
	vim
