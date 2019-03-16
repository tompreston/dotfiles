# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export EDITOR="vim"

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gl='git log'

source $HOME/.profile.d/journal.env
source $HOME/.profile.d/sup
