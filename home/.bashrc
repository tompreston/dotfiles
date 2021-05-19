#!/bin/bash
# .bashrc
# Run when an interactive shell that is not a login shell executes.
# When a login shell executes .bash_profile is read first.
# Source this file in .bash_profile
# See `man bash` /INVOCATIONS

export EDITOR="vimx"

# stop pip opening keyring GUIs
# https://github.com/pypa/pip/issues/8090#issuecomment-803363268
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# Don't use stow-symlinks with weechat config, just point right at it. This is
# because Docker can't see outside of the volume, so the symlinks break.
export WEECHAT_HOME="$HOME/.dotfiles/weechat"
export SUP_PATTERN_BEGIN="## Thomas Preston (tpreston)"
export SUP_DIR_IRC_LOGS="$WEECHAT_HOME/logs"
export SUP_DIR_NOTES="$HOME/w/standup"
export JDIR="$HOME/Documents/journal"
export JDIR_ENTRIES="$JDIR/entries"

export HOSTNAME_CT_LT="ct-lt-02087"
HOSTNAME_MBP="tomp-mbp.mynet"

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

ps1()
{
	# Custom PS1 for the following machines
	case "$HOSTNAME" in
	"$HOSTNAME_MBP"|"$HOSTNAME_CT_LT")
		PS1='\w\[\033[33m\]\$\[\033[0m\] '
		return
		;;
	esac
}

pathmunge "$HOME/.local/bin" before
pathmunge "$HOME/.cargo/bin" before
unset -f pathmunge

# trying without PS1 for now (planning on removing it)
#ps1

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
