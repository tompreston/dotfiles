WORK_DIR := ../w
.PHONY: install

install:
	stow home
	if [ -e $(WORK_DIR) ]; then \
		stow --target $(WORK_DIR) work; \
	fi
