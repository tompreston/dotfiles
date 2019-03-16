FILES = .profile.d .tmux.conf .vimrc
FILES_DEBIAN = .bash_aliases .bashrc .profile
FILES_FEDORA = .bashrc

.PHONY: install_debian install_fedora export_debian export_fedora

# Debian
install_debian:
	cp -r $(FILES) $(addprefix debian/,$(FILES_DEBIAN)) ~

export_debian:
	cp -r $(addprefix ~/,$(FILES)) .
	cp -r $(addprefix ~/,$(FILES_DEBIAN)) debian/

# Fedora
install_fedora:
	cp -r $(FILES) $(addprefix fedora/,$(FILES_FEDORA)) ~

export_fedora:
	cp -r $(addprefix ~/,$(FILES)) .
	cp -r $(addprefix ~/,$(FILES_FEDORA)) fedora/
