.PHONY: common debian fedora macos

common:
	stow bash-common tmux vim
	stow config --target ../.config
	stow local --target ../.local

debian: common
	stow bash-debian

fedora: common
	stow bash-fedora

macos: common
	stow bash-macos
