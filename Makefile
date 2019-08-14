.PHONY: common debian fedora macos

common:
	stow --adopt --target ../.weechat weechat
	stow --target ../.config config
	stow --target ../.local local
	stow --dir bash --target .. common
	stow --target ../w git-work
	stow git tmux

debian: common
	stow --dir bash --target .. debian

fedora: common
	stow --dir bash --target .. fedora

macos: common
	stow --dir bash --target .. macos
