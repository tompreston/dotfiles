[ -f $HOME/src/github.com/monzo/starter-pack/zshrc ] && source $HOME/src/github.com/monzo/starter-pack/zshrc

# NVM settings (tpreston: too slow, so I've removed for now)
#export NVM_DIR="$HOME/.nvm"
#[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

# Set the prompt, with some VCS info
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '[%b]'
precmd () {
	vcs_info
}
PROMPT='%n %3~ %# '
RPROMPT='${vcs_info_msg_0_}'

# Finally set some aliases
alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias l="ls -CF"
alias ls="ls -G"
alias dr="docker run -v $PWD:/w --workdir /w -it circleci/golang:1.16 /bin/bash"
