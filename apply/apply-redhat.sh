#!/usr/bin/env bash

if [ "$(platform)" = "centos" ]; then
	sudo yum install -y epel-release
fi

sudo yum update -y
sudo yum install -y     \
	emacs               \
	freetype-devel      \
	fribidi-devel       \
	harfbuzz-devel      \
	libcurl-devel       \
	libgit2-devel       \
	libjpeg-turbo-devel \
	libpng-devel        \
	libtiff-devel       \
	libxml2-devel       \
	libXt-devel         \
	neovim              \
	openssl-devel       \
	R                   \
	readline-devel      \
	ripgrep             \
	subversion          \
	the_silver_searcher \
	tmux                \
	valgrind-devel      \
	vim                 \
	xclip
