#!/bin/bash
# Keep all Bash aliases here, except for vim which is in bashrc.

# exuberant-ctags is found first because /etc/profile.d/snapd.sh is too
# conservative handling PATH.  Instead, we should alias to universal-ctags:
alias ctags="/var/lib/snapd/snap/bin/ctags"

alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias l="ls -CF"
alias ls="ls --color=auto"

# standup edit
alias sup="$EDITOR ~/w/standup.yaml"
