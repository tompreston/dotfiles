#!/bin/bash
# Setup Fedora
EMAIL="thomas.preston@codethink.co.uk"
DIR_GNUPG="~/.gnupg"
DIR_SSH="~/.ssh"

yesno()
{
	local msg="$1"
	#whiptail --yesno "$msg" 7 60
	echo "$msg"
	read
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	else
		return 1
	fi
}

check_keys()
{
	if ! ls "$DIR_GNUPG" "$DIR_SSH" &>/dev/null; then
		if ! yesno "No GPG or SSH keys found. Continue?"; then
			exit 1
		fi
	fi
}

install()
{
	sudo dnf install \
		@developer-tools \
		hexchat \
		moreutils \
		openssh-server \
		pass \
		thunderbird
}

gen_keys()
{
	if yesno "Would you like to generate a new GPG key?"; then
		gpg2 --full-gen-key
	fi
	if yesno "Would you like to generate a new SSH key?"; then
		ssh-keygen -t rsa -b 4096 -C $EMAIL
	fi
}

setup_git()
{
	git config --global user.email "thomas.preston@codethink.co.uk"
	git config --global user.name "Thomas Preston"
}

get_journal()
{
	git clone git@gitlab.com:tpreston/journal.git
}

get_notes()
{
	git clone https://github.com/tompreston/notes Documents/notes2
}

get_dotfiles()
{
	git clone https://github.com/tompreston/dotfiles Documents/dotfiles
	make -C Documents/dotfiles install
}

setup_vim()
{
	# vim pathogen and plugins
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim \
			https://tpo.pe/pathogen.vim

	(cd ~/.vim/bundle;
		git clone https://github.com/tpope/vim-sensible.git;
		git clone https://github.com/tpope/vim-surround.git;
		git clone https://github.com/bogado/file-line.git;
		git clone https://github.com/embear/vim-localvimrc;
		git clone https://github.com/kergoth/vim-bitbake)
}

check_keys
install
gen_keys
setup_git
get_journal
get_notes
get_dotfiles
setup_vim
