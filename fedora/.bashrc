# .bashrc
echo bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export EDITOR="vim"
export PS1='\u:\w\[\033[33m\]\$\[\033[0m\] '

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gl='git log'

#source $HOME/.profile.d/journal.env
#source $HOME/.profile.d/sup
