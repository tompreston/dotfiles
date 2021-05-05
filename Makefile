WORK_DIR := ../w
.PHONY: install

install:
	stow --target ../.local local
	stow --dotfiles bash git tmux vim
	if [ -e $(WORK_DIR) ]; then \
		stow --dotfiles --target ../w git-work; \
	fi
