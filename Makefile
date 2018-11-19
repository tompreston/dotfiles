FILES = .bash_aliases .bashrc .profile .profile.d .tmux.conf .vimrc

.PHONY: install export

install:
	cp -r $(FILES) ~

export:
	cp -r $(addprefix ~/,$(FILES)) .
