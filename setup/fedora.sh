#!/bin/bash
# Install packages in Fedora 30.
# TODO turn this into an ansible playbook or something
dnf install \
	autoconf \
	automake \
	asciidoc \
	bison \
	ccache \
	@development-tools \
	elfutils-libelf-devel \
	elfutils-libelf-devel-static \
	fedpkg \
	flex \
	ftp \
	gcc \
	git \
	glibc-static \
	gnome-tweak-tool \
	graphviz \
	ImageMagick \
	kernel-devel \
	libtool \
	make \
	minicom \
	moreutils \
	ncurses-term \
	neovim \
	openssl-devel \
	openssl-static \
	pass \
	pipenv \
	ShellCheck \
	stow \
	strace \
	thunderbird \
	vim-common \
	weechat \
	xmlto \
	zlib-devel \
	zlib-static
