# .bashrc

# include if file exists
include()
{
	if [ -f "$1" ]; then
		source "$1"
	fi
}

# prepend string if string does not already contain it
pathadd()
{
	declare -r prefix="$1"

	if ! [[ "$PATH" =~ "$prefix" ]]; then
		export PATH="${PATH:+${PATH}:}$prefix"
	fi
}

include "/etc/bashrc"
include "$HOME/.bash_aliases"
include "$HOME/journal/journal.env"

pathadd "$HOME/.local/bin"

export PS1='\w\[\033[33m\]\$\[\033[0m\] '
export EDITOR="nvim"
export SUP_DIR="$HOME/w/standup"
export SUP_LOG_DIR="$HOME/.weechat/logs"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
