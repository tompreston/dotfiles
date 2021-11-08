# TODO Up to line 7 was added by Monzo scripts and now zsh takes ages to start
# Investigate this.
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
[ -f $HOME/src/github.com/monzo/starter-pack/zshrc ] && source $HOME/src/github.com/monzo/starter-pack/zshrc
# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias l="ls -CF"
alias ls="ls -G"
