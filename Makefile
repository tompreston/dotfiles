.PHONY: common debian fedora macos

common:
	stow --target ../.config config
	stow --target ../.local local
	stow --dir bash --target .. common
	stow tmux

debian: common
	stow --dir bash --target .. debian

fedora: common
	stow --dir bash --target .. fedora

macos: common
	stow --dir bash --target .. macos
