.PHONY: install

install:
	stow --target ../.local local
	stow --dotfiles --target ../w git-work
	stow --dotfiles bash git tmux vim
