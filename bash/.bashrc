# .bashrc
# Run when an interactive shell that is not a login shell executes.
# When a login shell executes .bash_profile is read first.
# Source this file in .bash_profile
# See `man bash` /INVOCATIONS

is_macos()
{
	test "$(uname -s)" = "Darwin"
}

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

ps1()
{
	# Only set PS1 on the following machines
	case "$(hostname)" in
	"tomp-mbp.mynet"|"ct-lt-0xxxx")
		export PS1='\w\[\033[33m\]\$\[\033[0m\] '
		;;
	esac
}

include "/etc/bashrc"
include "$HOME/.bash_aliases"
include "$HOME/journal/journal.env"
if is_macos; then
	include "/usr/local/etc/bash_completion"
fi

pathadd "$HOME/.local/bin"

ps1

export EDITOR="nvim"
export SUP_DIR="$HOME/w/standup"
export SUP_LOG_DIR="$HOME/.weechat/logs"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
