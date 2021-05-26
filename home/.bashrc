#!/bin/bash
# .bashrc
# Run when an interactive shell that is not a login shell executes.
# When a login shell executes .bash_profile is read first.
# Source this file in .bash_profile
# See `man bash` /INVOCATIONS

# stop pip opening keyring GUIs
# https://github.com/pypa/pip/issues/8090#issuecomment-803363268
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

export WEECHAT_HOME="$HOME/.dotfiles/weechat"
export SUP_PATTERN_BEGIN="## Thomas Preston (tpreston)"
export SUP_DIR_IRC_LOGS="$WEECHAT_HOME/logs"
export SUP_DIR_NOTES="$HOME/w/standup"
export JDIR="$HOME/Documents/journal"
export JDIR_ENTRIES="$JDIR/entries"

# source these early to avoid contamination, eg. `unset -f pathmunge`
srcs=(
	"/etc/bashrc"
	"$HOME/.bash_aliases"
)
for s in "${srcs[@]}"; do
	test -e "$s" && source "$s"
done

# PATH munge, from Fedora /etc/profile
pathmunge()
{
	case ":${PATH}:" in
	*:"$1":*)
		;;
	*)
		if [ "$2" = "after" ] ; then
			PATH=$PATH:$1
		else
			PATH=$1:$PATH
		fi
		;;
	esac
}

pathmunge "$HOME/.local/bin" before
pathmunge "$HOME/.cargo/bin" before
unset -f pathmunge

# The vimx command has +clipboard for accessing the GUI clipboard registers.
# However, this isn't always present or even necessary on remote machines, in those
# cases, just use vim.
if command -v vimx >/dev/null; then
	export EDITOR="vimx"
	alias vim="vimx"
else
	export EDITOR="vim"
fi

# terraform autocomplete
if command -v terraform >/dev/null; then
	complete -C "$(command -v terraform)" terraform
fi
