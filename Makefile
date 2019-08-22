.PHONY: install

install:
	stow --target ../.config config
	stow --target ../.local local
	stow --dotfiles --target ../w git-work
	stow --dotfiles bash git tmux
