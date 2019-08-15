.PHONY: install

install:
	stow --adopt --target ../.weechat weechat
	stow --target ../.config config
	stow --target ../.local local
	stow --target ../w git-work
	stow bash git tmux
