.PHONY: debian fedora macos

common:
	stow bash-common tmux vim

debian: common
	stow bash-debian

fedora: common
	stow bash-fedora

macos: common
	stow bash-macos
