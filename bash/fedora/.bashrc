# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f "$HOME/.bash_aliases" ]; then
	source "$HOME/.bash_aliases"
fi

export EDITOR="nvim"
export PS1='\u:\w\[\033[33m\]\$\[\033[0m\] '

export SUP_DIR="$HOME/w/standup"
export SUP_LOG_DIR="$HOME/.weechat/logs"

source "$HOME/journal/journal.env"
