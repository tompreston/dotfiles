#!/bin/bash
# Setup debian how I like it
EMAIL="thomas.preston@codethink.co.uk"
DIR_GNUPG="~/.gnupg"
DIR_SSH="~/.ssh"

if ! ls "$DIR_GNUPG" "$DIR_SSH" &>/dev/null; then
	if ! whiptail --yesno "No GPG or SSH keys found. Continue?" 7 60; then
		exit 1
	fi
fi

sudo apt install \
	build-essential \
	exim4 \
	firmware-iwlwifi \
	fonts-inconsolata \
	fonts-nanum \
	fonts-symbola \
	git \
	gnupg2 \
	hexchat \
	openssh-server \
	pass \
	thunderbird \
	tmux \
	vim

if whiptail --yesno "Would you like to generate a new GPG key?" 7 60; then
	gpg2 --full-gen-key
fi
if whiptail --yesno "Would you like to generate a new SSH key?" 7 60; then
	ssh-keygen -t rsa -b 4096 -C $EMAIL
fi

git config --global user.email "thomas.preston@codethink.co.uk"
git config --global user.name "Thomas Preston"

git clone git@gitlab.com:tpreston/journal.git

(cd Documents/
	git clone https://github.com/tompreston/notes;
	git clone https://github.com/tompreston/dotfiles;
	(cd dotfiles; make install))

# vim pathogen and plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

(cd ~/.vim/bundle;
	git clone https://github.com/tpope/vim-sensible.git;
	git clone https://github.com/tpope/vim-surround.git;
	git clone https://github.com/bogado/file-line.git;
	git clone https://github.com/altercation/vim-colors-solarized;
	git clone https://github.com/embear/vim-localvimrc;
	git clone https://github.com/kergoth/vim-bitbake)
